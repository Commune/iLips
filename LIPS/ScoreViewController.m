//
//  ScoreViewController.m
//  LIPS
//
//  Created by David Herzka on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"
#import "SuggestionViewController.h"
#import "DecisionFetcher.h"

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
//	[DecisionFetcher assignResponse:response withValue:@"Yes"];
    [self.navigationController pushViewController:[DecisionFetcher fetchNextViewAfter:response] animated:YES];

}

- (IBAction)infectionTreatment:(id)sender {
	[self findSuggestion:@"Infection"];
}

- (IBAction)shockTreatment:(id)sender {
//	[self findSuggestion:@"Shock"];
	[self findSuggestion:@"Respiratory Status"];
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
    if(score>=4) {
		if([[DecisionFetcher responseForQuestion:@"Infection"] isEqualToString:@"Yes"]) {
            infectionButton.hidden = NO;
		}
        if([[DecisionFetcher responseForQuestion:@"Shock"] isEqualToString:@"Yes"]) {
            shockButton.hidden = NO;
		}
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
