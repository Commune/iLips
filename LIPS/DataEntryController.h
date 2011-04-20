//
//  DataEntryController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
@class YesNoButton;	

@interface DataEntryController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIView *portraitView;
    UIView *landscapeView;
	
	IBOutlet YesNoButton *shockSwitch;
	IBOutlet YesNoButton *aspirationSwitch;
	IBOutlet YesNoButton *sepsisSwitch;
	IBOutlet YesNoButton *pneumoniaSwitch;
	IBOutlet YesNoButton *spineSwitch;
	IBOutlet YesNoButton *abdomenSwitch;
	IBOutlet YesNoButton *cardiacSwitch;
	IBOutlet YesNoButton *vascularSwitch;
	IBOutlet YesNoButton *emergencySwitch;
	IBOutlet YesNoButton *brainSwitch;
	IBOutlet YesNoButton *smokeSwitch;
	IBOutlet YesNoButton *drowningSwitch;
    IBOutlet YesNoButton *contusionSwitch;
	IBOutlet YesNoButton *fracturesSwitch;
	IBOutlet YesNoButton *alchySwitch;
	IBOutlet YesNoButton *hypoSwitch;
	IBOutlet YesNoButton *chemoSwitch;
	IBOutlet YesNoButton *fio2Switch;
	IBOutlet YesNoButton *tachSwitch;
    IBOutlet YesNoButton *spo2Switch;
	IBOutlet YesNoButton *acidosisSwitch;
	IBOutlet YesNoButton *diabetesSwitch;
	IBOutlet YesNoButton *vasoactiveSwitch;
	IBOutlet YesNoButton *bleedingSwitch;
	
	
	IBOutlet YesNoButton *infectionPresent;
	IBOutlet UIPickerView *infectionSource;
	IBOutlet UILabel *sepsisLabel;
	IBOutlet UILabel *pneumoniaLabel;
	
	Patient *thePatient;
	
	NSMutableArray *infectionLocations;
	NSString *infecLoc;
	BOOL infection;

}

-(IBAction)submit:(id)sender;
-(id)initWithPatient:(Patient *)p;
-(IBAction) valueChanged:(id)sender;
-(IBAction) infectionChanged:(YesNoButton *)sender;

@end
