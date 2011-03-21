//
//  PatientInfoScreen.h
//  LIPS
//
//  Created by Duke Student on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"


@interface PatientInfoScreen : UIViewController {
	IBOutlet UISegmentedControl *sex;
	IBOutlet UISlider *height;
	IBOutlet UISlider *weight;
	IBOutlet UIButton *submit;
	
	Patient *patient;
    
}

-(IBAction) submit:(id)sender;

@end
