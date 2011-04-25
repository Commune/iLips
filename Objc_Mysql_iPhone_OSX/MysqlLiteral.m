//
//  MysqlLiteral.m
//  mysql_connector
//
//  Created by Karl Kraft on 8/29/09.
//  Copyright 2009-2010 Karl Kraft. All rights reserved.
//

#import "MysqlLiteral.h"


@implementation MysqlLiteral
@synthesize string;
+(MysqlLiteral *)literalWithString:(NSString *)s;
{
  MysqlLiteral *newObject = [[self alloc] init];
  newObject->string=[s copy];
  return [newObject autorelease];
}

- (void)dealloc;
{
  [string release];
  [super dealloc];
}

@end
