//
//  MysqlFetch.m
//  mysql_connector
//
//  Created by Karl Kraft on 4/25/07.
//  Copyright 2007-2010 Karl Kraft. All rights reserved.
//


#import "MysqlFetch.h"
#import "MysqlFetchField.h"

#import "MysqlConnection.h"
#import "MysqlException.h"
#import "mysql.h"
#import "GC_MYSQL_BIND.h"


#ifndef __OBJC_GC__
#define BLOB_DEFAULT_SIZE 10000
#else
#define BLOB_DEFAULT_SIZE 1000000
#endif

@implementation MysqlFetch
@synthesize fieldNames;
@synthesize fields;
@synthesize results;




+ (MysqlFetch *)fetchWithCommand:(NSString *)s onConnection:(MysqlConnection *)connection;
{
  return [self fetchWithCommand:s onConnection:connection extendedNames:NO];
}

+ (MysqlFetch *)fetchWithCommand:(NSString *)s onConnection:(MysqlConnection *)connection extendedNames:(BOOL)useExtendedNames;
{
  NSDate *start = [NSDate date];
  MysqlFetch *mf =[[MysqlFetch alloc] init];
  
  if (!connection) {
    [MysqlException raiseConnection:nil
                         withFormat:@"connection is nil"];
    
  }
  @synchronized(connection) {
    MysqlLog(@"%@",s);
    
    // parse the statement
    
    MYSQL_STMT *myStatement = mysql_stmt_init(connection.connection);
    
    if (mysql_stmt_prepare(myStatement, [s UTF8String],[s length])) {
      [MysqlException raiseConnection:connection
                           withFormat:@"Could not perform mysql_stmt_bind_result() Error #%d:%s"
       ,mysql_errno(connection.connection),
       mysql_error(connection.connection)];
    }
    
    // build out and connect the bindings
    
#ifndef __OBJC_GC__
    GC_MYSQL_BIND *bindings=calloc(myStatement->field_count,sizeof(GC_MYSQL_BIND));
#else
    GC_MYSQL_BIND *bindings=NSAllocateCollectable(sizeof(GC_MYSQL_BIND)*myStatement->field_count,1);
#endif
    
    
    NSMutableArray *fieldNameCollector = [NSMutableArray array];
    NSMutableArray *fieldCollector = [NSMutableArray array];
    NSMutableSet *sourceTables = [NSMutableSet set];
    for (NSUInteger x=0; x < myStatement->field_count;x++) {
      NSString *table=[[NSString alloc]  initWithBytes:myStatement->fields[x].table
                                                length:myStatement->fields[x].table_length 
                                              encoding:NSUTF8StringEncoding];
      [sourceTables addObject:table];
      [table release];
      NSString *fieldName=[[NSString alloc]  initWithBytes:myStatement->fields[x].name length:myStatement->fields[x].name_length encoding:NSUTF8StringEncoding];
      [fieldNameCollector addObject:fieldName];
      [fieldName release];
      MysqlFetchField *field = [[MysqlFetchField alloc] init];
      [fieldCollector addObject:field];
      field.name=fieldName;
      field.width=myStatement->fields[x].length;
      field.fieldType=myStatement->fields[x].type;
      if (IS_PRI_KEY(myStatement->fields[x].flags)) field.primaryKey=YES;
      [field release];
      switch(myStatement->fields[x].type) {
        case MYSQL_TYPE_LONGLONG:
          bindings[x].buffer_type = myStatement->fields[x].type; 
          bindings[x].buffer_length=sizeof(long long);
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_LONG:
          bindings[x].buffer_type = myStatement->fields[x].type; 
          bindings[x].buffer_length=sizeof(long);
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_STRING:
        case MYSQL_TYPE_VAR_STRING:
          bindings[x].buffer_type = myStatement->fields[x].type; 
          bindings[x].buffer_length=myStatement->fields[x].length;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_BLOB:
          bindings[x].buffer_type = myStatement->fields[x].type; 
          bindings[x].buffer_length=BLOB_DEFAULT_SIZE;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_TINY:
          bindings[x].buffer_type = myStatement->fields[x].type; 
          bindings[x].buffer_length=1;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_NEWDECIMAL:
          bindings[x].buffer_type = MYSQL_TYPE_STRING; 
          bindings[x].buffer_length=myStatement->fields[x].length;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_TIMESTAMP:
          bindings[x].buffer_type = MYSQL_TYPE_STRING; 
          bindings[x].buffer_length=myStatement->fields[x].length;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length+1,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_FLOAT:
          bindings[x].buffer_type = MYSQL_TYPE_FLOAT;
          bindings[x].buffer_length=myStatement->fields[x].length;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length+1,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_DOUBLE:
          bindings[x].buffer_type = MYSQL_TYPE_DOUBLE;
          bindings[x].buffer_length=myStatement->fields[x].length;
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length+1,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
        case MYSQL_TYPE_DATETIME:
          bindings[x].buffer_type = MYSQL_TYPE_DATETIME;
          bindings[x].buffer_length=sizeof(MYSQL_TIME);
#ifndef __OBJC_GC__
          bindings[x].buffer = calloc(1,bindings[x].buffer_length);
          bindings[x].length= calloc(1,sizeof(unsigned long));
          bindings[x].error= calloc(1,sizeof(my_bool));
          bindings[x].is_null= calloc(1,sizeof(my_bool));
#else
          bindings[x].buffer = NSAllocateCollectable(bindings[x].buffer_length+1,0);
          bindings[x].length= NSAllocateCollectable(sizeof(unsigned long),0);
          bindings[x].error= NSAllocateCollectable(sizeof(my_bool),0);
          bindings[x].is_null= NSAllocateCollectable(sizeof(my_bool),0);
#endif
          break;
          
        default:
          [MysqlException raise:@"No Binding" format:@"No binding support for field type %d",myStatement->fields[x].type];
          break;
      } 
    }
    mf->fieldNames = [fieldNameCollector copy];
    mf->fields=[fieldCollector copy];
    
    if (mysql_stmt_bind_result(myStatement,(MYSQL_BIND *)bindings)) {
      [MysqlException raiseConnection:connection
                           withFormat:@"Could not perform mysql_stmt_bind_result() Error #%d:%s"
                          ,mysql_errno(connection.connection),
                          mysql_error(connection.connection)];
    }
    
    // peform the fetch
    
    if (mysql_stmt_execute(myStatement)) {
      [MysqlException raiseConnection:connection
                           withFormat:@"Could not perform mysql_stmt_execute() Error #%d:%s"
       ,mysql_errno(connection.connection),
       mysql_error(connection.connection)];
    }
    if ([[NSDate date]timeIntervalSinceDate:start] > 1.0) {
      MysqlLog(@"Slow query: %0.2f",[[NSDate date] timeIntervalSinceDate:start]);
      MysqlLog(@"          : %@",s);
    }
    
    // build results
    NSMutableArray *localResults = [NSMutableArray array];
    int fetchResults;
    while (true) {
      fetchResults = mysql_stmt_fetch(myStatement);
      if (fetchResults == MYSQL_NO_DATA) break;
      if (fetchResults == 1) {
        [MysqlException raiseConnection:connection
                             withFormat:@"Could not perform mysql_stmt_fetch() Error #%d:%s"
         ,mysql_errno(connection.connection),
         mysql_error(connection.connection)];
      }
      NSMutableDictionary *dict = [NSMutableDictionary dictionary];
      [localResults addObject:dict];
      for (unsigned int x=0; x < myStatement->field_count;x++) {
        MYSQL_FIELD stmtFieldName = myStatement->fields[x];
        NSString *key;
        if (useExtendedNames || [sourceTables count]>1){
          NSString *table=[[NSString alloc]  initWithBytes:myStatement->fields[x].table
                                                    length:myStatement->fields[x].table_length 
                                                  encoding:NSUTF8StringEncoding];
          NSString *fieldKeyName=[[NSString alloc]  initWithBytes:myStatement->fields[x].name 
                                                           length:myStatement->fields[x].name_length 
                                                         encoding:NSUTF8StringEncoding];
          key=[NSString stringWithFormat:@"%@.%@",table,fieldKeyName];
          [key retain];
          [table release];
          [fieldKeyName release];
        } else {
          key= [[NSString alloc]  initWithBytes:myStatement->fields[x].name 
                                         length:myStatement->fields[x].name_length 
                                       encoding:NSUTF8StringEncoding];
        }
        [key autorelease];
        if (*bindings[x].is_null==1) {
          [dict setObject:[NSNull null] forKey:key];
        } else {
          
          switch (stmtFieldName.type) {
            case MYSQL_TYPE_TINY_BLOB:
            case MYSQL_TYPE_MEDIUM_BLOB:
            case MYSQL_TYPE_LONG_BLOB:
            case MYSQL_TYPE_BLOB:
              if (fetchResults== MYSQL_DATA_TRUNCATED && *(bindings[x].error)){
                void *previousBuffer=bindings[x].buffer;
                unsigned long previousBufferSize=bindings[x].buffer_length;
                bindings[x].buffer_length=*(bindings[x].length);
#ifndef __OBJC_GC__
                bindings[x].buffer=malloc(bindings[x].buffer_length);
#else
                bindings[x].buffer=NSAllocateCollectable(bindings[x].buffer_length,0);
#endif
                
                mysql_stmt_fetch_column(myStatement, (MYSQL_BIND *)&(bindings[x]), x , 0);
                
                NSData *theData = [NSData dataWithBytes:bindings[x].buffer length:*(bindings[x].length)];
                [dict setObject:theData forKey:key];
#ifndef __OBJC_GC__
                free(bindings[x].buffer);
#endif
                bindings[x].buffer_length=previousBufferSize;
                bindings[x].buffer=previousBuffer;
              } else {
                NSData *theData = [NSData dataWithBytes:bindings[x].buffer length:*(bindings[x].length)];
                [dict setObject:theData forKey:key];
              }
              break;
              
            case MYSQL_TYPE_STRING:
            case MYSQL_TYPE_VAR_STRING:{
              // TODO - the encoding type should really be read from mysql
              NSString *theString = [[NSString alloc] initWithBytes:bindings[x].buffer
                                                             length:*(bindings[x].length) 
                                                           encoding:NSUTF8StringEncoding];
              [dict setObject:theString
                       forKey:key];
              [theString release];
            } break;
              
            case MYSQL_TYPE_LONGLONG:{
              long long *aValue = (long long *)bindings[x].buffer;
              [dict setObject:[NSNumber numberWithLongLong:*aValue] forKey:key];
            } break;
              
            case MYSQL_TYPE_LONG: {
              long *aValue = (long *)bindings[x].buffer;
              [dict setObject:[NSNumber numberWithLong:*aValue] forKey:key];
            } break;          
              
            case MYSQL_TYPE_TINY: {
              char *aValue = (char *)bindings[x].buffer;
              [dict setObject:[NSNumber numberWithChar:*aValue] forKey:key];
            } break;
              
            case MYSQL_TYPE_NEWDECIMAL:  {
              NSString *f=[[NSString alloc] initWithBytes:bindings[x].buffer length:*(bindings[x].length) encoding:NSUTF8StringEncoding];
              NSDecimalNumber *d=[[NSDecimalNumber alloc] initWithString:f];
              [f release];
              [dict setObject:d
                       forKey:key];
              [d release];
            } break;
              
              
            case MYSQL_TYPE_TIMESTAMP: {
              NSString *f=[[NSString alloc] initWithBytes:bindings[x].buffer length:*(bindings[x].length) encoding:NSUTF8StringEncoding];
              NSDateFormatter *sqlFmt = [[NSDateFormatter alloc] init];
              [sqlFmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
              NSDate *date = [sqlFmt dateFromString:f];
              [f release];
              [sqlFmt release];
              [dict setObject:date
                       forKey:key];
            } break;
              
            case MYSQL_TYPE_FLOAT:
            {
              float *aValue = (float *)bindings[x].buffer;
              [dict setObject:[NSNumber numberWithFloat:*aValue] forKey:key];
            } break;  
              
            case MYSQL_TYPE_DOUBLE:
            {
              double *aValue = (double *)bindings[x].buffer;
              [dict setObject:[NSNumber numberWithDouble:*aValue] forKey:key];
            } break;  
              
            case MYSQL_TYPE_DATETIME:
            {
              MYSQL_TIME *aValue = (MYSQL_TIME *)bindings[x].buffer;
              NSDateComponents *comps=[[NSDateComponents alloc] init];
              [comps setYear:aValue->year];
              [comps setMonth:aValue->month];
              [comps setDay:aValue->day];
              [comps setHour:aValue->hour];
              [comps setMinute:aValue->minute];
              [comps setSecond:aValue->second];
              NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
              if (date) {
                [dict setObject:date forKey:key];
              }
              [comps release];
            } break;  
              
            case MYSQL_TYPE_VARCHAR:
            case MYSQL_TYPE_DECIMAL:
            case MYSQL_TYPE_SHORT:
            case MYSQL_TYPE_NULL:
            case MYSQL_TYPE_INT24:
            case MYSQL_TYPE_DATE:
            case MYSQL_TYPE_TIME:
            case MYSQL_TYPE_YEAR:
            case MYSQL_TYPE_NEWDATE:
            case MYSQL_TYPE_BIT:
            case MYSQL_TYPE_ENUM:
            case MYSQL_TYPE_SET:
            case MYSQL_TYPE_GEOMETRY:
            default:
              [MysqlException raise:@"No Binding" format:@"fetch does not support mysql type %d for key ",bindings[x].buffer_type,key];
              break;
          }
        }
        
      }
      
    }    

    mysql_stmt_close(myStatement);  
    mf->results = [localResults copy];

#ifndef __OBJC_GC__
    for (NSUInteger x=0; x < myStatement->field_count;x++) {
      free(bindings[x].buffer);
      free(bindings[x].length);
      free(bindings[x].error);
      free(bindings[x].is_null);
    }
    free(bindings);
#endif
    
  }
  
  if ([[NSDate date]timeIntervalSinceDate:start] > 1.0) {
    MysqlLog(@"Slow fetch: %0.2f",[[NSDate date] timeIntervalSinceDate:start]);
    MysqlLog(@"          : %@",s);
  }
  

  return [mf autorelease];
}


- (void)dealloc;
{
  [fieldNames release];
  [fields release];
  [results release];
  [super dealloc];
}
@end
