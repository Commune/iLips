//
//  MysqlFetchField.m
//  mysql_connector
//
//  Created by Karl Kraft on 10/22/09.
//  Copyright 2009-2010 Karl Kraft. All rights reserved.
//

#import "MysqlFetchField.h"

@implementation MysqlFetchField

@synthesize name,fieldType,width,primaryKey;

-(void)dealloc;
{
  [name release];
  [super dealloc];
}
@end
