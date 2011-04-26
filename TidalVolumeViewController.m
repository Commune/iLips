#import "TidalVolumeViewController.h"
#import "DecisionFetcher.h"
#import "Patient.h"


@implementation TidalVolumeViewController

-(id)initWithName:(NSString *)name title:(NSString *)title arguments:(NSArray *)args {
	self = [super init];
	if(self) {
		self.navigationItem.title = title;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	[volumeLabel release];
	[sliderValueLabel release];
	[slider release];
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
	
	float height = [DecisionFetcher patient].height;
    PatientGender gender = [DecisionFetcher patient].gender;
	switch (gender) {
		case PatientGenderMale:
			IBW = 50.0 + 2.3 * (height*100/2.54 - 60);
			break;
			
		case PatientGenderFemale:
			IBW = 45.5 + (height*100/2.54 - 60);
			break;
	}
    
    [self sliderMoved:slider];
	
}

- (void)viewDidUnload
{
	[volumeLabel release];
	volumeLabel = nil;
	[sliderValueLabel release];
	sliderValueLabel = nil;
	[slider release];
	slider = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)sliderMoved:(UISlider *)sender {
    sliderValueLabel.text = [NSString stringWithFormat:@"%0.2f",sender.value];
    volumeLabel.text = [NSString stringWithFormat:@"%0.2f",IBW*sender.value];
}
@end
