//
//  NSString_DB.m
//  Circles
//
//  Created by David Herzka on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+DB.h"


@implementation NSString (NSString_DB)
-(NSString*) stringBySanitizing {
    NSString * sanitized = [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return sanitized;
}

-(NSString*) stringByRestoring {
    NSString * restored = [self stringByReplacingOccurrencesOfString:@"''" withString:@"'"];
    return restored;
}
@end
