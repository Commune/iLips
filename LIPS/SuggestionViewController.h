#import <UIKit/UIKit.h>
#import "DecisionTreeView.h"

@interface SuggestionViewController : UIViewController<DecisionTreeView> {
    NSString * text;
	
	UIViewController *moreView;
	
    IBOutlet UIWebView *suggestionWebView;
	IBOutlet UIButton *moreButton;
}

-(IBAction)more:(id)sender;
@end
