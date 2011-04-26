#import "CheckBox.h"


@implementation CheckBox

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder onText:@"" onImage:[UIImage imageNamed:@"CheckBoxChecked.png"] offText:@"" offImage:[UIImage imageNamed:@"CheckBoxUnchecked.png"]];
	return self;
}

@end
