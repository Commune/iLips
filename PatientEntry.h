//
//  PatientEntry.h
//  LIPS
//
//  Created by David Herzka on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PatientEntry : NSObject {
    NSString *patientID;
	NSString *data;
}

@property (readwrite,retain) NSString *patientID;
@property (readwrite,retain) NSString *data;

-(id)initWithId:(NSString*)pid data:(NSString*)d;

@end
