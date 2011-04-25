//
//  MysqlFetchField.h
//  mysql_connector
//
//  Created by Karl Kraft on 10/22/09.
//  Copyright 2009-2010 Karl Kraft. All rights reserved.
//

#import "mysql.h"

@interface MysqlFetchField : NSObject {
  NSString *name;
  enum enum_field_types fieldType;
  NSUInteger width;
  BOOL primaryKey;
}

@property(retain) NSString *name;
@property(assign) enum enum_field_types fieldType;
@property(assign) NSUInteger width;
@property(assign) BOOL primaryKey;

@end
