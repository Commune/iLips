//
//  YesNoButton.h
//  LIPS
//
//  Created by David Herzka on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YesNoButton : UIButton {
    BOOL on;
}

-(void)setOn:(BOOL)o;
-(BOOL)isOn;
@end
