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
- (IBAction)dailyLIPS:(id)sender;
- (IBAction)icuTreatment:(id)sender;
- (IBAction)surgeryTreatment:(id)sender;


- (id)initWithScore:(float)lipsScore;

@end
