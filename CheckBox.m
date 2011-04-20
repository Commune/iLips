//
//  CheckBox.m
//  LIPS
//
//  Created by David Herzka on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckBox.h"


@implementation CheckBox

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder onText:@"" onImage:[UIImage imageNamed:@"CheckBoxChecked.png"] offText:@"" offImage:[UIImage imageNamed:@"CheckBoxUnChecked.png"]];
	return self;
}

@end
