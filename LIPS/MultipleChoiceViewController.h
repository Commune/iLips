#import <UIKit/UIKit.h>
#import "DecisionTreeView.h"


@interface MultipleChoiceViewController : UIViewController<DecisionTreeView> {
    NSString *nodeName;
    NSString *question;
    NSMutableArray *choices;
    NSMutableArray *choiceButtons;
    IBOutlet UILabel *questionLabel;
}

@end
