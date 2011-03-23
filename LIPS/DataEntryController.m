//
//  DataEntryController.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataEntryController.h"
#import "ScoreViewController.h"
#import "DecisionFetcher.h"
#import "Patient.h"


@implementation DataEntryController

- (void) initValsAndFlags 
{
    if (!lipsVals) {
		//NSString *path = [[NSBundle mainBundle] pathForResource:@"labels" ofType:@"txt"];
		//NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
		//NSLog(@"%@", [array componentsJoinedByString:@" "]);
		NSNumber *shock = [NSNumber numberWithFloat:2];
		NSNumber *aspiration = [NSNumber numberWithFloat:2];
		NSNumber *sepsis = [NSNumber numberWithFloat:1];
		NSNumber *pneumonia = [NSNumber numberWithFloat:1.5];
		NSNumber *spine = [NSNumber numberWithFloat:1];
		NSNumber *abdomen = [NSNumber numberWithFloat:2];
		NSNumber *cardiac = [NSNumber numberWithFloat:2.5];
		NSNumber *vascular = [NSNumber numberWithFloat:3.5];
		NSNumber *brain = [NSNumber numberWithFloat:2];
		NSNumber *smoke = [NSNumber numberWithFloat:2];
		NSNumber *drowning = [NSNumber numberWithFloat:2];
		NSNumber *contusion = [NSNumber numberWithFloat:1.5];
		NSNumber *fractures = [NSNumber numberWithFloat:1.5];
		NSNumber *abuse = [NSNumber numberWithFloat:1];
		NSNumber *obesity = [NSNumber numberWithFloat:1];
		NSNumber *hypo = [NSNumber numberWithFloat:1];
		NSNumber *chemo = [NSNumber numberWithFloat:1];
		NSNumber *fio2 = [NSNumber numberWithFloat:2];
		NSNumber *tach = [NSNumber numberWithFloat:1.5];
		NSNumber *spo2 = [NSNumber numberWithFloat:1];
		NSNumber *acid = [NSNumber numberWithFloat:1.5];
		NSNumber *diabetes = [NSNumber numberWithFloat:-1];
		NSArray *temp = [NSArray arrayWithObjects:shock, aspiration, sepsis, pneumonia, spine, abdomen, cardiac, vascular, brain, smoke,
						 drowning, contusion, fractures, abuse, obesity, hypo, chemo, fio2, tach, spo2, acid, diabetes, nil];
		lipsVals = [[NSArray alloc] initWithArray:temp];
	}
	if (!lipsFlags) {
		NSMutableArray* temp = [NSMutableArray array];
		for (int i = 0; i < 21; i++) {
			[temp addObject:[NSNumber numberWithBool:NO]];
		}
		lipsFlags = [[NSMutableArray alloc] initWithArray:temp];
		
	}
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil: (Patient *)p
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initValsAndFlags];
		thePatient = p;
    }
    return self;
}


- (IBAction)submit:(id)sender {
    float total = 0;
	for (int i = 1; i < 22; i++) {
		UISwitch *aSwitch = (UISwitch*)[self.view viewWithTag:i];
		if (aSwitch.on) {
			NSLog(@"%@", [lipsVals componentsJoinedByString:@" "]);
			CGFloat temp = [[lipsVals objectAtIndex:i - 1] floatValue];
			total += temp;
			[lipsFlags replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
		}
	}
	
	[thePatient setConditionsArray:lipsFlags];
    
	
	NSString *shockResponse = shockSwitch.on?@"Yes":@"No";
	[DecisionFetcher assignResponse:@"Shock" withValue:shockResponse];
	
    [self.navigationController pushViewController:[[ScoreViewController alloc] initWithScore:total] animated:YES];
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
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:@"Initial Info"];
    [self willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:0];
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


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"rotated");
}



@end
