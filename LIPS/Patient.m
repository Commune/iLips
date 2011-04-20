//
//  Patient.m
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"
#import "JSON.h"
#import "SQLiteAdapter.h"
#import "PatientEntry.h"
#import "DecisionFetcher.h"

@implementation Patient

/*
 Initializes a patient with information from basic data entry screen
 */
-(Patient *)initWithParams:(int)gender:(float)h:(float)w:(int)patientLoc{
	sex = gender;
	height = h;
	weight = w;
	patientLocation = [self getPatientLocation:patientLoc];
	[self initializeSymptoms];
	[self getAdditionalRisks];	
	sqliteAdapter = [[SQLiteAdapter alloc] init];
	patientID = [[NSString stringWithFormat:@"%d",[[NSDate date] timeIntervalSince1970]] retain];
	infectionLocation = [[NSString alloc] init];
	[DecisionFetcher addPatientProperties:self];
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
	[infectionLocation initWithString:infecLoc];
}

-(NSString *)infectionLocation {
	return infectionLocation;
}

-(void) printSelf {
	NSString *gender;
	if (sex == 0) {
		gender = @"I am a male!\n";
	} else {
		gender = @"I am a female!\n";
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


-(NSString *)toJSON {
	NSMutableDictionary *allPatientData = [[[NSMutableDictionary alloc] init] autorelease];
	[allPatientData setObject:[NSNumber numberWithFloat:height] forKey:@"Height"];
	[allPatientData setObject:[NSNumber numberWithFloat:weight] forKey:@"Weight"];
	[allPatientData setObject:[NSNumber numberWithInt:sex] forKey:@"Sex"];
	[allPatientData setObject:patientLocation forKey:@"Patient Location"];
	[allPatientData setObject:infectionLocation forKey:@"Infection Location"];
	[allPatientData setObject:symptoms forKey:@"Symptoms"];
	return [allPatientData JSONRepresentation];
}

-(NSString *)getID {
	return patientID;
}

-(int)addToLocalDatabase {
	PatientEntry *patient = [[[PatientEntry alloc] initWithId:[self getID] data:[self toJSON]] autorelease];
	[sqliteAdapter deletePatient:patient];
	int ret = [sqliteAdapter addPatient:patient];
	return ret;
}

@dynamic infectionLocation;
@synthesize height, weight, sex, patientLocation;

@end
