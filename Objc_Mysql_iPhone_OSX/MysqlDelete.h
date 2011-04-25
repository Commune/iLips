//
//  MysqlDelete.h
//  mysql_connector
//
//  Created by Karl Kraft on 9/28/08.
//  Copyright 2008-2009 Karl Kraft. All rights reserved.
//


@class MysqlConnection;

@interface MysqlDelete : NSObject {
  MysqlConnection *connection;
  NSString *tableName;
  NSString *qualifier;
  NSNumber *affectedRows;
}

@property(assign) NSString *tableName;
@property(assign) NSString *qualifier;
@property(readonly) NSNumber *affectedRows;

+ (MysqlDelete *)deleteWithConnection:(MysqlConnection *)aConnection;
- (void)execute;

@end
