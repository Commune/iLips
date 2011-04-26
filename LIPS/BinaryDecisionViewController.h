#import <UIKit/UIKit.h>
#import "DecisionTreeView.h"

@interface BinaryDecisionViewController : UIViewController<DecisionTreeView> {
    NSString *question;
    NSString *nodeName;
    IBOutlet UILabel *questionLabel;
}

-(IBAction)submitAnswer:(UIControl*)sender;
@end
