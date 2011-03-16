//
//  LIPSViewController.m
//  LIPS
//
//  Created by David Herzka on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LIPSViewController.h"
#import "ScoreViewController.h"
#import "SuggestionViewController.h"
#import "FluidManagementViewController.h"
#import "DataEntryController.h"
#import "DecisionFetcher.h"
#import "BinaryDecisionViewController.h"

@implementation LIPSViewController

- (void)loadView 
{
    navController = [[UINavigationController alloc] initWithRootViewController:self];
    [navController setDelegate:self];
    
    [navController pushViewController:[[DataEntryController alloc] init] animated:NO];
    
    //BinaryDecisionViewController *vc = [[BinaryDecisionViewController alloc] initWithName:@"Infection" arguments:[NSArray arrayWithObjects:@"Does the patient have an infection?", nil]];
    //[navController pushViewController:vc animated:NO];
    
//    [DecisionFetcher fetchNextViewAfter:@"Infection"];
    
    //[navController pushViewController:[[FluidManagementViewController alloc] init] animated:NO];
    
    self.view = navController.view;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [navController release];
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
