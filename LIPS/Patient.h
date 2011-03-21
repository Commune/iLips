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
	int height;
	int weight;
	int sex;
}

-(BOOL)checkCondition:(id)sender:(int)conditionNumber;

@property (assign) int height, weight, sex;

@end
