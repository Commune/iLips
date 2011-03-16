//
//  FluidManagementViewController.m
//  LIPS
//
//  Created by David Herzka on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FluidManagementViewController.h"
#import "DecisionFetcher.h"

@implementation FluidManagementViewController

-(id)initWithName:(NSString*)name arguments:(NSArray*)ignore
{
    self = [self init];
    if(self) {
        self.navigationItem.title = name;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [DecisionFetcher resetDecisions];
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void) updateTreatment
{
    NSString * newTreatment;
    if(MAPSlider.value >= 60 && vasopressorSwitch.on) {
        if(urineSlider.value < .5) {
            if(CVPSlider.value > 8) {
                newTreatment = @"Administer furosemide and reassess in 1 hour";
            }
            else {
                newTreatment = @"Give fluid bolus as fast as possible and reassess in 1 hour";
            }
        } else {
            if(CVPSlider.value >= 4) {
                newTreatment = @"Administer furosemide and reassess in 4 hours";
            }
            else {
                newTreatment = @"No intervention is required.  Reasess in 4 hours.";
            }
        }
    } else {
        newTreatment = @"No treatment is suggested if the patient's mean arterial pressure is less than 60 mm Hg or if patient has been off vasopressors for less than 12 hours.";
    }
    treatmentLabel.text = newTreatment;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, YYYY"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:[NSDate date]];
    updateLabel.text = [NSString stringWithFormat:@"Suggestion last updated on %@ at %@",dateString,timeString];
}

- (void) updateSliderLabels 
{
    NSString * newCVPLabel;
    if(CVPSlider.value > 8) {
        newCVPLabel = @">8";
    } else if (CVPSlider.value < 4) {
        newCVPLabel = @"<4";
    } else {
        newCVPLabel = [NSString stringWithFormat:@"%.1f",CVPSlider.value];
    }
    CVPLabel.text = newCVPLabel;    
    
    NSString * newMAPLabel;
    if(MAPSlider.value < 60) {
        newMAPLabel = @"<60";
    } else {
        newMAPLabel = [NSString stringWithFormat:@"%.1f",MAPSlider.value];
    }
    MAPLabel.text = newMAPLabel;
    
    urineLabel.text = [NSString stringWithFormat:@"%.2f",urineSlider.value];
    
    [self updateTreatment];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateTreatment];
    [self.navigationItem setTitle:@"Fluid Management"];
    [MAPSlider addTarget:self action:@selector(updateSliderLabels) forControlEvents:UIControlEventAllEvents];
    [CVPSlider addTarget:self action:@selector(updateSliderLabels) forControlEvents:UIControlEventAllEvents];
    [urineSlider addTarget:self action:@selector(updateSliderLabels) forControlEvents:UIControlEventAllEvents];
    [vasopressorSwitch addTarget:self action:@selector(updateTreatment) forControlEvents:UIControlEventAllEvents];
}


- (void)viewDidUnload
{
    [CVPSlider release];
    [urineSlider release];
    [MAPSlider release];
    [MAPLabel release];
    [CVPLabel release];
    [urineLabel release];
    [MAPLabel release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
