//
//  MultipleChoiceViewController.h
//  LIPS
//
//  Created by David Herzka on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultipleChoiceViewController : UIViewController {
    NSString *nodeName;
    NSString *question;
    NSMutableArray *choices;
    NSMutableArray *choiceButtons;
    IBOutlet UILabel *questionLabel;
}

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args;

@end
