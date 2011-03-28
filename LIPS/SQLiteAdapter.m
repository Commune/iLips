//
//  SQLiteDelegate.m
//  Circles
//
//  Created by David Herzka on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SQLiteAdapter.h"
#import "PatientEntry.h"
#import "NSString+DB.h"

@implementation SQLiteAdapter

@synthesize patients; 

- (id)init {
	databaseName = [@"PatientsDatabase.sqlite" retain];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [[documentsDir stringByAppendingPathComponent:databaseName] retain];
    [self checkAndCreateDatabase];
    [self readPatientsFromDatabase];
	return self;
}

- (void)dealloc {
	[patients release];
	[super dealloc];
}

-(void) checkAndCreateDatabase{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	[fileManager release];
}

-(void) readPatientsFromDatabase {
	sqlite3 *database;
	patients = [[NSMutableArray alloc] init];
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char *sqlStatement = "select * from patients";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSString *aPatientID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *aData = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] stringByRestoring];
                PatientEntry *patient = [[PatientEntry alloc] initWithId:aPatientID data:aData];
                [patients addObject:patient];
				[patient release];
			}
		}
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
}

-(int) runQuery:(NSString*)query {
    sqlite3 *database;
    int errorcode;
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char *sqlStatement = [query UTF8String];
		sqlite3_stmt *compiledStatement;
		sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
		errorcode = sqlite3_step(compiledStatement);
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    return errorcode;
	[self readPatientsFromDatabase];
}

-(int) addPatient:(PatientEntry*)patient {
    NSString * query = [NSString stringWithFormat:@"insert into patients(id,data) values('%@','%@')",patient.patientID,[patient.data stringBySanitizing]];
    int errorcode=[self runQuery:query];
    if(errorcode==SQLITE_DONE)
        [patients addObject:patient];
//	NSLog(@"%@",query);
//	NSLog(@"%@",patients);
    return errorcode;
}

- (int) deletePatient:(PatientEntry*)patient {
    NSString * query = [NSString stringWithFormat:@"delete from patients where id = '%@'",patient.patientID];
    int errorcode = [self runQuery:query];
	[patient retain];
    if(errorcode==SQLITE_DONE) {
		for(PatientEntry *p in patients) {
			if([p.patientID isEqualToString:patient.patientID]) {
				[patients removeObject:p];
				break;
			}
		}
    }
    return errorcode;
}

@end