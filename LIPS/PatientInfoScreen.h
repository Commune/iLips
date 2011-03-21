//
//  PatientInfoScreen.h
//  LIPS
//
//  Created by Duke Student on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "DataEntryController.h"


@interface PatientInfoScreen : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	IBOutlet UISegmentedControl *sex;
	IBOutlet UISlider *height;
	IBOutlet UISlider *weight;
	IBOutlet UIButton *submit;
	IBOutlet UILabel *heightVal;
	IBOutlet UILabel *weightVal;
	IBOutlet UISegmentedControl *infectionPresent;
	IBOutlet UILabel *infectionLocationLabel;
	IBOutlet UIPickerView *infectionSource;
	IBOutlet UISegmentedControl *patientLocation;
	
	NSMutableArray *infectionLocations;
	NSString *infecLoc;
	
	Patient *patient;
    
}

-(IBAction) submit:(id)sender;
-(IBAction) heightValChanged:(UISlider *) sender;
-(IBAction) weightValChanged:(UISlider *) sender;
-(IBAction) infectionChanged:(UISegmentedControl *) sender;

@end
