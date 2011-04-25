//
//  DailyLIPSViewController.m
//  LIPS
//
//  Created by David Herzka on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DailyLIPSViewController.h"
#import "Patient.h"
#import "DecisionFetcher.h"
#import "MysqlFetch.h"
#import "MysqlConnection.h"

@implementation DailyLIPSViewController

- (NSDictionary *) loadData {
	NSDictionary *dailyLIPS;
	Patient *patient = DecisionFetcher.patient;
	if(!(dailyLIPS = [patient dailyLIPS])) {
		UIAlertView *loadFailedAlert = [[UIAlertView alloc] initWithTitle:@"Load Failed" message:@"The patient's daily LIPS data could not be downloaded." delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Retry", nil];
		[loadFailedAlert show];
	}
	return dailyLIPS;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Retry"]) {
		[self loadData];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
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
    NSDictionary *dailyLIPS = [self loadData];
	NSLog(@"%@",dailyLIPS);
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

@end
