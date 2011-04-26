#import "YesNoButton.h"

@implementation YesNoButton

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder onText:@"YES" onImage:[UIImage imageNamed:@"GreenButton.png"] offText:@"NO" offImage:[UIImage imageNamed:@"RedButton.png"]];
	return self;
}

@end
