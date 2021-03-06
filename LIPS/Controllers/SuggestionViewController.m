#import "SuggestionViewController.h"
#import "DecisionFetcher.h"


@implementation SuggestionViewController

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args
{
    self = [super init];
    if (self) {
        self.navigationItem.title = title;
        text = [args objectAtIndex:0];
		if([args count] > 1) {
			moreView = [DecisionFetcher fetchViewForNode:[args objectAtIndex:1]];
		}
    }
    return self;
}

- (void)more:(id)sender {
	[self.navigationController pushViewController:moreView animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [DecisionFetcher resetDecisions];
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [suggestionWebView release];
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
	suggestionWebView.userInteractionEnabled = NO;
	NSString *style = @"body { color: white; background-color: black; font-family: sans-serif }";
	NSString *htmlString = [NSString stringWithFormat:@"<html><head><style>%@</style></head><body>%@</body></html>",style,text];
	[suggestionWebView loadHTMLString:htmlString baseURL:nil];
	if(moreView) {
		moreButton.hidden = NO;
	}
}

- (void)viewDidUnload
{
    [suggestionWebView release];
    suggestionWebView = nil;
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
