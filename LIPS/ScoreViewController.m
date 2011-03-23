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

- (IBAction)findSuggestion:(id)sender 
{
    [DecisionFetcher resetDecisions];
    [DecisionFetcher assignResponse:@"Score" withValue:@"Default"];
    [self.navigationController pushViewController:[DecisionFetcher fetchNextViewAfter:@"Score"] animated:YES];

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
        [suggestionButton setHidden:NO];
		[alertLabel setHidden:NO];
		[self.view setBackgroundColor:[UIColor redColor]];
    } else {
        [lowScoreLabel setHidden:NO];
    }
    
    [self.navigationItem setTitle:@"LIPS Score"];
	[self.navigationController setNavigationBarHidden:NO];
}


- (void)viewDidUnload
{
    [suggestionButton release];
    [lowScoreLabel release];
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
