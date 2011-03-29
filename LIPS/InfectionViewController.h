//
//  InfectionViewController.h
//  LIPS
//
//  Created by David Herzka on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfectionViewController : UIViewController {
	    
    IBOutlet UIWebView *advice;
    IBOutlet UILabel *empiricSuggestionLabel;
    IBOutlet UILabel *previousContactSuggestionLabel;
    IBOutlet UILabel *immuneSuppressedSuggestionLabel;
    IBOutletCollection(UIView) NSArray *removableQuestionViews;
    
	NSString *empiricSuggestion;
	NSString *previousContactSuggestion;
	NSString *immuneSuppressedSuggestion;
}

-(id)initWithName:(NSString*)name title:(NSString*)title arguments:(NSArray*)args;

- (IBAction)removableResponse:(id)sender;

@end
