//
//  Patient.h
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQLiteAdapter;

typedef enum {PatientGenderMale,PatientGenderFemale}PatientGender;

@interface Patient : NSObject {
	NSMutableDictionary *symptoms;
	
	float height;
	float weight;
	PatientGender gender;
	
	NSString *patientLocation;
	NSString *infectionLocation;
	
	SQLiteAdapter *sqliteAdapter;
	
	NSString *patientID;
	
}

-(Patient *)initWithGender:(PatientGender)gender height:(float)h weight:(float)w location:(int)patientLoc;
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
-(void)setInfectionLocation:(NSString *)infecLoc;
-(BOOL)conservativeFluids;

@property (assign) PatientGender gender;
@property (assign) float weight, height;
@property (assign) NSString *patientLocation, *infectionLocation;
@property (assign) NSMutableDictionary *symptoms;

@end
