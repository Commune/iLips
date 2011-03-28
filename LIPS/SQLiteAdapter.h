#import <UIKit/UIKit.h>
#import <sqlite3.h> // Import the SQLite database framework

@class PatientEntry;

@interface SQLiteAdapter : NSObject  {
	
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	// Array to store the animal objects
	NSMutableArray *patients;
}

@property (nonatomic, retain) NSMutableArray *patients;

- (int) addPatient:(PatientEntry *)patient;
- (int) deletePatient:(PatientEntry *)patient;
- (void) checkAndCreateDatabase;
- (void) readPatientsFromDatabase;

@end