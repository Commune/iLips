//
//  DataEntryController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"


@interface DataEntryController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIView *portraitView;
    UIView *landscapeView;
	
	IBOutlet UISwitch *shockSwitch;
	IBOutlet UISwitch *aspirationSwitch;
	IBOutlet UISwitch *sepsisSwitch;
	IBOutlet UISwitch *pneumoniaSwitch;
	IBOutlet UISwitch *spineSwitch;
	IBOutlet UISwitch *cardiacSwitch;
	IBOutlet UISwitch *vascularSwitch;
	IBOutlet UISwitch *abdomenSwitch;
	IBOutlet UISwitch *brainSwitch;
	IBOutlet UISwitch *smokeSwitch;
	IBOutlet UISwitch *drowningSwitch;
	IBOutlet UISwitch *contusionSwitch;
	IBOutlet UISwitch *fracturesSwitch;
	IBOutlet UISwitch *alchySwitch;
	IBOutlet UISwitch *hypoSwitch;
	IBOutlet UISwitch *chemoSwitch;
	IBOutlet UISwitch *fio2Switch;
	IBOutlet UISwitch *tachSwitch;
	IBOutlet UISwitch *spo2Switch;
	IBOutlet UISwitch *acidosisSwitch;
	IBOutlet UISwitch *diabetesSwitch;
	IBOutlet UISwitch *emergencySwitch;
	
	IBOutlet UISegmentedControl *infectionPresent;
	IBOutlet UIPickerView *infectionSource;
	IBOutlet UILabel *sepsisLabel;
	IBOutlet UILabel *pneumoniaLabel;
	
	Patient *thePatient;
	
	NSMutableArray *infectionLocations;
	NSString *infecLoc;
	BOOL infection;

}

-(IBAction) submit:(id)sender;
-(id)initWithPatient:(Patient *)p;
-(IBAction) valueChanged:(id)sender;

@end
