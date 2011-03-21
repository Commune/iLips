//
//  Patient.m
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Patient.h"


@implementation Patient


- (id) init {
	if (!conditionFlags) {
		NSMutableArray* temp = [NSMutableArray array];
		for (int i = 0; i < 22; i++) {
			[temp addObject:[NSNumber numberWithBool:NO]];
		}
		conditionFlags = [[NSArray alloc] initWithArray:temp];
	}
	return NULL;
}

-(BOOL)checkCondition:(id)sender:(int)conditionNumber {
	NSNumber *result = [conditionFlags objectAtIndex:conditionNumber];
	if (result == 0) {
		return FALSE;
	} else {
		return TRUE;
	}
}

@synthesize height, weight, sex;

@end
