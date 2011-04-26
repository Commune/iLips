#import "ScoreViewController.h"
#import "SuggestionViewController.h"
#import "DecisionFetcher.h"
#import "ChecklistViewController.h"
#import "DailyLIPSViewController.h"

@implementation ScoreViewController

- (id)initWithScore:(float)lipsScore
{
    if([self init]) {
        score = lipsScore;
    }
    return self;
}

- (void)findSuggestion:(NSString*)response
{
    [DecisionFetcher resetDecisions];
    [self.navigationController pushViewController:[DecisionFetcher fetchNextViewAfter:response] animated:YES];

}

- (IBAction)infectionTreatment:(id)sender {
	[self findSuggestion:@"Infection"];
}

- (IBAction)shockTreatment:(id)sender {
	[self findSuggestion:@"Shock"];
}

- (IBAction)checklistTreatment:(id)sender {
	ChecklistViewController *checklist = [[ChecklistViewController alloc] init];
	[self.navigationController pushViewController:checklist animated:YES];
}

- (IBAction)respiratoryTreatment:(id)sender {
    [self findSuggestion:@"Respiratory Status"];
}

- (IBAction)dailyLIPS:(id)sender {
	[self.navigationController pushViewController:[[DailyLIPSViewController alloc] init] animated:YES];
}

- (IBAction)icuTreatment:(id)sender {
    [self findSuggestion:@"ICU Likely"];
}

- (IBAction)surgeryTreatment:(id)sender {
    [self findSuggestion:@"Possible Surgery"];
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
	[infectionButton release];
	[shockButton release];
	[respiratoryButton release];
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

    scoreLabel.text = [NSString stringWithFormat:@"%.2f",score];
	
	// checking if score is in the danger zone!
    if(score >= 4) {
		alertLabel.hidden = NO;
		lowScoreLabel.hidden = YES;
		[self.view setBackgroundColor:[UIColor redColor]];
    }
    
    [self.navigationItem setTitle:@"LIPS Score"];
	[self.navigationController setNavigationBarHidden:NO];
}


- (void)viewDidUnload
{
    [lowScoreLabel release];
	[infectionButton release];
	infectionButton = nil;
	[shockButton release];
	shockButton = nil;
	[respiratoryButton release];
	respiratoryButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


@end
