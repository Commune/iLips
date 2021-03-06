#import "PatientInfoScreen.h"
#import "DataEntryController.h"


#define MIN_HEIGHT_CM 100
#define MAX_HEIGHT_CM 240
#define MIN_WEIGHT_KG 20
#define MAX_WEIGHT_KG 200

@implementation PatientInfoScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		heightUnit = @"cm";
		weightUnit = @"kg";
		
		self.navigationItem.title = @"Initial Patient Information";
	}
	return self;
}

// Conversion methods

- (float) kgToLb:(float)kg {
	return kg*2.2;
}

- (float) lbToKg:(float)lb {
	return lb/2.2;
}

- (float) inToCm:(float)inches {
	return inches*2.54;
}

- (float) cmToIn:(float)cm {
	return cm/2.54;
}

-(IBAction) submit:(id)sender {
	// checking if paliative care is desired
	if (paliativeCareSelector.selectedSegmentIndex == 0) {
		paliativeCareText.hidden = NO;
	} else {
		paliativeCareText.hidden = YES;
		
		
		int genderInt = sex.selectedSegmentIndex;
		PatientGender gender;
		if(genderInt==0) gender = PatientGenderMale;
		else gender = PatientGenderFemale;
		
		// Height in m
		float h = [heightUnit isEqualToString:@"cm"]?height.value/100:[self inToCm:height.value]/100;
		// Weight in kg
		float w = [weightUnit isEqualToString:@"kg"]?weight.value:[self lbToKg:weight.value];
		
		int patientLoc = patientLocation.selectedSegmentIndex;
		unsigned long long pid = 0;
		if (![patientID.text isEqualToString:@""]) {
			pid = [patientID.text longLongValue];
		} else {
			pid = (arc4random() % (9999999999l - 1000000000l)) + 1000000000l;
		}
		
		patient = [[Patient alloc] initWithGender:gender height:h weight:w location:patientLoc day:[dayHospital.text floatValue] patientIdent:pid];
		
		DataEntryController *dataEntryView = [[DataEntryController alloc] initWithPatient:patient];
		[self.navigationController pushViewController:dataEntryView animated:YES];
	}
}


// methods for interacting with view

-(IBAction) heightSliderChanged:(UISlider *) sender {
	heightVal.text = [NSString stringWithFormat:@"%0.1f", sender.value];
//	heightText.text = [NSString stringWithFormat:@"%0.1f", sender.value];
}

-(IBAction) weightSliderChanged:(UISlider *) sender {
	weightVal.text = [NSString stringWithFormat:@"%0.1f", sender.value];
//	weightText.text = [NSString stringWithFormat:@"%0.1f", sender.value];

}

-(IBAction) weightTextChanged:(UITextField *)sender {
	if([sender.text isEqualToString:@""]) {
		return;
	}
	float tWeight = [sender.text floatValue];
	float metricWeight = [weightUnit isEqualToString:@"kg"]?tWeight:[self lbToKg:tWeight];
	if (metricWeight < MIN_WEIGHT_KG || metricWeight > MAX_WEIGHT_KG) {
		sender.text = [NSString stringWithFormat:@"%0.1f",weight.value];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid weight" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		weightVal.text = [NSString stringWithFormat:@"%0.1f", tWeight];
		weight.value = tWeight;
	}
}

-(IBAction) heightTextChanged:(UITextField *)sender {
	[sender resignFirstResponder];
	if([sender.text isEqualToString:@""]) { 
		return;
	}
	float tHeight = [sender.text floatValue];
	float metricHeight = [heightUnit isEqualToString:@"cm"]?tHeight:[self inToCm:tHeight];
	if (metricHeight < MIN_HEIGHT_CM || metricHeight > MAX_HEIGHT_CM) {
		sender.text = [NSString stringWithFormat:@"%0.1f",height.value];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid height" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		heightVal.text = [NSString stringWithFormat:@"%0.1f", tHeight];
		height.value = tHeight;
	}
}



- (IBAction)unitSwitched:(UISegmentedControl *)sender {
	float newHeight,newWeight;
	if(sender.selectedSegmentIndex==0) {
		heightUnit = @"cm";
		weightUnit = @"kg";
		newHeight = [self inToCm:height.value];
		height.minimumValue = MIN_HEIGHT_CM;
		height.maximumValue = MAX_HEIGHT_CM;
		height.value = newHeight;
		newWeight = [self lbToKg:weight.value];
		weight.minimumValue = MIN_WEIGHT_KG;
		weight.maximumValue = MAX_WEIGHT_KG;
		weight.value = newWeight;
	} else {
		heightUnit = @"in";
		weightUnit = @"lb";
		newHeight = [self cmToIn:height.value];
		height.minimumValue = [self cmToIn:MIN_HEIGHT_CM];
		height.maximumValue = [self cmToIn:MAX_HEIGHT_CM];
		height.value = newHeight;
		newWeight = [self kgToLb:weight.value];
		weight.minimumValue = [self kgToLb:MIN_WEIGHT_KG];
		weight.maximumValue = [self kgToLb:MAX_WEIGHT_KG];
		weight.value = newWeight;
	}
	heightUnitLabel.text = [NSString stringWithFormat:@"(%@)",heightUnit];
	weightUnitLabel.text = [NSString stringWithFormat:@"(%@)",weightUnit];
	[self weightSliderChanged:weight];
	[self heightSliderChanged:height];
	if(![weightText.text isEqualToString:@""]) {
		weightText.text = [NSString stringWithFormat:@"%0.1f",newWeight];
	}
	if(![heightText.text isEqualToString:@""]) {
		heightText.text = [NSString stringWithFormat:@"%0.1f",newHeight];
	}
}


- (void) closeKeyboard:(id)sender {
	[sender resignFirstResponder];
}

// initialization methods

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[heightText addTarget:self action:@selector(heightTextChanged:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	[weightText addTarget:self action:@selector(weightTextChanged:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	[patientID addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	[dayHospital addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];

}

- (void)viewDidUnload
{
    [unitSelector release];
    unitSelector = nil;
	[heightUnitLabel release];
	heightUnitLabel = nil;
    [weightUnitLabel release];
    weightUnitLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)dealloc {
    [unitSelector release];
    [heightUnitLabel release];
    [weightUnitLabel release];
    [super dealloc];
}
@end
