


#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "CountryData.h"
#import "UsersData.h"

#import "AppDelegate.h"

@interface DatabaseConnection : NSObject
{
    AppDelegate *appDelegate;
    
	NSString *databaseName;
	NSString *databasePath;
	NSArray *documentPaths;
	NSString *documentsDir;
	
}

+ (id)allocWithZone:(NSZone*)zone;
+ (DatabaseConnection *)sharedInstance;


-(int)getCountForTable:(NSString *)_tableName;
-(void)executeQuety:(NSString *)_query;
-(NSMutableArray *)getAllCountries;

-(NSMutableArray *)getDetailsForComments:(NSString *)_userId;

-(NSMutableArray *)getChatHistoryFromDatabaseFromId:(NSString *)_fromId;

@end
