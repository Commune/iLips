#import <Foundation/Foundation.h>

@class Patient;

@interface DecisionFetcher : NSObject {
}
+(UIViewController*)fetchNextViewAfter:(NSString*)nodeName;
+(UIViewController*)fetchViewForNode:(NSString*)nodeName;
+(void)assignResponse:(NSString*)questionName withValue:(NSString*)value;
+(NSString*)responseForQuestion:(NSString*)question;
+(void)resetDecisions;
+(void)addPatientProperties:(Patient*)aPatient;
+(Patient *)patient;
@end
