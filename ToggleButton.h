//
//  ToggleButton.h
//  LIPS
//
//  Created by David Herzka on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ToggleButton : UIButton {
	BOOL on;
	NSString *_onText;
	NSString *_offText;
	UIImage *_onImage;
	UIImage *_offImage;
}

@property (readwrite) BOOL on;
@property (retain,nonatomic) NSString *onText;
@property (retain,nonatomic) NSString *offText;
@property (retain,nonatomic) UIImage *onImage;
@property (retain,nonatomic) UIImage *offImage;

-(id)initWithCoder:(NSCoder *)aDecoder onText:(NSString *)onText onImage:(UIImage *)onImage offText:(NSString *)offText offImage:(UIImage *)offImage;

@end
