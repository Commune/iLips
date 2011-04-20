//
//  YesNoButton.m
//  LIPS
//
//  Created by David Herzka on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YesNoButton.h"

@implementation YesNoButton

@dynamic on;

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if(self) {
		[self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
		[self setOn:NO];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

-(void)setOn:(BOOL)o {
	on = o;
	if(on) {
		[self setBackgroundImage:[UIImage imageNamed:@"GreenButton.png"] forState:UIControlStateNormal];
		[self setTitle:@"YES" forState:UIControlStateNormal];
	} else {
		[self setBackgroundImage:[UIImage imageNamed:@"RedButton.png"] forState:UIControlStateNormal];
		[self setTitle:@"NO" forState:UIControlStateNormal];
	}
}

-(BOOL)on {
	return on;
}

-(void)toggle {
	self.on = !self.on;
}

@end
