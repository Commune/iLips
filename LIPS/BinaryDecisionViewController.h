//
//  BinaryDecisionViewController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BinaryDecisionViewController : UIViewController {
    NSString *question;
    NSString *nodeName;
    IBOutlet UILabel *questionLabel;
}
-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args;
-(IBAction)submitAnswer:(UIControl*)sender;
@end
