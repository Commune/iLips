#import <UIKit/UIKit.h>


@interface ChecklistViewController : UIViewController {
    
    IBOutletCollection(CheckBox) NSArray *checkBoxes;
    
    
}
- (void)clear;

@end
