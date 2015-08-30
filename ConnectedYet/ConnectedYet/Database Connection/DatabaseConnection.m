

#import "DatabaseConnection.h"

@implementation DatabaseConnection

static DatabaseConnection *sharedInstance = nil;

#pragma mark --------------- Sigleton Copy Object ---------------------

+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

// Get the shared instance and create it if necessary.
+ (DatabaseConnection *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}


-(void) checkAndCreateDatabase
{
	BOOL success;
	
	databaseName= @"ConnectedYet.sqlite";

    
	documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];
	
	if(success)
		return;
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	//[fileManager release];
    
}


// Get Count for tables
-(int)getCountForTable:(NSString *)_tableName
{
    //app=(EfimotoAppDelegate *)[[UIApplication sharedApplication]delegate];
    int dataCount=0;
    NSString *query=[NSString stringWithFormat:@"Select count(*) from %@",_tableName];
    
#if DEBUG
    NSLog(@"--- Get Count Query :%@",query);
#endif
    
	[self checkAndCreateDatabase];
	sqlite3 *database;
	
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
	{
		
		const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
			{
				dataCount= sqlite3_column_int(compiledStatement,0);
				//NSLog(@"-- Data Count :%d",dataCount);
			}
			
		}
		sqlite3_finalize(compiledStatement);
	}
    
	sqlite3_close(database);
	
    return dataCount;
}


-(void)executeQuety:(NSString *)_query
{
	[self checkAndCreateDatabase];
#if DEBUG
    NSLog(@"--- Insert Data Query :%@",_query);
#endif
	
	sqlite3 *database;
	
	if(sqlite3_open([databasePath UTF8String],&database)==SQLITE_OK)
	{
        
		const char *sqlstatement=[_query UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database,sqlstatement, -1 , &compiledStatement,NULL)==SQLITE_OK)
		{
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting . '%s'", sqlite3_errmsg(database));
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	
}

-(NSMutableArray *)getAllCountries
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    NSString *_query = @"Select countryName, countryCode from Country";

#if DEBUG
    NSLog(@"--- Get Count Query :%@",_query);
#endif
    
    [self checkAndCreateDatabase];
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement =[_query UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                CountryData *country = [[CountryData alloc]init];
                
                country.countryName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                country.countryCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];

                [dataArray addObject:country];
                country = nil;
                
            }
            
        }
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(database);
    
    return dataArray;
    
}


-(NSMutableArray *)getDetailsForComments:(NSString *)_userId
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    NSString *_query = [NSString stringWithFormat:@"Select userName, userProfileSmall, userProfileMedium, userProfileBig from Users where userId = '%@'", _userId];
    //(userId, userFirstName, userLastName, userStatus, userName, userLatitude, userLongitude, userGender, userBirthday, userEmail, us,erCountryCode, userDistance, userCity, userState, userAge, userIsNew, userProfileSmall, userProfileMedium, userProfileBig)

#if DEBUG
    NSLog(@"--- Get Count Query :%@",_query);
#endif
    
    [self checkAndCreateDatabase];
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement =[_query UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                UsersData *users = [[UsersData alloc]init];
                
                users.userName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
               
                users.userProfileSmall = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                users.userProfileMedium = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                users.userProfileBig = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];

                [dataArray addObject:users];
                users = nil;
                
            }
            
        }
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(database);
    
    return dataArray;
    
}


-(NSMutableArray *)getChatHistoryFromDatabaseFromId:(NSString *)_fromId
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    NSString *_query = [NSString stringWithFormat:@"Select loginUserId, messageFromId, message, messageType, messageId, old, self, sent from ChatHistory where loginUserId = '%@' and messageFromId = '%@' or loginUserId = '%@' and messageFromId = '%@'", appDelegate.userDetails.userId, _fromId, _fromId, appDelegate.userDetails.userId];
    
    //ChatHistory(loginUserId, messageFromId, message, messageType, messageId, old, self, sent)
    
#if DEBUG
    NSLog(@"--- Get Count Query :%@",_query);
#endif
    
    [self checkAndCreateDatabase];
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement =[_query UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                chatMessageDTO *chatMessage=[chatMessageDTO new];
                
                //ChatHistory(loginUserId, messageFromId, message, messageType, messageId, old, self, sent)

                chatMessage.messageToUserId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                chatMessage.messageFromUserId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                chatMessage.message = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                chatMessage.messageType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
                chatMessage.messageId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
                chatMessage.messageOld = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
                chatMessage.messageSelf = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)];
                chatMessage.messageSent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,7)];

                [dataArray addObject:chatMessage];
                chatMessage = nil;
                
            }
            
        }
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(database);
    
    return dataArray;
    
}


@end
