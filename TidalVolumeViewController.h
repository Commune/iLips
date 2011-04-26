#import <UIKit/UIKit.h>
#import "DecisionTreeView.h"


@interface TidalVolumeViewController : UIViewController<DecisionTreeView> {
    
    IBOutlet UILabel *sliderValueLabel;
    IBOutlet UILabel *volumeLabel;
    IBOutlet UISlider *slider;
    
    float IBW;
}
- (IBAction)sliderMoved:(id)sender;

@end
