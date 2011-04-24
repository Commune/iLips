//
//  ScoreViewController.h
//  LIPS
//
//  Created by David Herzka on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreViewController : UIViewController {
    IBOutlet UILabel *scoreLabel;
    float score;
    IBOutlet UILabel *lowScoreLabel;
	IBOutlet UILabel *alertLabel;
    IBOutlet UIButton *respiratoryButton;
    IBOutlet UIButton *infectionButton;
    IBOutlet UIButton *shockButton;
}
- (IBAction)infectionTreatment:(id)sender;
- (IBAction)shockTreatment:(id)sender;
- (IBAction)checklistTreatment:(id)sender;
- (IBAction)respiratoryTreatment:(id)sender;


- (id)initWithScore:(float)lipsScore;

@end
