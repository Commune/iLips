//
//  ChecklistViewController.m
//  LIPS
//
//  Created by Duke Student on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChecklistViewController.h"
#import "CheckBox.h"

static ChecklistViewController *checkList;

@implementation ChecklistViewController

- (id)init {
	if(!checkList) checkList = [super init];
	return checkList;
}

- (void)clear {
	for(CheckBox *c in checkBoxes) {
        c.on = NO; 
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
    [checkBoxes release];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [checkBoxes release];
    checkBoxes = nil;
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
