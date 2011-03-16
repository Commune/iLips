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
    IBOutlet UIButton *suggestionButton;
    IBOutlet UILabel *lowScoreLabel;
	IBOutlet UILabel *alertLabel;
}
- (IBAction)findSuggestion:(id)sender;

- (id)initWithScore:(float)lipsScore;

@end
