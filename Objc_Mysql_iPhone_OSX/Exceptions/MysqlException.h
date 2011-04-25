//
//  MysqlException.h
//  mysql_connector
//
//  Created by Karl Kraft on 6/19/09.
//  Copyright 2009-2010 Karl Kraft. All rights reserved.
//


@class MysqlConnection;

@interface MysqlException : NSException {

}
+ (void)raiseConnection:(MysqlConnection *)aConnection withFormat:(NSString *)format,...  __attribute__ ((noreturn));;

@end

#ifdef MYSQL_LOGGING
#define MysqlLog(args...) _reportDebug([ETErrorSpot spotWithFile:__FILE__ line:__LINE__],__PRETTY_FUNCTION__,args);
#else
#define MysqlLog(x...)
#endif
