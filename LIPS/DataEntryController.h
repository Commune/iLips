//
//  DataEntryController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"


@interface DataEntryController : UIViewController {
    NSArray *lipsVals;
	NSMutableArray *lipsFlags;
    UIView *portraitView;
    UIView *landscapeView;
	
	IBOutlet UISwitch *shockSwitch;
	
	Patient *thePatient;
}

-(IBAction) submit:(id)sender;
-(id)initWithPatient:(Patient *)p;

@end
