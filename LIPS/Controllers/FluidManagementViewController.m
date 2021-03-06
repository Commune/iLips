#import "FluidManagementViewController.h"
#import "DecisionFetcher.h"
#import "Patient.h"
#import "YesNoButton.h"

@implementation FluidManagementViewController

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)ignore
{
    self = [self init];
    if(self) {
        self.navigationItem.title = title;
		weight = [[DecisionFetcher patient] weight];
    }
	CVPKnown = NO;
    return self;
}

-(BOOL) CVPKnown {
	return CVPKnown;
}



- (IBAction)cvpUnknown:(id)sender {
	self.CVPKnown = NO;
}

- (IBAction)cvpKnown:(UISwitch*)sender {
	self.CVPKnown = YES;
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
	[CVPKnownOutlets release];
	[vasopressorSwitch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (IBAction) updateTreatment
{
    NSString * newTreatment;
    if(MAPSlider.value >= 60 && vasopressorSwitch.on) {
        if(urineSlider.value/weight < .5) {
			if(!CVPKnown) {
				newTreatment = @"Determine volume status.";
			}
            else if(CVPSlider.value > 8) {
                newTreatment = @"Administer furosemide and reassess in 1 hour.";
            }
            else {
                newTreatment = @"Give fluid bolus as fast as possible and reassess in 1 hour.";
            }
        } else {
			if(!CVPKnown) {
				newTreatment = @"Limit fluids. Consider Lasix.";
			}
			else if(CVPSlider.value >= 4) {
                newTreatment = @"Administer furosemide and reassess in 4 hours.";
            }
            else {
                newTreatment = @"No intervention is required.  Reasess in 4 hours.";
            }
        }
    } else {
        newTreatment = @"Maintain a CVP of 8-12 with fluids.";
    }
    treatmentLabel.text = newTreatment;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, YYYY"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:[NSDate date]];
    updateLabel.text = [NSString stringWithFormat:@"Suggestion last updated on %@ at %@",dateString,timeString];
}

- (IBAction) updateSliderLabels 
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
	urineSlider.maximumValue = 2*weight;
	urineSlider.value = weight;
	[self updateSliderLabels];
}

-(void) setCVPKnown:(BOOL)isKnown {
	CVPKnown = isKnown;	
	for(UIView *outlet in CVPKnownOutlets) {
		outlet.hidden = !isKnown;
	}	
}

- (void)cvpKnownSwitched:(UIButton *)sender {
	self.CVPKnown = !CVPKnown;
	[self updateTreatment];
	NSString *knownString = !CVPKnown?@"known":@"unknown";
	[sender setTitle:[NSString stringWithFormat:@"The patient's CVP is %@.",knownString] forState:UIControlStateNormal];
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
	[CVPKnownOutlets release];
	CVPKnownOutlets = nil;
	[vasopressorSwitch release];
	vasopressorSwitch = nil;
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
