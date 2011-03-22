//
//  DecisionFetcher.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DecisionFetcher : NSObject {
     
}
+(UIViewController*)fetchNextViewAfter:(NSString*)nodeName;
+(UIViewController*)fetchViewForNode:(NSString*)nodeName;
+(void)assignResponse:(NSString*)questionName withValue:(NSString*)value;
+(void)resetDecisions;
@end
