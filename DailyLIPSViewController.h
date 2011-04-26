#import <UIKit/UIKit.h>

@class Patient;

@interface DailyLIPSViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *lipsTable;
	NSDictionary *dailyLIPS;
}
@end
