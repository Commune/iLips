//
//  ToggleButton.m
//  LIPS
//
//  Created by David Herzka on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToggleButton.h"


@implementation ToggleButton
@dynamic on;
@synthesize onText=_onText,onImage=_onImage,offText=_offText,offImage=_offImage;

-(id)initWithCoder:(NSCoder *)aDecoder onText:(NSString *)onText onImage:(UIImage *)onImage offText:(NSString *)offText offImage:(UIImage *)offImage {
	self = [super initWithCoder:aDecoder];
	if(self) {
		self.onImage = onImage;
		self.onText = onText;
		self.offImage = offImage;
		self.offText = offText;
		[self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
		self.backgroundColor = [UIColor clearColor];
		[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		self.on = NO;
	}
	return self;
}

-(void)setOn:(BOOL)o {
	on = o;
	if(on) {
		[self setBackgroundImage:self.onImage forState:UIControlStateNormal];
		[self setTitle:self.onText forState:UIControlStateNormal];
	} else {
		[self setBackgroundImage:self.offImage forState:UIControlStateNormal];
		[self setTitle:self.offText forState:UIControlStateNormal];
	}
}

-(BOOL)on {
	return on;
}

-(void)toggle {
	self.on = !self.on;
}
@end
