//
//  Patient.h
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Patient : NSObject {
	NSDictionary *symptoms;
	
	float height;
	float weight;
	int sex;
	
	NSString *patientLocation;
	NSString *infectionLocation;
	
}

-(Patient *)initWithParams:(int)gender:(float)h:(float)w:(int)patientLoc:(NSString *)infectionLoc;
-(void)printSelf;
-(int)getAdditionalRisks;
-(void)initializeSymptoms;
-(NSString *)getPatientLocation:(int)ploc;

@property (assign) int sex;
@property (assign) float weight, height;

@end
