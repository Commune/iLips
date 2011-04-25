//
//  MysqlUpdate.m
//  mysql_connector
//
//  Created by Karl Kraft on 6/12/08.
//  Copyright 2008-2010 Karl Kraft. All rights reserved.
//

#import "MysqlUpdate.h"
#import "MysqlConnection.h"
#import "MysqlLiteral.h"
#import "MysqlException.h"
#import "NSString_MysqlEscape.h"
#import "GC_MYSQL_BIND.h"

@implementation MysqlUpdate

@synthesize table,rowData,qualifier,affectedRows;

+ (MysqlUpdate *)updateWithConnection:(MysqlConnection *)aConnection;
{
  if (!aConnection) {
    [MysqlException raiseConnection:nil withFormat:@"Connection is nil"];
  }
  
  MysqlUpdate *newObject=[[self alloc] init];
  newObject->connection = [aConnection retain];
  newObject->rowData=nil;
  newObject->qualifier=nil;
  return [newObject autorelease];
}



- (void)execute;
{
  NSMutableString *cmd = [NSMutableString stringWithFormat:@"UPDATE %@ set ",table];
  NSMutableString *columnPairs=[NSMutableString string];

  
  NSArray *keys = [rowData allKeys];
#ifndef __OBJC_GC__
  GC_MYSQL_BIND *binding=calloc(sizeof(GC_MYSQL_BIND),[keys count]);
#else
  GC_MYSQL_BIND *binding=NSAllocateCollectable(sizeof(GC_MYSQL_BIND)*[keys count], NSScannedOption);
#endif

  for (NSUInteger x=0; x < [keys count];x++) {
    NSString *key= [keys objectAtIndex:x];
    NSString *escapeKey= [key mysqlEscapeInConnection:connection];
    NSObject *object = [rowData objectForKey:key];
    [columnPairs appendFormat:@", %@=?",escapeKey];

    if ([object isKindOfClass:[NSString class]]) {
      NSString *s = (NSString *)object;
      const char *ch = [s UTF8String];
      binding[x].is_null= 0;
      binding[x].buffer_type = MYSQL_TYPE_STRING; 
      binding[x].buffer = (void *)ch;
      binding[x].buffer_length= strlen(ch);        
    } else if ([object isKindOfClass:[NSData class]]) {
      NSData *data = (NSData *)object;
      binding[x].is_null= 0;
      binding[x].buffer_type = MYSQL_TYPE_BLOB; 
      binding[x].buffer = (void *)[data bytes];
      binding[x].buffer_length= [data length];        
    } else if ([object isKindOfClass:[NSNumber class]]) {
      NSString *s = (NSString *)[object description];
      const char *ch = [s UTF8String];
      binding[x].is_null= 0;
      binding[x].buffer_type = MYSQL_TYPE_STRING; 
      binding[x].buffer = (void *)ch;
      binding[x].buffer_length= strlen(ch);        
    } else if ([object isKindOfClass:[NSNull class]]) {
#ifndef __OBJC_GC__
      my_bool *aBool = calloc(1,sizeof(my_bool));
#else
      my_bool *aBool = NSAllocateCollectable(sizeof(my_bool), NSScannedOption);
#endif
      *aBool=1;
      binding[x].is_null= aBool;
    } else {
      NSString *s = (NSString *)[object description];
      const char *ch = [s UTF8String];
      binding[x].is_null= 0;
      binding[x].buffer_type = MYSQL_TYPE_STRING; 
      binding[x].buffer_length= strlen(ch);        
    }
  }

  [columnPairs deleteCharactersInRange:NSMakeRange(0,2)];
  [cmd appendString:columnPairs];
  [cmd appendString:@" WHERE "];
  
  NSMutableString *qualifierString=[NSMutableString string];
  
  for (NSString *key in [qualifier allKeys]) {
    NSObject *value = [qualifier objectForKey:key];
    NSString *escapeKey= [key mysqlEscapeInConnection:connection];
    if ([value isKindOfClass:[NSString class]]) {
      [qualifierString appendFormat:@"AND %@='%@' ",escapeKey,[(NSString *)value mysqlEscapeInConnection:connection]];
    } else if ([value isKindOfClass:[NSNull class]]) {
      [qualifierString appendFormat:@"AND %@ is null ",escapeKey];
    } else if ([value isKindOfClass:[NSNumber class]]) {
      [qualifierString appendFormat:@"AND %@=%@ ",escapeKey,value];
    } else {
      [qualifierString appendFormat:@"AND %@='%@' ",escapeKey,[[value description] mysqlEscapeInConnection:connection]];
    }
  }
  
  [qualifierString deleteCharactersInRange:NSMakeRange(0,4)];
  [cmd appendString:qualifierString];
  
  
  
  //-----------------------
  @synchronized (connection) {
    MYSQL_STMT *myStatement = mysql_stmt_init(connection.connection);

    if (mysql_stmt_prepare(myStatement, [cmd UTF8String],[cmd length])) {
      [MysqlException raiseConnection:connection withFormat: @"mysql_stmt_prepare failed %s", mysql_stmt_error(myStatement)];
    }
    
    if (mysql_stmt_bind_param(myStatement,(MYSQL_BIND *)binding)) {
      [MysqlException raiseConnection:connection
                           withFormat:@"Could not perform mysql_stmt_bind_result() Error #%d:%s"
       ,mysql_errno(connection.connection),
       mysql_error(connection.connection)];
    }
    
    
    if (mysql_stmt_execute(myStatement)) {
      [MysqlException raiseConnection:connection
                           withFormat:@"Could not perform mysql_stmt_execute() Error #%d:%s"
       ,mysql_errno(connection.connection),
       mysql_error(connection.connection)];
    }
    
    unsigned long long rowCount = mysql_affected_rows(connection.connection);
    affectedRows = [[NSNumber numberWithUnsignedLongLong:rowCount] retain];
    
    if (mysql_stmt_close(myStatement)) {
      [MysqlException raiseConnection:connection withFormat:@" mysql_stmt_close failed %s", mysql_stmt_error(myStatement)];
    }
  }
#ifndef __OBJC_GC__
  for (NSUInteger x=0; x < [keys count];x++) {
    NSString *key= [keys objectAtIndex:x];
    NSObject *object = [rowData objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
      free(binding[x].is_null);
    }
  }
  free(binding);
#endif

}

- (void)dealloc;
{
  [connection release];
  [table release];
  [rowData release];
  [qualifier release];
  [affectedRows release];
  [super dealloc];
}

@end
