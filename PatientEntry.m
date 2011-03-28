//
//  PatientEntry.m
//  LIPS
//
//  Created by David Herzka on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PatientEntry.h"


@implementation PatientEntry

@synthesize patientID;
@synthesize data;

-(id)initWithId:(NSString *)pid data:(NSString *)d {
	self = [self init];
	if(self) {
		patientID = [pid retain];
		data = [d retain];
	}
	return self;
}

@end
