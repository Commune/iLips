//
//  Patient.h
//  LIPS
//
//  Created by Duke Student on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	PatientGenderMale,
	PatientGenderFemale
}PatientGender;

@interface Patient : NSObject {
	NSMutableDictionary *symptoms;
	
	float height;
	float weight;
	float dayHospital;
	unsigned long long pid;
	PatientGender gender;
	
	NSString *patientLocation;
	NSString *infectionLocation;
	
	NSString *patientID;
	
}

-(Patient *)initWithGender:(PatientGender)gender height:(float)h weight:(float)w location:(int)patientLoc day:(float)d patientIdent:(unsigned long long)p;
-(void)printSelf;
-(float)getAdditionalRisks;
-(void)initializeSymptoms;
-(NSString *)getPatientLocation:(int)ploc;
-(void)tripCondition:(NSString *)symptom:(int)present;
-(float)calculateScore;
-(NSString *)getConditions;
-(NSString *)getID;
-(void)setInfectionLocation:(NSString *)infecLoc;
-(BOOL)conservativeFluids;
-(BOOL)submitToDatabase;
-(NSDictionary *)dailyLIPS;

@property (assign) PatientGender gender;
@property (assign) float weight, height, dayHospital;
@property (assign) unsigned long long pid;
@property (assign) NSString *patientLocation, *infectionLocation;
@property (assign) NSMutableDictionary *symptoms;

@end
