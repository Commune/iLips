//
//  PatientInfoScreen.m
//  LIPS
//
//  Created by Duke Student on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PatientInfoScreen.h"
#import "DataEntryController.h"


@implementation PatientInfoScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self;
}

-(IBAction) submit:(id)sender {
	int gender = sex.selectedSegmentIndex;
	float h = height.value;
	float w = weight.value;
	int patientLoc = patientLocation.selectedSegmentIndex;
	patient = [[Patient alloc] initWithParams:gender:h:w:patientLoc:infecLoc];
	[patient printSelf];
	[self.navigationController pushViewController:[[DataEntryController alloc] init] animated:YES];
}

-(IBAction) heightValChanged:(UISlider *) sender {
	heightVal.text = [NSString stringWithFormat:@"%0.0f", sender.value];
}

-(IBAction) weightValChanged:(UISlider *) sender {
	weightVal.text = [NSString stringWithFormat:@"%0.1f", sender.value];
}

-(IBAction) infectionChanged:(UISegmentedControl *)sender {
	if (infectionPresent.selectedSegmentIndex == 0) {
		[infectionLocationLabel setHidden:NO];
		[infectionSource setHidden:NO];
	} else {
		[infectionLocationLabel setHidden:YES];
		[infectionSource setHidden:YES];
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
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (!infectionLocations) {
		infectionLocations = [[NSMutableArray alloc] init];
		[infectionLocations addObject:@"Arm"];
		[infectionLocations addObject:@"Leg"];
		[infectionLocations addObject:@"Foot"];
		[infectionLocations addObject:@"Head"];
		[infectionLocations addObject:@"Chest"];
	}
	
	if (!infecLoc) {
		infecLoc = [[NSString alloc] init];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
