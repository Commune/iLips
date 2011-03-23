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
	if (!conditionFlags) {
		NSMutableArray* temp = [NSMutableArray array];
		for (int i = 0; i < 22; i++) {
			[temp addObject:[NSNumber numberWithBool:NO]];
		}
		conditionFlags = [[NSArray alloc] initWithArray:temp];
	}
	sex = gender;
	height = h;
	weight = w;
	infectionLocation = [[NSString alloc] initWithString:infectionLoc];
	if (patientLoc == 0) {
		patientLocation = @"ICU";
	} else if (patientLoc == 1) {
		patientLocation = @"PACU";
	} else if (patientLoc == 2) {
		patientLocation = @"OR";
	}
	
	return self;
}

-(BOOL)checkCondition:(int)conditionNumber {
	NSNumber *result = [conditionFlags objectAtIndex:conditionNumber];
	if (result == 0) {
		return FALSE;
	} else {
		return TRUE;
	}
}

-(void) printSelf {
	if (sex == 0) {
		NSLog(@"I am a male!");
	} else {
		NSLog(@"I am a female!");
	}
	
	NSLog(@"I weigh exactly %0.1f kilograms, and am %0.0f inches tall", weight, height);
	NSLog(@"I am currently located in the %@", patientLocation);
	NSLog(@"My infection is currently located in my %@", infectionLocation);
	NSLog(@"%@", [conditionFlags componentsJoinedByString:@" "]);
}

-(void)setConditionsArray:(NSMutableArray *)conditions {
	conditionFlags = conditions;
}

-(int)getAdditionalRisks {
	float mheight = height * 0.0254;
	NSLog(@"%f", mheight);
	int bmi = weight / powf(mheight, 2);
	NSLog(@"%d", bmi);
	if (bmi > 30) {
		return 1;
	} else {
		return 0;
	}
}

@synthesize height, weight, sex;

@end
