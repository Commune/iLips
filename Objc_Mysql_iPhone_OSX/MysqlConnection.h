//
//  MysqlConnection.h
//  mysql_connector
//
//  Created by Karl Kraft on 5/21/08.
//  Copyright 2008-2010 Karl Kraft. All rights reserved.
//


#import "mysql.h"

@interface MysqlConnection : NSObject {
 MYSQL _connection;
}

@property(readonly,getter=getConnection) MYSQL *connection;

+ (MysqlConnection *)connectToHost:(NSString *)host
                              user:(NSString *)user
                          password:(NSString *)password
                            schema:(NSString *)schema
                             flags:(unsigned long)flags;


+ (MysqlConnection *)connectWithDictionary:(NSDictionary *)aDict;


- (void)enableTransactions;
- (void)disableTransactions;
- (void)commitTransaction;
- (void)rollbackTransaction;

- (void)enableStrictSql;

- (void)startIdle;
@end



#define MYSQL_DEFAULT_CONNECTION_FLAGS CLIENT_FOUND_ROWS


