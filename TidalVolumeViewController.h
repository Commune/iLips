//
//  TidalVolumeViewController.h
//  LIPS
//
//  Created by David Herzka on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
