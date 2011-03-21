//
//  PatientInfoScreen.m
//  LIPS
//
//  Created by Duke Student on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PatientInfoScreen.h"


@implementation PatientInfoScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		// Custom initialization
    }
    return self;
}

-(IBAction) submit:(id)sender {
	if ([sex isEnabledForSegmentAtIndex:0]) {
		
	}
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
