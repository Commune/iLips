//
//  Patient.h
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Patient : NSObject {
    NSArray *conditionFlags;
	float height;
	float weight;
	int sex;
	NSString *patientLocation;
	NSString *infectionLocation;
}

-(BOOL)checkCondition:(int)conditionNumber;
-(Patient *)initWithParams:(int)gender:(float)h:(float)w:(int)patientLoc:(NSString *)infectionLoc;
-(void)printSelf;

@property (assign) int sex;
@property (assign) float weight, height;

@end
