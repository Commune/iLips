#import <UIKit/UIKit.h>
#import "Patient.h"
#import "DataEntryController.h"


@interface PatientInfoScreen : UIViewController {
	IBOutlet UISegmentedControl *sex;
	IBOutlet UISlider *height;
	IBOutlet UISlider *weight;
	IBOutlet UIButton *submit;
	IBOutlet UILabel *heightVal;
	IBOutlet UILabel *weightVal;
	IBOutlet UITextField *heightText;
	IBOutlet UITextField *weightText;
	IBOutlet UISegmentedControl *patientLocation;
    IBOutlet UISegmentedControl *unitSelector;
	IBOutlet UISegmentedControl *paliativeCareSelector;
	IBOutlet UILabel *paliativeCareText;
	IBOutlet UITextField *patientID;
	IBOutlet UITextField *dayHospital;
    
    NSString *heightUnit;
    NSString *weightUnit;
    IBOutlet UILabel *heightUnitLabel;
    IBOutlet UILabel *weightUnitLabel;
	
	NSDictionary *symptoms;
	
	Patient *patient;
    
}

-(IBAction) submit:(id)sender;
-(IBAction) heightSliderChanged:(UISlider *) sender;
-(IBAction) weightSliderChanged:(UISlider *) sender;
-(IBAction) heightTextChanged:(UITextField *) sender;
-(IBAction) weightTextChanged:(UITextField *) sender;
-(IBAction) unitSwitched:(UISegmentedControl *)sender;

@end
