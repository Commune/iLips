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
#define TEXT_PADDING_X 10
#define TEXT_PADDING_Y 10
- (void)viewDidLoad
{
    [super viewDidLoad];
    questionLabel.text = question;
    
    CGFloat width = (self.view.frame.size.width - 2 * LR_PADDING - ([choices count]-1)*BUTTON_PADDING)/[choices count];
    CGFloat spacing = (self.view.frame.size.width - 2 * LR_PADDING - width) / ([choices count] - 1);
    choiceButtons = [[NSMutableArray alloc] init];
    for(int i = 0; i < [choices count]; i++) {
		UIButton *button = [[UIButton alloc] init];
		[button setBackgroundImage:[UIImage imageNamed:@"GreyButton.png"] forState:UIControlStateNormal];
		button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        [button setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth];
		CGRect buttonFrame = CGRectMake(LR_PADDING+spacing*i, 545.0, width, 110.0);
        [button setFrame:buttonFrame];
		
		[button setTitle:[choices objectAtIndex:i] forState:UIControlStateNormal];
		[button.titleLabel setFrame:CGRectMake(buttonFrame.origin.x+TEXT_PADDING_X, buttonFrame.origin.y+TEXT_PADDING_Y, buttonFrame.size.width-2*TEXT_PADDING_X, buttonFrame.size.height-2*TEXT_PADDING_Y)];
		[button.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
		[button.titleLabel setMinimumFontSize:8.0];
		[button.titleLabel setAdjustsFontSizeToFitWidth:YES];
		[button.titleLabel setTextAlignment:UITextAlignmentCenter];
		[button.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
		[button.titleLabel setNumberOfLines:3];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		
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
