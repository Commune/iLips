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
	
    IBOutlet UIWebView *suggestionWebView;
	IBOutlet UIButton *moreButton;
}

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args;
-(IBAction)more:(id)sender;
@end
