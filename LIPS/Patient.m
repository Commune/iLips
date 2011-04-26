//
//  Patient.m
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"
#import "DecisionFetcher.h"
#import "MysqlConnection.h"
#import "MysqlInsert.h"
#import "MysqlDelete.h"
#import "MysqlException.h"
#import "MysqlFetch.h"
#import "TargetConditionals.h"

@implementation Patient


/*
 Initializes a patient with information from basic data entry screen
 */
-(Patient *)initWithGender:(PatientGender)g height:(float)h weight:(float)w location:(int)patientLoc day:(float)d patientIdent:(unsigned long long)p {
	self.gender = g;
	height = h;
	weight = w;
	dayHospital = d;
	pid = p;
	patientLocation = [self getPatientLocation:patientLoc];
	[self initializeSymptoms];
	[self getAdditionalRisks];	
	patientID = [[NSString stringWithFormat:@"%d",[[NSDate date] timeIntervalSince1970]] retain];
	infectionLocation = [[NSString alloc] init];
	return self;
}

/*
 Returns internal name for patient location from the index of a segment of the segmented control on the patient info screen
 */
-(NSString *)getPatientLocation:(int)patientLoc {
	if (patientLoc == 0) {
		return @"ICU";
	} else if (patientLoc == 1) {
		return @"PACU";
	} else if (patientLoc == 2) {
		return @"OR";
	} else if (patientLoc == 3) {
		return @"Floor";
	} else if (patientLoc == 4) {
		return @"ER";
	} else {
		return nil;
	}
}

/*
 Loads the patient symptoms with LIPS score weights and initial values from a plist
 */
-(void)initializeSymptoms {
	NSString *finalPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"conditions.plist"];
	symptoms = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
}

-(void)setInfectionLocation:(NSString *)infecLoc {
	infectionLocation = [infecLoc retain];
}

-(NSString *)infectionLocation {
	return infectionLocation;
}

-(void) printSelf {
	NSString *genderString;
	if (gender == PatientGenderMale) {
		genderString = @"I am a male!\n";
	} else {
		genderString = @"I am a female!\n";
	}
	
	NSString *mesurements = [NSString stringWithFormat:@"\nI am %0.0f inches tall, and weigh %0.1f kilograms.", height, weight];
	NSString *pLoc = [NSString stringWithFormat:@"\nI am currently located in the %@", patientLocation];
	NSString *iLoc = [NSString stringWithFormat:@"\nMy infection is currently located in my %@", infectionLocation];
	NSString *conditionTitle = @"\nConditions:\n";
	NSString *conditions = [self getConditions];
	NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@%@", gender, mesurements, pLoc, iLoc, conditionTitle, conditions];
	NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	[result writeToFile:[path stringByAppendingPathComponent:@"output.txt"] atomically:NO encoding:NSUTF8StringEncoding error:nil];
	NSString *file = [[[NSString alloc] initWithContentsOfFile:[path stringByAppendingPathComponent:@"output.txt"] encoding:NSUTF8StringEncoding error:nil] autorelease];
	NSLog(@"%@", file);
}

-(NSString *)getConditions {
	NSString *result = [[[NSString alloc] init] autorelease];
	NSEnumerator *enumerator = [symptoms keyEnumerator];
	NSString *key;
	while ((key = [enumerator nextObject])) {
		NSMutableDictionary *condition = [symptoms objectForKey:key];
		if ([condition objectForKey:@"Present"] == [NSNumber numberWithInt:YES]) {
			result = [result stringByAppendingString:[NSString stringWithFormat:@"\n%@", key]];
		}
	}
	return result;
}

-(float)calculateScore {
	float total = 0;
	NSEnumerator *enumerator = [symptoms keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		NSMutableDictionary *condition = [symptoms objectForKey:key];
		if ([condition objectForKey:@"Present"] == [NSNumber numberWithInt:1]) {
			total += [[condition objectForKey:@"Risk Factor"] floatValue];
		}
	}
	total += [self getAdditionalRisks];
	return total;
}

-(float)getAdditionalRisks {
	int bmi = weight / powf(height, 2);
	NSMutableDictionary *condition  = [symptoms objectForKey:@"Obesity"];
	if (bmi > 30) {
		[condition setObject:[NSNumber numberWithBool:YES] forKey:@"Present"];
		[symptoms setValue:condition forKey:@"Obesity"];
		return 1;
	} else {
		return 0;
	}
}

-(void)tripCondition:(NSString *)symptom:(int)present {
	NSMutableDictionary *condition = [symptoms objectForKey:symptom];
	[condition setObject:[NSNumber numberWithInt:present] forKey:@"Present"];
	[symptoms setValue:condition forKey:symptom];
}

-(NSString *)getID {
	return patientID;
}

-(MysqlConnection *)connectToMysql {
	NSString *host = @"eclip196.db.7093929.hostedresource.com";
	NSString *user = @"eclip196";
	NSString *pass = @"Clip196";
	NSString *schema = @"eclip196";
	long flags = MYSQL_DEFAULT_CONNECTION_FLAGS;
	if(!TARGET_IPHONE_SIMULATOR) {
		MysqlConnection *connection = [MysqlConnection connectToHost:host user:user password:pass schema:schema flags:flags];
		return connection;
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mysql Connect" message:@"The MySQL library cannot be used in the iPhone simulator.  No data will be sent or received from the daily LIPS database." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return nil;
	}
}


-(BOOL) submitToDatabase {
	MysqlConnection *connection;
	if(!(connection = [self connectToMysql])) 
		return NO;
	NSString *idString = [NSString stringWithFormat:@"%qu",self.pid];
	NSNumber *dayNumber = [NSNumber numberWithInt:(int)dayHospital];
	
	// To remove previous data matching id and day of hospitalization
	MysqlDelete *delete = [MysqlDelete deleteWithConnection:connection];
	delete.tableName = @"dailyLIPS";
	delete.qualifier = [[NSString stringWithFormat:@"id = %@ AND day=%@",idString,dayNumber] retain];
	
	// To insert new data
	MysqlInsert *insert = [MysqlInsert insertWithConnection:connection];
	NSNumber *scoreNumber = [NSNumber numberWithFloat:[self calculateScore]];
	NSDate *date = [NSDate date];
	insert.rowData = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"id",dayNumber,@"day",scoreNumber,@"score",[date description],@"time", nil];
	insert.table = @"dailyLIPS";
	
	
	
	@try 
	{
		[delete execute];
		[insert execute];
	}
	@catch(MysqlException *exception)
	{
		return NO;
	}
	
	return YES;
}

-(NSDictionary *) dailyLIPS {
	MysqlConnection *connection;
	if(!(connection = [self connectToMysql])) 
		return NO;
	NSString *query = [NSString stringWithFormat:@"SELECT day,score FROM dailyLIPS where id='%qu' ORDER BY day ASC",pid];
	MysqlFetch *fetch = [MysqlFetch fetchWithCommand:query onConnection:connection];
	NSMutableDictionary *dailyLIPS = [[NSMutableDictionary alloc] init];
	for(NSDictionary *row in fetch.results) {
		[dailyLIPS setObject:[row objectForKey:@"score"] forKey:[row objectForKey:@"day"]];
	}
	return dailyLIPS;
}


-(BOOL)conservativeFluids {
	NSMutableDictionary *bleeding = [symptoms objectForKey:@"Active Bleeding"];
	NSMutableDictionary *vasoactive = [symptoms objectForKey:@"Vasoactive Medication"];
	NSMutableDictionary *shock = [symptoms objectForKey:@"Shock"];
	if ([[bleeding objectForKey:@"Present"] isEqualToNumber:[NSNumber numberWithBool:NO]] && [[vasoactive objectForKey:@"Present"] isEqualToNumber:[NSNumber numberWithBool:NO]] && [[shock objectForKey:@"Present"] isEqualToNumber:[NSNumber numberWithInt:NO]]) {
		return YES;
	} else {
		return NO;
	}
	
}

@dynamic infectionLocation;
@synthesize height, weight, gender, patientLocation, symptoms, pid, dayHospital;

@end
