//
//  DecisionFetcher.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecisionFetcher.h"
#import "BinaryDecisionViewController.h"

@implementation DecisionFetcher

static NSDictionary *treatments;
static NSDictionary *views;
static NSMutableDictionary *responses;

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
}

+(UIViewController *)fetchNextViewAfter:(NSString *)nodeName {
    NSLog(@"%@",treatments);
    NSLog(@"%@",views);
    NSLog(@"%@",responses);

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
    UIViewController *nextView = [[viewClass alloc] initWithName:nodeName arguments:[viewDescription objectForKey:@"Arguments"]];
	return nextView;
}

+(void)assignResponse:(NSString *)questionName withValue:(NSString *)value {
    [responses setObject:value forKey:questionName];
}

@end
