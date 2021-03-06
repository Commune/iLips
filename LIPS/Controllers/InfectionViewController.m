#import "InfectionViewController.h"


@implementation InfectionViewController

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args {
    self = [self init];
    if(self) {
		self.navigationItem.title = title;
		empiricSuggestion = [args objectAtIndex:0];
		previousContactSuggestion = [args objectAtIndex:1];
		immuneSuppressedSuggestion = [args objectAtIndex:2];
    }
    return self;
}

- (void)initAdvice:(BOOL)hasRemovableSource {
	
	NSString *style = @"body { color: white; background-color: black; font-family: sans-serif }";

	NSString* basicAdvice = @"<ul><font size=\"5\">Antibiotics</font> <li>Administer antibiotics within 6 hours of presentation.</ul>";
	NSMutableString* adviceSource = [[NSMutableString alloc] initWithString:basicAdvice];
	if(hasRemovableSource) {
		[adviceSource appendString:@"<ul><font size=\"5\">Source Control</font><li> Early Imaging to confirm source if appropriate<li> Early Surgical/interventional evaluation if appropriate<li> Early Drainage of purulent collection or removal of infected device if relevant</ul>"];
	}
	
	NSString *htmlString = [NSString stringWithFormat:@"<html><head><style>%@</style></head><body>%@</body></html>",style,adviceSource];
	
	[advice loadHTMLString:htmlString baseURL:nil];
	advice.userInteractionEnabled = NO;
}

- (IBAction)removableResponse:(id)sender {
	for(UIView *v in removableQuestionViews) {
		v.hidden = YES;
	}
	[self initAdvice:[sender tag]==1];
	advice.hidden = NO;
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
    [advice release];
    [empiricSuggestionLabel release];
    [previousContactSuggestionLabel release];
    [immuneSuppressedSuggestionLabel release];
	[removableQuestionViews release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*
 Vertically aligns text in UILabel 
 */
- (void)setUILabel:(UILabel *)myLabel withMaxFrame:(CGRect)maxFrame withText:(NSString *)theText {
	CGSize stringSize = [theText sizeWithFont:myLabel.font constrainedToSize:maxFrame.size lineBreakMode:myLabel.lineBreakMode];
	
	myLabel.frame = CGRectMake(myLabel.frame.origin.x, 
							   myLabel.frame.origin.y, 
							   myLabel.frame.size.width, 
							   stringSize.height
							   );
	myLabel.text = theText;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setUILabel:empiricSuggestionLabel withMaxFrame:empiricSuggestionLabel.frame withText:empiricSuggestion];
	
	[self setUILabel:previousContactSuggestionLabel withMaxFrame:previousContactSuggestionLabel.frame withText:previousContactSuggestion];
	
	[self setUILabel:immuneSuppressedSuggestionLabel withMaxFrame:immuneSuppressedSuggestionLabel.frame withText:immuneSuppressedSuggestion];
}

- (void)viewDidUnload
{
    [advice release];
    advice = nil;
    [empiricSuggestionLabel release];
    empiricSuggestionLabel = nil;
    [previousContactSuggestionLabel release];
    previousContactSuggestionLabel = nil;
    [immuneSuppressedSuggestionLabel release];
    immuneSuppressedSuggestionLabel = nil;
	[removableQuestionViews release];
	removableQuestionViews = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{ 
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
