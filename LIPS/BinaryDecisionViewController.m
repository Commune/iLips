//
//  BinaryDecisionViewController.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BinaryDecisionViewController.h"
#import "DecisionFetcher.h"


@implementation BinaryDecisionViewController

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args 
{
    self = [self init];
    if(self) {
        self.navigationItem.title = title;
        nodeName = name;
        question = [args objectAtIndex:0];
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
    questionLabel.text = question;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)submitAnswer:(UIControl *)sender {
    if(sender.tag) {
        [DecisionFetcher assignResponse:nodeName withValue:@"Yes"];
    } else {
        [DecisionFetcher assignResponse:nodeName withValue:@"No"];
    }
        
    UIViewController *nextView = [DecisionFetcher fetchNextViewAfter:nodeName];
    if(nextView) {
        [self.navigationController pushViewController:nextView animated:YES];
    }
    NSLog(@"%@",nextView);
}

@end
