#import <UIKit/UIKit.h>
#import "DecisionTreeView.h"


@interface InfectionViewController : UIViewController<DecisionTreeView> {
	    
    IBOutlet UIWebView *advice;
    IBOutlet UILabel *empiricSuggestionLabel;
    IBOutlet UILabel *previousContactSuggestionLabel;
    IBOutlet UILabel *immuneSuppressedSuggestionLabel;
    IBOutletCollection(UIView) NSArray *removableQuestionViews;
    
	NSString *empiricSuggestion;
	NSString *previousContactSuggestion;
	NSString *immuneSuppressedSuggestion;
}

- (IBAction)removableResponse:(id)sender;

@end
