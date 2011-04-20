//
//  YesNoButton.m
//  LIPS
//
//  Created by David Herzka on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YesNoButton.h"

@implementation YesNoButton

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder onText:@"YES" onImage:[UIImage imageNamed:@"GreenButton.png"] offText:@"NO" offImage:[UIImage imageNamed:@"RedButton.png"]];
	return self;
}

@end
