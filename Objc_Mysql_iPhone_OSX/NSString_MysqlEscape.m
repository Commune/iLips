//
//  NSString_MysqlEscape.m
//  mysql_connector
//
//  Created by Karl Kraft on 6/12/08.
//  Copyright 2008-2010 Karl Kraft. All rights reserved.
//

#import "MysqlConnection.h"

#import "NSString_MysqlEscape.h"


@implementation NSString(MysqlEscape)

- (NSString *)mysqlEscapeInConnection:(MysqlConnection *)connection;
{
  const char *ch = [self UTF8String];
#ifndef __OBJC_GC__
  char *buf=malloc(strlen(ch)*2+1);
#else
  char *buf=NSAllocateCollectable(strlen(ch)*2+1,0);
#endif
  mysql_real_escape_string(connection.connection, buf, ch, strlen(ch));
  NSString *retval=[NSString stringWithUTF8String:buf];
#ifndef __OBJC_GC__
  free(buf);
#endif
  return retval;  
}

@end
