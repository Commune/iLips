//
//  MysqlConnection.m
//  mysql_connector
//
//  Created by Karl Kraft on 5/21/08.
//  Copyright 2008-2010 Karl Kraft. All rights reserved.
//

#import "MysqlConnection.h"
#import "MysqlCommitException.h"
#import "MysqlRollbackException.h"
#import "GC_MYSQL_BIND.h"


@implementation MysqlConnection


+ (void)initialize;
{
  if (sizeof(MYSQL_BIND) != sizeof(GC_MYSQL_BIND) ) {
    [MysqlException raise:@"Failed to initialize" format:@"MYSQL_BIND and GC_MYSQL_BIND differ in size."];
  }
}

+ (MysqlConnection *)connectToHost:(NSString *)host
                              user:(NSString *)user
                          password:(NSString *)password
                            schema:(NSString *)schema
                             flags:(unsigned long)flags;
{
  MysqlConnection *newObject = [[self alloc] init];
  
  mysql_init(&(newObject->_connection));
  if (!mysql_real_connect(&(newObject->_connection),
                          [host cStringUsingEncoding:NSUTF8StringEncoding],
                          [user cStringUsingEncoding:NSUTF8StringEncoding],
                          [password cStringUsingEncoding:NSUTF8StringEncoding],
                          [schema cStringUsingEncoding:NSUTF8StringEncoding],
                          0,  // default port
                          NULL,  // default socket
                          flags)) {
    MysqlLog(@"Failed to connect to database: Error: %s\n",mysql_error(&(newObject->_connection)));
    [newObject release];
    return nil;
  } else {
    MysqlLog(@"Connected to %@",host);
  }
  if (!mysql_set_character_set(&(newObject->_connection), "utf8")) {
    MysqlLog(@"Client character set: %s\n", mysql_character_set_name(&(newObject->_connection)));
  }
  
  return [newObject autorelease];
}

+ (MysqlConnection *)connectWithDictionary:(NSDictionary *)aDict;
{
  NSString *host = [aDict objectForKey:@"Host"];
  NSString *user = [aDict objectForKey:@"User"];
  NSString *password = [aDict objectForKey:@"Password"];
  NSString *schema = [aDict objectForKey:@"Schema"];
  
  return [self connectToHost:host user:user password:password schema:schema flags:MYSQL_DEFAULT_CONNECTION_FLAGS];
}
- (MYSQL *)getConnection;
{
  return &_connection;
}

- (void)enableStrictSql;
{
  MysqlLog(@"Setting strict sql");
  
  if (mysql_query(&_connection, "set sql_mode=strict_all_tables")) {
    [MysqlException raiseConnection:self 
                         withFormat:@"Could not set sql_mode #%d:%s",mysql_errno(&_connection), mysql_error(&_connection)];
  }
}

- (void)enableTransactions;
{
  MysqlLog(@"Transactions Enabled");
  mysql_autocommit(&_connection, 0);
}

- (void)disableTransactions;
{
  MysqlLog(@"Transactions Disabled");
  mysql_autocommit(&_connection, 1);
}

- (void)commitTransaction;
{
  if (mysql_commit(&_connection)) {
    [MysqlCommitException raiseConnection:self withFormat:@"Transaction commit failed (%s)",mysql_error(&_connection)];
  } else {
    MysqlLog(@"Transaction committed");
  }
}

- (void)rollbackTransaction;
{
  if (mysql_rollback(&_connection)) {
    [MysqlRollbackException raiseConnection:self withFormat:@"Transaction rollback failed (%s)",mysql_error(&_connection)];
  } else {
    MysqlLog(@"Transaction committed");
  }
}

- (void)sendIdle:(NSTimer *)t;
{
  MysqlLog(@"Sending idle");
  mysql_query(&_connection, "select 'MysqlConnect:idleTmer'");
  MYSQL_RES     *theResults = mysql_use_result(&_connection);
  mysql_free_result(theResults);  
}

- (void)startIdle;
{
  [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(sendIdle:) userInfo:nil repeats:YES];
}

- (void)dealloc;
{
  mysql_close(&_connection);
  [super dealloc];  
}

- (void)finalize;
{
  mysql_close(&_connection);
  [super finalize];
}
@end
