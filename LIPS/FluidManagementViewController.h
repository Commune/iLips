//
//  FluidManagementViewController.h
//  LIPS
//
//  Created by David Herzka on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FluidManagementViewController : UIViewController {
    
    IBOutlet UISlider *CVPSlider;
    IBOutlet UISlider *urineSlider;
    IBOutlet UISlider *MAPSlider;

    IBOutlet UILabel *CVPLabel;
    IBOutlet UILabel *urineLabel;
    IBOutlet UILabel *MAPLabel;
    
    IBOutlet UISwitch *vasopressorSwitch;

    IBOutlet UILabel *treatmentLabel;
    
    IBOutlet UILabel *updateLabel;
	
	IBOutletCollection(UIView) NSArray *CVPUnknownOutlets;
	IBOutletCollection(UIView) NSArray *CVPKnownOutlets;
	
	BOOL CVPKnown;
}

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)ignore;
-(IBAction)cvpUnknown:(id)sender;
-(IBAction)cvpKnown:(UISwitch*)sender;

@end
