//
//  DataEntryController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DataEntryController : UIViewController {
    NSArray *lipsVals;
	NSArray *lipsFlags;
    UIView *portraitView;
    UIView *landscapeView;
	
	IBOutlet UISwitch *shockSwitch;
}

-(IBAction) submit:(id)sender;

@end
