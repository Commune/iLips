
//
//  TidalVolumeViewController.m
//  LIPS
//
//  Created by David Herzka on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
	
	//float height = [[DecisionFetcher patient] height];
	//float weight = [[DecisionFetcher patient] weight];
	

	
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[volumeLabel release];
	volumeLabel = nil;
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
