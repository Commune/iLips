//
//  DataEntryController.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataEntryController.h"
#import "ScoreViewController.h"
#import "DecisionFetcher.h"
#import "Patient.h"
#import "YesNoButton.h"
#import "ConservativeFluidViewController.h"


@implementation DataEntryController

-(id)initWithPatient:(Patient *)p {
	if (self == [super init]) {
		thePatient = p;
		self.navigationItem.hidesBackButton = NO;
		
		if (!infectionLocations) {
		
			infectionLocations = [[NSMutableArray alloc] init];
		
			[infectionLocations addObject:@"Abdomen"];
			[infectionLocations addObject:@"Lung"];
			[infectionLocations addObject:@"Urine"];
			[infectionLocations addObject:@"CNS"];
			[infectionLocations addObject:@"IV Catheter"];
			[infectionLocations addObject:@"Skin/Tissue"];
			[infectionLocations addObject:@"Unknown"];
		}
		
		if (!infecLoc) {
			infecLoc = [[NSString alloc] init];

		}
	}
	return self;
}

-(IBAction)valueChanged:(YesNoButton *)sender {
	if (sender ==  shockSwitch) {
		NSLog(@"Shock.");
		NSLog(@"%d", sender.on);
		[thePatient tripCondition:@"Shock":sender.on];
	} else if (sender == aspirationSwitch) {
		[thePatient tripCondition:@"Aspiration":sender.on];
	} else if (sender == sepsisSwitch) {
		[thePatient tripCondition:@"Sepsis":sender.on];
	} else if (sender == pneumoniaSwitch) {
		[thePatient tripCondition:@"Pneumonia":sender.on];
	} else if (sender == contusionSwitch) {
		[thePatient tripCondition:@"Lung Contusion":sender.on];
	} else if (sender == smokeSwitch) {
		[thePatient tripCondition:@"Smoke Inhalation":sender.on];
	} else if (sender == drowningSwitch ) {
		[thePatient tripCondition:@"Near Drowning":sender.on];
	} else if (sender == fracturesSwitch) {
		[thePatient tripCondition:@"Multiple Fractures":sender.on];
	} else if (sender == brainSwitch) {
		[thePatient tripCondition:@"Traumatic Brain Injury":sender.on];
	} else if (sender == cardiacSwitch) {
		[thePatient tripCondition:@"Cardiac Surgery":sender.on];
	} else if (sender == vascularSwitch) {
		[thePatient tripCondition:@"Vascular Surgery":sender.on];
	} else if (sender == spineSwitch) {
		[thePatient tripCondition:@"Spine Surgery":sender.on];
	} else if (sender == abdomenSwitch) {
		[thePatient tripCondition:@"Acute Abdomen Surgery":sender.on];
	} else if (sender == emergencySwitch) {
		[thePatient tripCondition:@"Emergency Surgery":sender.on];
	} else if (sender == alchySwitch) {
		[thePatient tripCondition:@"Alcohol Abuse":sender.on];
	} else if (sender == hypoSwitch) {
		[thePatient tripCondition:@"Albumin < 3.5 g/dL":sender.on];
	} else if (sender == chemoSwitch) {
		[thePatient tripCondition:@"Chemotherapy":sender.on];
	} else if (sender == fio2Switch) {
		[thePatient tripCondition:@"FiO2 > 35%":sender.on];
	} else if (sender == spo2Switch) {
		[thePatient tripCondition:@"Oxygen Saturation < 95%":sender.on];
	} else if (sender == acidosisSwitch) {
		[thePatient tripCondition:@"At least one Arterial pH < 7.35":sender.on];
	} else if (sender == diabetesSwitch) {
		[thePatient tripCondition:@"Diabetes Mellitus and has sepsis":sender.on];
	} else if (sender == vasoactiveSwitch) {
		[thePatient tripCondition:@"Vasoactive Medication":sender.on];
	} else if (sender == bleedingSwitch) {
		[thePatient tripCondition:@"Active Bleeding" :sender.on];
	}
}

-(IBAction) infectionChanged:(YesNoButton *)sender {
	int infecPresent = sender.on;
	infectionSource.hidden = !infecPresent;
	sepsisLabel.hidden = !infecPresent;
	sepsisSwitch.hidden = !infecPresent;
	if(!infecPresent) {
		sepsisSwitch.on = NO;
		pneumoniaSwitch.on = NO;
		pneumoniaSwitch.hidden = YES;
		pneumoniaLabel.hidden = YES;
	}
	[infectionSource selectRow:0 inComponent:0 animated:NO];
}


- (IBAction)submit:(id)sender {
	// Add patient to SQLite database
	[thePatient addToLocalDatabase];
	
    float total = [thePatient calculateScore];
	
	if ([thePatient conservativeFluids]) {
		ConservativeFluidViewController *fluid = [[ConservativeFluidViewController alloc] init];
		[self.navigationController pushViewController:fluid animated:YES];

	} else {
		NSString *shockResponse = shockSwitch.on?@"Yes":@"No";
		NSString *infectionResponse = infectionPresent.on?@"Yes":@"No";
		[DecisionFetcher assignResponse:@"Shock" withValue:shockResponse];
		[DecisionFetcher assignResponse:@"Infection" withValue:infectionResponse];
		
		ScoreViewController *scoreView = [[ScoreViewController alloc] initWithScore:total];
		[self.navigationController pushViewController:scoreView animated:YES];
	}
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [infectionLocations count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [infectionLocations objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	infecLoc = [infectionLocations objectAtIndex:row];
	if ([infecLoc isEqualToString:@"Lung"]) {
		pneumoniaLabel.hidden = NO;
		pneumoniaSwitch.hidden = NO;
	} else {
		pneumoniaSwitch.on = NO;
		pneumoniaLabel.hidden = YES;
		pneumoniaSwitch.hidden = YES;
	}
}

- (void)dealloc
{
	[contusionSwitch release];
	[spo2Switch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Patient Condition"];
    [self willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:0];
}

- (void)viewDidUnload
{
	[contusionSwitch release];
	contusionSwitch = nil;
	[spo2Switch release];
	spo2Switch = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"rotated");
}



@end
