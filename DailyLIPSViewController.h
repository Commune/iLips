//
//  DailyLIPSViewController.h
//  LIPS
//
//  Created by David Herzka on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Patient;

@interface DailyLIPSViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *lipsTable;
	NSDictionary *dailyLIPS;
}
@end
