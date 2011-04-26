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
    UIViewController<DecisionTreeView> *nextView = [viewClass alloc];
	[nextView initWithName:nodeName title:[viewDescription objectForKey:@"Title"] arguments:[viewDescription objectForKey:@"Arguments"]];
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
		
		if([patient.patientLocation isEqualToString:@"ICU"]) {
			[self assignResponse:@"ICU Likely" withValue:@"Already in ICU"];
		}
		
	}
}

+(NSString *)responseForQuestion:(NSString *)question {
	return [responses objectForKey:question];
}

+(Patient *)patient {
	return patient;
}

@end
