//
//  DailyLIPSViewController.m
//  LIPS
//
//  Created by David Herzka on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DailyLIPSViewController.h"
#import "Patient.h"
#import "DecisionFetcher.h"
#import "MysqlFetch.h"
#import "MysqlConnection.h"

@implementation DailyLIPSViewController

- (void) loadData {
	Patient *patient = DecisionFetcher.patient;
	if(!(dailyLIPS = [patient dailyLIPS])) {
		UIAlertView *loadFailedAlert = [[UIAlertView alloc] initWithTitle:@"Load Failed" message:@"The patient's daily LIPS data could not be downloaded." delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Retry", nil];
		[loadFailedAlert show];
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Retry"]) {
		[self loadData];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.navigationItem.title = [NSString stringWithFormat:@"Daily LIPS Scores for Patient %qu",DecisionFetcher.patient.pid];
		[self loadData];
    }
    return self;
}

- (void)dealloc
{
	[lipsTable release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
	id day = [[[dailyLIPS allKeys] sortedArrayUsingComparator:^(id obj1, id obj2) {
		if([obj1 intValue] > [obj2 intValue]) 
			return (NSComparisonResult) NSOrderedDescending;
		else if([obj1 intValue] < [obj2 intValue])
			return (NSComparisonResult) NSOrderedAscending;
		return (NSComparisonResult) NSOrderedSame;
	}] objectAtIndex:indexPath.row];
	NSNumber *score = [dailyLIPS objectForKey:day];
	NSString *cellString = [NSString stringWithFormat:@"%@:%@",day,score];
	
	cell.textLabel.text = cellString;
	float scaledScore = MIN([score floatValue]/10.0,1.0);
	UIColor *bgColor = [UIColor colorWithRed:scaledScore green:0.0 blue:1.0-scaledScore alpha:1.0];
	
	CGRect frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, self.view.frame.size.width, cell.frame.size.height);
	UIView *bgView = [[UIView alloc] initWithFrame:frame];
	bgView.backgroundColor = bgColor;
	cell.backgroundView = bgView;
	cell.textLabel.backgroundColor = bgColor;
	[cell.contentView insertSubview:bgView aboveSubview:cell.textLabel];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	CGRect dayLabelFrame = bgView.frame;
	dayLabelFrame.size.width /= 2;
	UILabel *dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
	dayLabel.backgroundColor = [UIColor clearColor];
	dayLabel.text = [NSString stringWithFormat:@"%@",day];
	dayLabel.textAlignment = UITextAlignmentCenter;
	[cell.contentView insertSubview:dayLabel aboveSubview:bgView];
	
	CGRect scoreLabelFrame = dayLabelFrame;
	scoreLabelFrame.origin.x += scoreLabelFrame.size.width;
	UILabel *scoreLabel = [[UILabel alloc] initWithFrame:scoreLabelFrame];
	scoreLabel.backgroundColor = [UIColor clearColor];
	scoreLabel.text = [NSString stringWithFormat:@"%@",score];
	scoreLabel.textAlignment = UITextAlignmentCenter;
	[cell.contentView insertSubview:scoreLabel aboveSubview:bgView];
	
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [dailyLIPS count];	
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];	
}

- (void)viewDidUnload
{
	[lipsTable release];
	lipsTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
