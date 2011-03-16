//
//  SuggestionViewController.h
//  LIPS
//
//  Created by David Herzka on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuggestionViewController : UIViewController {
    NSString * text;
	
	UIViewController *moreView;
	
    IBOutlet UITextView *suggestionTextView;
	IBOutlet UIButton *moreButton;
}

-(id)initWithName:(NSString*)name arguments:(NSArray*)args;
-(IBAction)more:(id)sender;
@end
