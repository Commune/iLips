//
//  Patient.h
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQLiteAdapter;

@interface Patient : NSObject {
	NSMutableDictionary *symptoms;
	
	float height;
	float weight;
	int sex;
	
	NSString *patientLocation;
	NSString *infectionLocation;
	
	SQLiteAdapter *sqliteAdapter;
	
	NSString *patientID;
	
}

-(Patient *)initWithParams:(int)gender:(float)h:(float)w:(int)patientLoc:(NSString *)infectionLoc;
-(void)printSelf;
-(float)getAdditionalRisks;
-(void)initializeSymptoms;
-(NSString *)getPatientLocation:(int)ploc;
-(void)tripCondition:(NSString *)symptom:(int)present;
-(float)calculateScore;
-(NSString *)getConditions;
-(NSString *)toJSON;
-(NSString *)getID;
-(int)addToLocalDatabase;

@property (assign) int sex;
@property (assign) float weight, height;
@property (assign) NSString *patientLocation, *infectionLocation;

@end
