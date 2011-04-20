//
//  MultipleChoiceViewController.m
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "DecisionFetcher.h"


@implementation MultipleChoiceViewController


-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args {
    self = [self init];
    if(self) {
		self.navigationItem.title = title;
        nodeName = name;
        question = [args objectAtIndex:0];
        choices = [[NSMutableArray alloc] init];
        for (int i = 1; i < [args count]; i++) {
            [choices addObject:[args objectAtIndex:i]];
        }
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

#define LR_PADDING 50
#define BUTTON_PADDING 20
- (void)viewDidLoad
{
    [super viewDidLoad];
    questionLabel.text = question;
    
    CGFloat width = (self.view.frame.size.width - 2 * LR_PADDING - ([choices count]-1)*BUTTON_PADDING)/[choices count];
    CGFloat spacing = (self.view.frame.size.width - 2 * LR_PADDING - width) / ([choices count] - 1);
    choiceButtons = [[NSMutableArray alloc] init];
    for(int i = 0; i < [choices count]; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		UIButton *button = [[UIButton alloc] init];
		[button setBackgroundImage:[UIImage imageNamed:@"MultipleChoiceButton.png"] forState:UIControlStateNormal];
		button.backgroundColor = [UIColor clearColor];
		button.titleLabel.numberOfLines = 3;
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth];
        [button setTitle:[choices objectAtIndex:i] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(LR_PADDING+spacing*i, 545.0, width, 110.0)];
        [button addTarget:self action:@selector(submitAnswer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [choiceButtons addObject:button];
    }
}

- (void)submitAnswer:(UIControl*)sender {
    NSLog(@"%@",[choices objectAtIndex:sender.tag]);
    [DecisionFetcher assignResponse:nodeName withValue:[choices objectAtIndex:sender.tag]];
    [self.navigationController pushViewController:[DecisionFetcher fetchNextViewAfter:nodeName] animated:YES];
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
