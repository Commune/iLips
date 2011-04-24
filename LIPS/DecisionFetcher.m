//
//  DecisionFetcher.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecisionFetcher.h"
#import "BinaryDecisionViewController.h"
#import "Patient.h"

@implementation DecisionFetcher

static NSDictionary *treatments;
static NSDictionary *views;
static NSMutableDictionary *responses;
static Patient *patient;

+(void)initialize {
    if(!treatments) {
        NSString *finalPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"treatments.plist"];
        treatments = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
    }
    
    if(!views) {
        NSString *finalPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"views.plist"];
        views = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
    }
    
    if(!responses) {
        [self resetDecisions];
    }
}


+(void)resetDecisions {
    responses = [[[NSMutableDictionary alloc] init] retain];
	[self addPatientProperties:patient];
}

+(UIViewController *)fetchNextViewAfter:(NSString *)nodeName {
//    NSLog(@"%@",treatments);
//    NSLog(@"%@",views);
//    NSLog(@"%@",responses);
	
    while ([responses objectForKey:nodeName]) {
        NSDictionary *treatmentOptions = [treatments objectForKey:nodeName];
        nodeName = [treatmentOptions objectForKey:[responses objectForKey:nodeName]];
    }
	
	return [self fetchViewForNode:nodeName];
}

+(UIViewController *)fetchViewForNode:(NSString *)nodeName 
{
	NSDictionary *viewDescription = [views objectForKey:nodeName];
    NSString *viewClassName = [viewDescription objectForKey:@"Class"];
    Class viewClass = NSClassFromString(viewClassName);
    UIViewController *nextView = [[viewClass alloc] initWithName:nodeName title:[viewDescription objectForKey:@"Title"] arguments:[viewDescription objectForKey:@"Arguments"]];
	return nextView;
}

+(void)assignResponse:(NSString *)questionName withValue:(NSString *)value {
    [responses setObject:value forKey:questionName];
}

+(void)addPatientProperties:(Patient *)aPatient {
	if(aPatient) {
		patient = aPatient;
		[patient retain];
		NSMutableDictionary *shockDict = [patient.symptoms objectForKey:@"Shock"];
		BOOL shock = NO;
		if ([[shockDict objectForKey:@"Present"] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
			shock = YES;
		}
		
		[self assignResponse:@"Infection" withValue:[patient.infectionLocation isEqualToString:@""]?@"No":@"Yes"];
		[self assignResponse:@"Infection Location" withValue:patient.infectionLocation];
		[self assignResponse:@"Patient Location" withValue:patient.patientLocation];
		[self assignResponse:@"Shock" withValue:shock?@"Yes":@"No"];
	}
}

+(NSString *)responseForQuestion:(NSString *)question {
	return [responses objectForKey:question];
}

+(Patient *)patient {
	return patient;
}

@end
