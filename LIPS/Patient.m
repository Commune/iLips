//
//  Patient.m
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"
 

@implementation Patient


-(Patient *)initWithParams:(int)gender:(float)h:(float)w:(int)patientLoc:(NSString *)infectionLoc {
	sex = gender;
	height = h;
	weight = w;
	infectionLocation = [[NSString alloc] initWithString:infectionLoc];
	patientLocation = [self getPatientLocation:patientLoc];
	[self initializeSymptoms];
	[self getAdditionalRisks];	
	return self;
}

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

-(void)initializeSymptoms {
	NSString *finalPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"conditions.plist"];
	symptoms = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
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
	NSString *symp = [NSString stringWithFormat:@"%@", symptoms];
	NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@", gender, mesurements, pLoc, iLoc, symp];
	NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(float)calculateScore {
	float total = 0;
	NSEnumerator *enumerator = [symptoms keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		NSMutableDictionary *condition = [symptoms objectForKey:key];
		if ([condition objectForKey:@"Present"] == [NSNumber numberWithInt:YES]) {
			total += [[condition objectForKey:@"Risk Factor"] floatValue];
		}
	}
	total += [self getAdditionalRisks];
	return total;
}

-(float)getAdditionalRisks {
	float mheight = height * 0.0254;
	int bmi = weight / powf(mheight, 2);
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

@synthesize height, weight, sex;

@end
