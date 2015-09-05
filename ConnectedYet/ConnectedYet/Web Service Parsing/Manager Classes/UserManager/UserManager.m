//
//  UserManager.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 28/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "UserManager.h"

#import "MYSStringUtils.h"
#import "JSONStringGenerator.h"
#import "Constant.h"


@implementation UserManager

@synthesize userManagerDelegate;


#pragma mark -----  -----  -----  ------
#pragma mark -----  -----  GET METHODS -----  ------

-(void)getAllUsersDetails:(NSString *)_keys     //Get All USers Details
{
    //Url: http://aegis-infotech.com/connectedyet/web/api/users/{id}/lists/{key}(all,f,m,online)

#if DEBUG
    NSLog(@"-- Get All Users For :%@", _keys);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"users/%@/lists/%@",appDelegate.userDetails.userId, _keys] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"users_list"];

}

-(void)getUserDetails:(NSString *)_userId     //Get USers Details
{
    //Url: http://aegis-infotech.com/connectedyet/web/api/users/{memberId}/details/{login_user_ID}
 
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Get Users Details");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"users/%@/details/%@",_userId, appDelegate.userDetails.userId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"users_details"];

}


-(void)getEncounterDetailsWihEncounterId:(NSString *)_encounterId
{
    http://aegis-infotech.com/connectedyet/web/api/encounters/{loginuserid}/lists/{currentencounterid}
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Get Users Details");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"encounters/%@/lists/%@", appDelegate.userDetails.userId, _encounterId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"encounters_details"];
    
}

#pragma mark -----  -----  -----  ------
#pragma mark -----  -----  POST METHODS -----  ------

-(void)registerNewUser:(NSMutableDictionary *)_dataDict
{
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    //NSString *signature = [MYSStringUtils generateSignatureForString:jsonInput withKey:APP_SHRAED_KEY];
    //NSString *newinputParamString =[MYSStringUtils convertStringInToHex:jsonInput];
    //NSString *inputString = [NSString stringWithFormat:@"data=%@&auth=%@",jsonInput,signature];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:@"users"
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"register"];
    
    
}

-(void)addNewContact:(NSMutableDictionary *)_dataDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    /*
     URL: http://aegis-infotech.com/connectedyet/web/api/requests/{id}
     parameter: {"friend_id": 139,"status":"liked"}'
     */
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"requests/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"add_contact"];
    
    
}


-(void)postCommentOnServer:(NSMutableDictionary *)_dataDict
{
    ////http://aegis-infotech.com/connectedyet/web/connectedyet/web/api/comments/{id}

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    

#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"comments/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"post_comment"];
    
}


-(void)postLikeUnlikeOnServer:(NSMutableDictionary *)_dataDict
{
    //http://aegis-infotech.com/connectedyet/web/connectedyet/web/api/walllikes/{id}

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"walllikes/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"like_unlike"];
    
}

-(void)inviteContactToApplication:(NSMutableDictionary *)_dataDict
{
    //URL: http://aegis-infotech.com//connectedyet/web/api/invites/{id}
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"invites/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"invite_contact"];
/*
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"invites/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"invite_contact"];
    */
}


-(void)deletePostWithPostId:(NSString *)_postId loginUserId:(NSString *)_userId
{
//URL: http://aegis-infotech.com/connectedyet/web/connectedyet/web/api/walls/{id}/deletes/{wallid}
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"walls/%@/deletes/%@", _userId, _postId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"delete_post"];

}


-(void)deleteCommentWithCommentId:(NSString *)_commentId loginUserId:(NSString *)_userId
{
//http://aegis-infotech.com/connectedyet/web/connectedyet/web/api/walls/{id}/comments/{commentid}
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"walls/%@/comments/%@", _userId, _commentId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"delete_comment"];

}

-(void)getWallPostCommentsAndLikeDetailsWithPostId:(NSString *)_postId;
{
    //http://aegis-infotech.com/connectedyet/web/api/walls/178/datas/51
    //Where  51 post id and 178 login user ID.
        
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"walls/%@/datas/%@", appDelegate.userDetails.userId, _postId]
                    withBodyParameters:nil
                  withHeaderParameters:nil
                         withRequestId:@"get_comment_like_data"];
    
}


-(void)getGalleryImagesForUserId:(NSString *)_galleryUserId withLoginUserId:(NSString *)_loginUserId
{
    //http://aegis-infotech.com/connectedyet/web//api/galleries/{id}/datas/{gallery_user_id}
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"galleries/%@/datas/%@", _loginUserId, _galleryUserId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"get_gallery_images"];

}


-(void)deleteGalleryImagesForUserId:(NSString *)_userId withImageId:(NSMutableDictionary *)_dataDict
{
    //URL: http://aegis-infotech.com//connectedyet/web/api/gallerydeletes/{id}

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];

    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"gallerydeletes/%@", _userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"delete_gallery_images"];
    
}

-(void)setFriendRequestStatus:(NSMutableDictionary *)_dataDict
{
    //URL: http://aegis-infotech.com/connectedyet/web/api/requests/{id}

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"requests/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"friend_request"];
    
}


-(void)getMyMatchListDetails
{
    //http://aegis-infotech.com/connectedyet/web/api/matrimonies/201/matches

    //NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@/matches", appDelegate.userDetails.userId]
                    withBodyParameters:nil
                  withHeaderParameters:nil
                         withRequestId:@"my_match"];
    
}

-(void)uploadWallPost:(NSMutableDictionary *)_dataDict
{
    //URL: http://aegis-infotech.com/connectedyet/web/api/addwalls/{id}

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"addwalls/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"upload_wallpost"];
    
}

-(void)searchUsers:(NSMutableDictionary *)_dataDict
{
#if DEBUG
    NSLog(@"--- Data :%@",_dataDict);
#endif

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"userssearches/%@", appDelegate.userDetails.userId] withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding] withHeaderParameters:nil withRequestId:@"search_user"];
    
}


-(void)getRadarUsersDetails:(NSMutableDictionary *)_dataDict
{
#if DEBUG
    NSLog(@"--- Data :%@",_dataDict);
#endif

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"radars/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"radar_user"];
    
}

#pragma mark --- --- ---- ---- ----
#pragma mark ---- Comet Chat API  ----

-(void)getUsersOneToOneChatHistoryForloginUserId:(NSString *)_loginUserId anotherUserId:(NSString *)_otherUserId
{
    //http://aegis-infotech.com/connectedyet/web/api/histories/234/datas/178
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"histories/%@/datas/%@", _loginUserId, _otherUserId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"one_one_history"];

}

-(void)getInboxChatHistoryDetailsForUserId:(NSString *)_loginUserId
{
    //http://aegis-infotech.com/connectedyet/web/api/chathistories/234
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"chathistories/%@", _loginUserId] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"inbox_chat_history"];
    
}

#pragma mark --- --- ---- ---- ----
#pragma mark ---- API Response Methods  ----

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    NSLog(@"--- Response :%@",responseDictionary);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSMutableData *data = [responseDictionary valueForKey:MYS_RESPONSE_DATA_KEY];
    NSError* error = nil;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    //int status = [[json valueForKey:@"RequestStatus"] intValue];
    NSLog(@"--- Response :%@",json);
    
    //if(status)
    //{
    
    if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"users_list"])
    {
        //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);

        NSMutableArray *dataArray = [[NSMutableArray alloc]init];

        NSMutableDictionary *usersData = [[json valueForKey:@"response"] valueForKey:@"data"];
        
        NSString *query = [NSString stringWithFormat:@"Delete from Users"];
        database = [[DatabaseConnection alloc]init];
        [database executeQuety:query];

        //if(![usersData isKindOfClass:[NSNull class]])
        {
            for(int i=0; i<[usersData count]; i++)
            {
                UsersData *userDataObject = [[UsersData alloc]init];
                
                userDataObject.userId = [appDelegate checkForNullValue:[[usersData valueForKey:@"id"] objectAtIndex:i]];
                userDataObject.userStatus = [appDelegate checkForNullValue:[[usersData valueForKey:@"status"] objectAtIndex:i]];

                
                userDataObject.userFirstName = [appDelegate checkForNullValue:[[usersData valueForKey:@"fisrtname"] objectAtIndex:i]];
                userDataObject.userLastName = [appDelegate checkForNullValue:[[usersData valueForKey:@"lastname"] objectAtIndex:i]];
                
                userDataObject.userLongitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"longitude"] objectAtIndex:i]];
                userDataObject.userLatitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"latitude"] objectAtIndex:i]];
                
                
                userDataObject.userName = [appDelegate checkForNullValue:[[usersData valueForKey:@"username"] objectAtIndex:i]];
                userDataObject.userGender = [appDelegate checkForNullValue:[[usersData valueForKey:@"gender"] objectAtIndex:i]];
                
                
                userDataObject.userBirthDate = [appDelegate checkForNullValue:[[usersData valueForKey:@"date_of_birth"] objectAtIndex:i]];
                userDataObject.userEmail = [appDelegate checkForNullValue:[[usersData valueForKey:@"email"] objectAtIndex:i]];
                
                userDataObject.userCountryCode = [appDelegate checkForNullValue:[[usersData valueForKey:@"country"] objectAtIndex:i]];
                userDataObject.userDistance = [appDelegate checkForNullValue:[[usersData valueForKey:@"distance"] objectAtIndex:i]];
                
                userDataObject.userCity = [appDelegate checkForNullValue:[[usersData valueForKey:@"city"] objectAtIndex:i]];
                userDataObject.userState = [appDelegate checkForNullValue:[[usersData valueForKey:@"state"] objectAtIndex:i]];
                
                userDataObject.userAge = [appDelegate checkForNullValue:[[usersData valueForKey:@"age"] objectAtIndex:i]];
                userDataObject.userIsNew = [appDelegate checkForNullValue:[[usersData valueForKey:@"isnew"] objectAtIndex:i]];
                
                
                userDataObject.userProfileSmall = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicSmall"] objectAtIndex:i]];
                userDataObject.userProfileMedium = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePic"] objectAtIndex:i]];
                userDataObject.userProfileBig = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicBig"] objectAtIndex:i]];
                
                NSString *query = [NSString stringWithFormat:@"Insert into Users(userId, userFirstName, userLastName, userStatus, userName, userLatitude, userLongitude, userGender, userBirthday, userEmail, userCountryCode, userDistance, userCity, userState, userAge, userIsNew, userProfileSmall, userProfileMedium, userProfileBig) values('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", userDataObject.userId, userDataObject.userFirstName, userDataObject.userLastName, userDataObject.userStatus, userDataObject.userName, userDataObject.userLatitude, userDataObject.userLongitude, userDataObject.userGender, userDataObject.userBirthDate, userDataObject.userEmail, userDataObject.userCountryCode, userDataObject.userDistance, userDataObject.userCity, userDataObject.userState, userDataObject.userAge, userDataObject.userIsNew, userDataObject.userProfileSmall, userDataObject.userProfileMedium, userDataObject.userProfileBig];
                
                [database executeQuety:query];
                
                [dataArray addObject:userDataObject];
                userDataObject = nil;
            }
        }

        if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithUserListDetails:)])
            [userManagerDelegate successWithUserListDetails:dataArray];
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"users_details"])
    {
        //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);

        NSMutableDictionary *userDict = [[json valueForKey:@"response"] valueForKey:@"data"];
        
        UsersData *usersDataObject = [[UsersData alloc]init];
        
        usersDataObject.userId = [appDelegate checkForNullValue:[userDict valueForKey:@"id"]];

        usersDataObject.userFirstName = [appDelegate checkForNullValue:[userDict valueForKey:@"fisrtname"]];
        usersDataObject.userLastName = [appDelegate checkForNullValue:[userDict valueForKey:@"lastname"]];
        usersDataObject.userName = [appDelegate checkForNullValue:[userDict valueForKey:@"username"]];

        usersDataObject.userAge = [appDelegate checkForNullValue:[userDict valueForKey:@"age"]];
        usersDataObject.userBiography = [appDelegate checkForNullValue:[userDict valueForKey:@"biography"]];
        usersDataObject.userGender = [appDelegate checkForNullValue:[userDict valueForKey:@"gender"]];


        usersDataObject.userAudio = [appDelegate checkForNullValue:[userDict valueForKey:@"audio"]]; 
        usersDataObject.userInterest = [appDelegate checkForNullValue:[userDict valueForKey:@"userintrest"]];
        
        usersDataObject.userBodyType = [appDelegate checkForNullValue:[userDict valueForKey:@"body_type"]];
        usersDataObject.userCountryCode = [appDelegate checkForNullValue:[userDict valueForKey:@"country"]];

        usersDataObject.userProfileBig = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePicBig"]];
        usersDataObject.userProfileSmall = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePicSmall"]];
        usersDataObject.userProfileMedium = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePic"]];
        
        usersDataObject.userBirthDate = [appDelegate checkForNullValue:[userDict valueForKey:@"date_of_birth"]];
        usersDataObject.userRelStatus = [appDelegate checkForNullValue:[userDict valueForKey:@"relation_status"]];

        usersDataObject.userCoverSmall = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPicSmall"]];
        usersDataObject.userCoverBig = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPicBig"]];
        usersDataObject.userCoverMedium = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPic"]];

        usersDataObject.userLatitude = [appDelegate checkForNullValue:[userDict valueForKey:@"latitude"]];
        usersDataObject.userLongitude = [appDelegate checkForNullValue:[userDict valueForKey:@"longitude"]];
        
        usersDataObject.userCity = [appDelegate checkForNullValue:[userDict valueForKey:@"city"]];
        usersDataObject.userState = [appDelegate checkForNullValue:[userDict valueForKey:@"state"]];

        usersDataObject.userLastLogin = [appDelegate checkForNullValue:[userDict valueForKey:@"last_login"]];
        usersDataObject.userPreferedLang = [appDelegate checkForNullValue:[userDict valueForKey:@"prefered_lang"]];
        //usersDataObject.userPreferedLangId = [appDelegate checkForNullValue:[userDict valueForKey:@"id"]];
        
        usersDataObject.userEmail = [appDelegate checkForNullValue:[userDict valueForKey:@"email"]];
        
        
        usersDataObject.userEyeColor = [appDelegate checkForNullValue:[userDict valueForKey:@"eye_color"]];
        usersDataObject.userHairColor = [appDelegate checkForNullValue:[userDict valueForKey:@"hair_color"]];
        usersDataObject.userWantMore = [appDelegate checkForNullValue:[userDict valueForKey:@"whatmore"]];
        usersDataObject.userSmoke = [appDelegate checkForNullValue:[userDict valueForKey:@"smoke"]];
        usersDataObject.userIsHowMany = [appDelegate checkForNullValue:[userDict valueForKey:@"ishowmany"]];
        usersDataObject.userDrink = [appDelegate checkForNullValue:[userDict valueForKey:@"drink"]];
        usersDataObject.userKids = [appDelegate checkForNullValue:[userDict valueForKey:@"kids"]];
        usersDataObject.userExcersize = [appDelegate checkForNullValue:[userDict valueForKey:@"excersize"]];
        usersDataObject.userSign = [appDelegate checkForNullValue:[userDict valueForKey:@"sign"]];

        usersDataObject.userInterest = [appDelegate checkForNullValue:[userDict valueForKey:@"interestedin"]];

        
        NSMutableDictionary *heightData = [userDict valueForKey:@"height"];
        if([heightData count])
        {
            usersDataObject.userHeight = [appDelegate checkForNullValue:[heightData valueForKey:@"name"]];
            usersDataObject.userHeightId = [appDelegate checkForNullValue:[heightData valueForKey:@"id"]];

        }
       
        
        NSMutableDictionary *salaryData = [userDict valueForKey:@"salary"];
        if([salaryData count])
        {
            usersDataObject.userSalary = [appDelegate checkForNullValue:[salaryData valueForKey:@"name"]];
            usersDataObject.userSalaryId = [appDelegate checkForNullValue:[salaryData valueForKey:@"id"]];

        }
       
        
        NSMutableDictionary *occupationData = [userDict valueForKey:@"occupation"];
        if([occupationData count])
        {
            usersDataObject.userOccupation = [appDelegate checkForNullValue:[occupationData valueForKey:@"name"]];
            usersDataObject.userOccupationId = [appDelegate checkForNullValue:[occupationData valueForKey:@"id"]];

        }
    
        
        NSMutableDictionary *religionData = [userDict valueForKey:@"religion"];
        if([religionData count])
        {
            usersDataObject.userReligion = [appDelegate checkForNullValue:[religionData valueForKey:@"name"]];
            usersDataObject.userReligionId = [appDelegate checkForNullValue:[religionData valueForKey:@"id"]];

        }
        
        
        NSMutableDictionary *ethnicityDict = [userDict valueForKey:@"ethnicity"];
        usersDataObject.arrayUserEthnicity = [[NSMutableArray alloc] init];
       
       // if([ethnicityDict isKindOfClass:[NSMutableDictionary class]])
        {
            for(int i = 0; i<[ethnicityDict count]; i++)
            {
                UsersData *ethnicityDataObj = [[UsersData alloc] init];
                
                ethnicityDataObj.userEthnicity = [appDelegate checkForNullValue:[ethnicityDict valueForKey:@"name"]];
                ethnicityDataObj.userEthnicityId = [appDelegate checkForNullValue:[ethnicityDict valueForKey:@"id"]];
                
                [usersDataObject.arrayUserEthnicity addObject:ethnicityDataObj];
                ethnicityDataObj = nil;
                
            }
        }
        
     
        NSMutableDictionary *exerciseDict = [userDict valueForKey:@"excersize_sport"];
        usersDataObject.arrayUserExersizeSport = [[NSMutableArray alloc]init];
        //if([exerciseDict isKindOfClass:[NSMutableDictionary class]])
        {
            for(int i = 0; i<[exerciseDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                dataObj.userExSport = [appDelegate checkForNullValue:[exerciseDict valueForKey:@"name"]];
                dataObj.userExSportId = [appDelegate checkForNullValue:[exerciseDict valueForKey:@"id"]];
                
                [usersDataObject.arrayUserExersizeSport addObject:dataObj];
                dataObj = nil;
                
            }
        }
        
        
        NSMutableDictionary *galleryDict = [userDict valueForKey:@"galleries"];
        usersDataObject.arrayUserGalleryPhoto = [[NSMutableArray alloc] init];
        for(int i = 0; i<[galleryDict count]; i++)
        {
            UsersData *dataObj = [[UsersData alloc] init];
            
            dataObj.userProfileId = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"id"] objectAtIndex:i]];

            dataObj.userProfileBig = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"big"] objectAtIndex:i]];
            dataObj.userProfileSmall = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"small"] objectAtIndex:i]];
            dataObj.userProfileMedium = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"org"] objectAtIndex:i]];

            [usersDataObject.arrayUserGalleryPhoto addObject:dataObj];
            dataObj = nil;
            
          
        }
        
        NSMutableDictionary *languageDict = [userDict valueForKey:@"lang_speak"];
        NSMutableArray *languageArray = [userDict valueForKey:@"lang_speak"]; //ARRAY---

        usersDataObject.arrayUserLanguageSpeak = [[NSMutableArray alloc] init];

        //if([languageDict isKindOfClass:[NSMutableDictionary class]])
        {
            for(int i = 0; i<[languageDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                //dataObj.userLanguage = [appDelegate checkForNullValue:[languageDict valueForKey:@"name"]];
                //dataObj.userLanguageId = [appDelegate checkForNullValue:[languageDict valueForKey:@"id"]];
                
                dataObj.userLanguageId = [languageArray objectAtIndex:i];
                [usersDataObject.arrayUserLanguageSpeak addObject:dataObj];
                dataObj = nil;
                
            }
        }
       
        
        NSMutableDictionary *movieDict = [userDict valueForKey:@"movies"];
        usersDataObject.arrayUserMovies = [[NSMutableArray alloc] init];
        //if([movieDict isKindOfClass:[NSMutableDictionary class]])
        {
            for(int i = 0; i<[movieDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                dataObj.userLanguage = [appDelegate checkForNullValue:[movieDict valueForKey:@"name"]];
                dataObj.userLanguageId = [appDelegate checkForNullValue:[movieDict valueForKey:@"id"]];
                
                [usersDataObject.arrayUserMovies addObject:dataObj];
                dataObj = nil;
                
            }

        }
        
        NSMutableDictionary *eduDict = [userDict valueForKey:@"edu_level"];
        usersDataObject.arrayUserEducation = [[NSMutableArray alloc] init];

        for(int i = 0; i<[movieDict count]; i++)
        {
            UsersData *dataObj = [[UsersData alloc] init];
                
            dataObj.userEducation = [appDelegate checkForNullValue:[eduDict valueForKey:@"name"]];
            dataObj.userEducationId = [appDelegate checkForNullValue:[eduDict valueForKey:@"id"]];
                
            [usersDataObject.arrayUserEducation addObject:dataObj];
            dataObj = nil;
                
        }
            
        NSMutableDictionary *wallDict = [userDict valueForKey:@"wall"];
        usersDataObject.arrayUserWallData = [[NSMutableArray alloc] init];
        
        for(int i = 0; i<[wallDict count]; i++)
        {
            UsersData *dataObj = [[UsersData alloc] init];
            
            dataObj.userPostLiked = [appDelegate checkForNullValue:[[wallDict valueForKey:@"islike"] objectAtIndex:i]];
            dataObj.userPostedDate = [appDelegate checkForNullValue:[[wallDict valueForKey:@"postedOn"] objectAtIndex:i]];

            dataObj.userPostTotalLikes = [appDelegate checkForNullValue:[[wallDict valueForKey:@"totallikes"] objectAtIndex:i]];
            dataObj.userPostId = [appDelegate checkForNullValue:[[wallDict valueForKey:@"id"] objectAtIndex:i]];

            dataObj.userPostVideoUrl = [appDelegate checkForNullValue:[[wallDict valueForKey:@"videourl"] objectAtIndex:i]];

            dataObj.userPostedById = [appDelegate checkForNullValue:[[wallDict valueForKey:@"postedBy"] objectAtIndex:i]];
            dataObj.userPostDescription = [appDelegate checkForNullValue:[[wallDict valueForKey:@"description"] objectAtIndex:i]];
            dataObj.userPostTotalComments = [appDelegate checkForNullValue:[[wallDict valueForKey:@"totalcomments"] objectAtIndex:i]];

            
            NSMutableDictionary *postImages = [[wallDict valueForKey:@"image"] objectAtIndex:i];
            
            if(postImages)
            {
                dataObj.userPostImgSmall = [appDelegate checkForNullValue:[postImages valueForKey:@"small"]];
                dataObj.userPostImgBig = [appDelegate checkForNullValue:[postImages valueForKey:@"big"]];

                dataObj.userPostImgMedium = [appDelegate checkForNullValue:[postImages valueForKey:@"org"]];
                dataObj.userPostImgWall = [appDelegate checkForNullValue:[postImages valueForKey:@"wall"]];

            }
            
            NSMutableDictionary *postLikes = [[wallDict valueForKey:@"likes"] objectAtIndex:i];

            if(postLikes)
            {
                dataObj.userPostLikedBy = [appDelegate checkForNullValue:[postLikes valueForKey:@"likedBy"]];
                dataObj.userPostLikeDate = [appDelegate checkForNullValue:[postLikes valueForKey:@"likedOn"]];
            }

            NSMutableDictionary *commentsDict = [[wallDict valueForKey:@"comments"] objectAtIndex:i];
            dataObj.arrayCommentsList = [[NSMutableArray alloc] init];
            
            if(![commentsDict isKindOfClass:[NSNull class]])
            {
                for(int j = 0; j<[commentsDict count]; j++)
                {
                    UsersData *commentObj = [[UsersData alloc] init];
                    
                    commentObj.userComment = [[commentsDict valueForKey:@"comment"] objectAtIndex:j];
                    commentObj.userCommentId = [[commentsDict valueForKey:@"comment_id"] objectAtIndex:j];

                    commentObj.userCommentById = [[commentsDict valueForKey:@"commentedBy"] objectAtIndex:j];
                    commentObj.userCommentDate = [[commentsDict valueForKey:@"commentedOn"] objectAtIndex:j];
                    
                    
                    if([commentObj.userCommentById intValue] == [appDelegate.userDetails.userId intValue])
                    {
                        commentObj.userName = appDelegate.userDetails.userName;
                        commentObj.userProfileSmall = appDelegate.userDetails.userProfileSmall;
                        commentObj.userProfileMedium = appDelegate.userDetails.userProfileMedium;
                        commentObj.userProfileBig = appDelegate.userDetails.userProfileBig;

                    }
                    else
                    {
                        database = [[DatabaseConnection alloc]init];
                        NSMutableArray *temp = [database getDetailsForComments:commentObj.userCommentById];
                        
                        if(temp.count)
                        {
                            commentObj.userName = [[temp objectAtIndex:0] userName];
                            commentObj.userProfileSmall = [[temp objectAtIndex:0] userProfileSmall];
                            commentObj.userProfileMedium = [[temp objectAtIndex:0] userProfileMedium];
                            commentObj.userProfileBig = [[temp objectAtIndex:0] userProfileBig];
                            
                        }

                    }
                    
                    [dataObj.arrayCommentsList addObject:commentObj];
                    commentObj = nil;
                    
                }
            }
            
            [usersDataObject.arrayUserWallData addObject:dataObj];
            dataObj = nil;
            

        }

        
        if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithUserDetails:)])
            [userManagerDelegate successWithUserDetails:usersDataObject];

    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"add_contact"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);

        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithAddContactRequest:)])
                [userManagerDelegate successWithAddContactRequest:message];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];

        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"encounters_details"])
    {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);

        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"true"])
        {
            NSMutableDictionary *userDict = [[json valueForKey:@"response"] valueForKey:@"data"];
            
            UsersData *usersDataObject = [[UsersData alloc]init];
            
            usersDataObject.userId = [appDelegate checkForNullValue:[userDict valueForKey:@"id"]];
            usersDataObject.userName = [appDelegate checkForNullValue:[userDict valueForKey:@"username"]];
            
            usersDataObject.userCountryCode = [appDelegate checkForNullValue:[userDict valueForKey:@"country"]];
            usersDataObject.userState = [appDelegate checkForNullValue:[userDict valueForKey:@"state"]];
            usersDataObject.userCity = [appDelegate checkForNullValue:[userDict valueForKey:@"city"]];
            
            
            usersDataObject.userBiography= [appDelegate checkForNullValue:[userDict valueForKey:@"biography"]];
            usersDataObject.userEmail = [appDelegate checkForNullValue:[userDict valueForKey:@"email"]];
            
            usersDataObject.userProfileMedium = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePic"]];
            usersDataObject.userProfileSmall = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePicSmall"]];
            usersDataObject.userProfileBig = [appDelegate checkForNullValue:[userDict valueForKey:@"profilePicBig"]];
            
            
            usersDataObject.userBirthDate = [appDelegate checkForNullValue:[userDict valueForKey:@"date_of_birth"]];
            usersDataObject.userGender = [appDelegate checkForNullValue:[userDict valueForKey:@"gender"]];
            
            
            usersDataObject.userAge = [appDelegate checkForNullValue:[userDict valueForKey:@"age"]];
            usersDataObject.userCoverBig = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPicBig"]];
            
            usersDataObject.userCoverMedium = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPic"]];
            usersDataObject.userCoverSmall = [appDelegate checkForNullValue:[userDict valueForKey:@"coverPicSmall"]];
            
            
            NSMutableDictionary *galleryDict = [userDict valueForKey:@"galleries"];
            usersDataObject.arrayUserGalleryPhoto = [[NSMutableArray alloc] init];
            for(int i = 0; i<[galleryDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                dataObj.userProfileId = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"id"] objectAtIndex:i]];

                dataObj.userProfileBig = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"big"] objectAtIndex:i]];
                dataObj.userProfileSmall = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"small"] objectAtIndex:i]];
                dataObj.userProfileMedium = [appDelegate checkForNullValue:[[galleryDict valueForKey:@"org"] objectAtIndex:i]];
                
                [usersDataObject.arrayUserGalleryPhoto addObject:dataObj];
                dataObj = nil;
                
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithEncounterDetails:)])
                [userManagerDelegate successWithEncounterDetails:usersDataObject];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:[[json valueForKey:@"response"] valueForKey:@"message"]];

        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"post_comment"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            
            NSMutableDictionary *commentsDict = [[[json valueForKey:@"response"] valueForKey:@"data"] valueForKey:@"comments"];
            
            if(![commentsDict isKindOfClass:[NSNull class]])
            {
                for(int j = 0; j<[commentsDict count]; j++)
                {
                    UsersData *commentObj = [[UsersData alloc] init];
                    
                    commentObj.userComment = [[commentsDict valueForKey:@"comment"] objectAtIndex:j];
                    commentObj.userCommentId = [[commentsDict valueForKey:@"comment_id"] objectAtIndex:j];
                    
                    commentObj.userCommentById = [[commentsDict valueForKey:@"commentedBy"] objectAtIndex:j];
                    commentObj.userCommentDate = [[commentsDict valueForKey:@"commentedOn"] objectAtIndex:j];
                    
                    
                    commentObj.userName = appDelegate.userDetails.userName;
                    commentObj.userProfileSmall = appDelegate.userDetails.userProfileSmall;
                    commentObj.userProfileMedium = appDelegate.userDetails.userProfileMedium;
                    commentObj.userProfileBig = appDelegate.userDetails.userProfileBig;

                    [dataArray addObject:commentObj];
                    commentObj = nil;
                    
                }
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successfullyPostComment: commentArray:)])
                [userManagerDelegate successfullyPostComment:message commentArray:dataArray];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];

        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"like_unlike"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successfullyLikeUnlikePost:)])
                [userManagerDelegate successfullyLikeUnlikePost:message];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];
            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"delete_post"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successfullyDeletePost:)])
                [userManagerDelegate successfullyDeletePost:message];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"delete_comment"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableDictionary *dataDict = [[json valueForKey:@"response"] valueForKey:@"data"];

            NSMutableDictionary *commentsDict = [dataDict valueForKey:@"comments"];
            NSMutableArray *dataArray= [[NSMutableArray alloc] init];
            
            if(![commentsDict isKindOfClass:[NSNull class]])
            {
                for(int j = 0; j<[commentsDict count]; j++)
                {
                    UsersData *commentObj = [[UsersData alloc] init];
                    
                    commentObj.userComment = [[commentsDict valueForKey:@"comment"] objectAtIndex:j];
                    commentObj.userCommentId = [[commentsDict valueForKey:@"comment_id"] objectAtIndex:j];
                    
                    commentObj.userCommentById = [[commentsDict valueForKey:@"commentedBy"] objectAtIndex:j];
                    commentObj.userCommentDate = [[commentsDict valueForKey:@"commentedOn"] objectAtIndex:j];
                    
                    if([commentObj.userCommentById intValue] == [appDelegate.userDetails.userId intValue])
                    {
                        
                        commentObj.userName = appDelegate.userDetails.userName;
                        commentObj.userProfileSmall = appDelegate.userDetails.userProfileSmall;
                        commentObj.userProfileMedium = appDelegate.userDetails.userProfileMedium;
                        commentObj.userProfileBig = appDelegate.userDetails.userProfileBig;
                        
                    }
                    else
                    {
                        database = [[DatabaseConnection alloc]init];
                        NSMutableArray *temp = [database getDetailsForComments:commentObj.userCommentById];
                        
                        if(temp.count)
                        {
                            commentObj.userName = [[temp objectAtIndex:0] userName];
                            commentObj.userProfileSmall = [[temp objectAtIndex:0] userProfileSmall];
                            commentObj.userProfileMedium = [[temp objectAtIndex:0] userProfileMedium];
                            commentObj.userProfileBig = [[temp objectAtIndex:0] userProfileBig];
                            
                        }
                        
                    }
                    
                    [dataArray addObject:commentObj];
                    commentObj = nil;
                    
                }
            }

            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successfullyDeleteComment: commentArray:)])
                [userManagerDelegate successfullyDeleteComment:message commentArray:dataArray];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];

        }
        
       
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"get_comment_like_data"])
    {
        //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        
        if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithCommentLikeDetails:)])
            [userManagerDelegate successWithCommentLikeDetails:dataArray];
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"get_gallery_images"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *message = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableDictionary *dataDict = [[json valueForKey:@"response"] valueForKey:@"data"];
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];

            for(int i = 0; i<[dataDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                dataObj.userProfileId = [appDelegate checkForNullValue:[[dataDict valueForKey:@"id"] objectAtIndex:i]];
                dataObj.userProfileBig = [appDelegate checkForNullValue:[[dataDict valueForKey:@"big"] objectAtIndex:i]];
                dataObj.userProfileSmall = [appDelegate checkForNullValue:[[dataDict valueForKey:@"small"] objectAtIndex:i]];
                dataObj.userProfileMedium = [appDelegate checkForNullValue:[[dataDict valueForKey:@"org"] objectAtIndex:i]];
                
                [dataArray addObject:dataObj];
                dataObj = nil;
                
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithGalleryImages:)])
                [userManagerDelegate successWithGalleryImages:dataArray];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:message];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"delete_gallery_images"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSString *strMessage = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableDictionary *dataDict = [[json valueForKey:@"response"] valueForKey:@"data"];
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            
            for(int i = 0; i<[dataDict count]; i++)
            {
                UsersData *dataObj = [[UsersData alloc] init];
                
                dataObj.userProfileId = [appDelegate checkForNullValue:[[dataDict valueForKey:@"id"] objectAtIndex:i]];
                dataObj.userProfileBig = [appDelegate checkForNullValue:[[dataDict valueForKey:@"big"] objectAtIndex:i]];
                dataObj.userProfileSmall = [appDelegate checkForNullValue:[[dataDict valueForKey:@"small"] objectAtIndex:i] ];
                dataObj.userProfileMedium = [appDelegate checkForNullValue:[[dataDict valueForKey:@"small"] objectAtIndex:i] ];
                
                [dataArray addObject:dataObj];
                dataObj = nil;
                
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithDeleteGalleryImages: withGalleryImages:)])
                [userManagerDelegate successWithDeleteGalleryImages:strMessage withGalleryImages:dataArray];

        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"friend_request"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithFriendRequestStatus:)])
                [userManagerDelegate successWithFriendRequestStatus:strMessage];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"my_match"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[json valueForKey:@"response"] valueForKey:@"status"] )
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            NSMutableDictionary *usersData = [[json valueForKey:@"response"] valueForKey:@"data"];
            
            for(int i=0; i<[usersData count]; i++)
            {
                UsersData *userDataObject = [[UsersData alloc]init];
                
                userDataObject.userId = [appDelegate checkForNullValue:[[usersData valueForKey:@"id"] objectAtIndex:i]];
                userDataObject.userStatus = [appDelegate checkForNullValue:[[usersData valueForKey:@"status"] objectAtIndex:i]];
                
                
                userDataObject.userFirstName = [appDelegate checkForNullValue:[[usersData valueForKey:@"fisrtname"] objectAtIndex:i]];
                userDataObject.userLastName = [appDelegate checkForNullValue:[[usersData valueForKey:@"lastname"] objectAtIndex:i]];
                
                userDataObject.userLongitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"longitude"] objectAtIndex:i]];
                userDataObject.userLatitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"latitude"] objectAtIndex:i]];
                
                
                userDataObject.userName = [appDelegate checkForNullValue:[[usersData valueForKey:@"username"] objectAtIndex:i]];
                userDataObject.userGender = [appDelegate checkForNullValue:[[usersData valueForKey:@"gender"] objectAtIndex:i]];

                
                userDataObject.userBirthDate = [appDelegate checkForNullValue:[[usersData valueForKey:@"date_of_birth"] objectAtIndex:i]];
                userDataObject.userEmail = [appDelegate checkForNullValue:[[usersData valueForKey:@"email"] objectAtIndex:i]];
                
                userDataObject.userCountryCode = [appDelegate checkForNullValue:[[usersData valueForKey:@"country"] objectAtIndex:i]];
                userDataObject.userDistance = [appDelegate checkForNullValue:[[usersData valueForKey:@"distance"] objectAtIndex:i]];
                
                userDataObject.userCity = [appDelegate checkForNullValue:[[usersData valueForKey:@"city"] objectAtIndex:i]];
                userDataObject.userState = [appDelegate checkForNullValue:[[usersData valueForKey:@"state"] objectAtIndex:i]];
                
                userDataObject.userAge = [appDelegate checkForNullValue:[[usersData valueForKey:@"age"] objectAtIndex:i]];
                userDataObject.userIsNew = [appDelegate checkForNullValue:[[usersData valueForKey:@"isnew"] objectAtIndex:i]];
                
                
                userDataObject.userProfileSmall = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicSmall"] objectAtIndex:i]];
                userDataObject.userProfileMedium = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePic"] objectAtIndex:i]];
                userDataObject.userProfileBig = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicBig"] objectAtIndex:i]];
                
                userDataObject.userMatch = [appDelegate checkForNullValue:[[usersData valueForKey:@"match"] objectAtIndex:i]];

                [dataArray addObject:userDataObject];
                userDataObject = nil;
                
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithMyMatchList:)])
                [userManagerDelegate successWithMyMatchList:dataArray];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"upload_wallpost"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableDictionary *userDict = [[json valueForKey:@"response"] valueForKey:@"data"];
            
            UsersData *usersDataObject = [[UsersData alloc]init];
            
            
            usersDataObject.userId = [appDelegate checkForNullValue:[userDict valueForKey:@"postedBy"]];
            usersDataObject.userFirstName = appDelegate.userDetails.userFirstName;
            usersDataObject.userLastName = appDelegate.userDetails.userLastName;
            usersDataObject.userName = appDelegate.userDetails.userName;;

            usersDataObject.userPostDescription = [appDelegate checkForNullValue:[userDict valueForKey:@"description"]];
            usersDataObject.userPostedById = [appDelegate checkForNullValue:[userDict valueForKey:@"postedBy"]];
            usersDataObject.userPostId = [appDelegate checkForNullValue:[userDict valueForKey:@"id"]];
            

            NSMutableDictionary *postImages = [userDict valueForKey:@"image"];
            
            if(postImages)
            {
                usersDataObject.userPostImgSmall = [appDelegate checkForNullValue:[postImages valueForKey:@"small"]];
                usersDataObject.userPostImgBig = [appDelegate checkForNullValue:[postImages valueForKey:@"big"]];
                
                usersDataObject.userPostImgMedium = [appDelegate checkForNullValue:[postImages valueForKey:@"org"]];
                usersDataObject.userPostImgWall = [appDelegate checkForNullValue:[postImages valueForKey:@"wall"]];
            }
            
            usersDataObject.userPostLiked = [appDelegate checkForNullValue:[userDict valueForKey:@"islike"]];
            usersDataObject.userPostedDate = [appDelegate checkForNullValue:[userDict valueForKey:@"postedOn"]];
            
            usersDataObject.userPostTotalComments = [appDelegate checkForNullValue:[userDict valueForKey:@"totalcomments"]];
            usersDataObject.userPostTotalLikes = [appDelegate checkForNullValue:[userDict valueForKey:@"totallikes"]];
            
            usersDataObject.userPostVideoUrl = [appDelegate checkForNullValue:[userDict valueForKey:@"videourl"]];
            //video
            //video_type

            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithUploadWallPost: postUserData:)])
                [userManagerDelegate successWithUploadWallPost:strMessage postUserData:usersDataObject];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"search_user"])
    {
        //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"] valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"true"])
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            NSMutableDictionary *usersData = [[json valueForKey:@"response"] valueForKey:@"data"];
            //isvisited = 0;
            
            //if(![usersData isKindOfClass:[NSNull class]])
            {
                for(int i=0; i<[usersData count]; i++)
                {
                    UsersData *userDataObject = [[UsersData alloc]init];
                    
                    userDataObject.userId = [appDelegate checkForNullValue:[[usersData valueForKey:@"id"] objectAtIndex:i]];
                    userDataObject.userStatus = [appDelegate checkForNullValue:[[usersData valueForKey:@"status"] objectAtIndex:i]];
                    
                    
                    userDataObject.userFirstName = [appDelegate checkForNullValue:[[usersData valueForKey:@"fisrtname"] objectAtIndex:i]];
                    userDataObject.userLastName = [appDelegate checkForNullValue:[[usersData valueForKey:@"lastname"] objectAtIndex:i]];
                    
                    userDataObject.userLongitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"longitude"] objectAtIndex:i]];
                    userDataObject.userLatitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"latitude"] objectAtIndex:i]];
                    
                    
                    userDataObject.userName = [appDelegate checkForNullValue:[[usersData valueForKey:@"username"] objectAtIndex:i]];
                    userDataObject.userGender = [appDelegate checkForNullValue:[[usersData valueForKey:@"gender"] objectAtIndex:i]];
                    
                    userDataObject.userBirthDate = [appDelegate checkForNullValue:[[usersData valueForKey:@"date_of_birth"] objectAtIndex:i]];
                    userDataObject.userEmail = [appDelegate checkForNullValue:[[usersData valueForKey:@"email"] objectAtIndex:i]];
                    
                    userDataObject.userCountryCode = [appDelegate checkForNullValue:[[usersData valueForKey:@"country"] objectAtIndex:i]];
                    userDataObject.userDistance = [appDelegate checkForNullValue:[[usersData valueForKey:@"distance"] objectAtIndex:i]];
                    
                    userDataObject.userCity = [appDelegate checkForNullValue:[[usersData valueForKey:@"city"] objectAtIndex:i]];
                    userDataObject.userState = [appDelegate checkForNullValue:[[usersData valueForKey:@"state"] objectAtIndex:i]];
                    
                    userDataObject.userAge = [appDelegate checkForNullValue:[[usersData valueForKey:@"age"] objectAtIndex:i]];
                    userDataObject.userIsNew = [appDelegate checkForNullValue:[[usersData valueForKey:@"isnew"] objectAtIndex:i]];
                    
                    
                    userDataObject.userProfileSmall = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicSmall"] objectAtIndex:i]];
                    userDataObject.userProfileMedium = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePic"] objectAtIndex:i]];
                    userDataObject.userProfileBig = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicBig"] objectAtIndex:i]];
                    
                    
                    [dataArray addObject:userDataObject];
                    userDataObject = nil;
                }
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithSearchUsers:)])
                [userManagerDelegate successWithSearchUsers:dataArray];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"radar_user"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"]  valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"true"])
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            NSMutableDictionary *usersData = [[json valueForKey:@"response"] valueForKey:@"data"];
            //isvisited = 0;

            //if(![usersData isKindOfClass:[NSNull class]])
            {
                for(int i=0; i<[usersData count]; i++)
                {
                    UsersData *userDataObject = [[UsersData alloc]init];
                    
                    userDataObject.userId = [appDelegate checkForNullValue:[[usersData valueForKey:@"id"] objectAtIndex:i]];
                    userDataObject.userStatus = [appDelegate checkForNullValue:[[usersData valueForKey:@"status"] objectAtIndex:i]];
                    
                    
                    userDataObject.userFirstName = [appDelegate checkForNullValue:[[usersData valueForKey:@"fisrtname"] objectAtIndex:i]];
                    userDataObject.userLastName = [appDelegate checkForNullValue:[[usersData valueForKey:@"lastname"] objectAtIndex:i]];
                    
                    userDataObject.userLongitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"longitude"] objectAtIndex:i]];
                    userDataObject.userLatitude = [appDelegate checkForNullValue:[[usersData valueForKey:@"latitude"] objectAtIndex:i]];
                    
                    
                    userDataObject.userName = [appDelegate checkForNullValue:[[usersData valueForKey:@"username"] objectAtIndex:i]];
                    userDataObject.userGender = [appDelegate checkForNullValue:[[usersData valueForKey:@"gender"] objectAtIndex:i]];
                
                    userDataObject.userBirthDate = [appDelegate checkForNullValue:[[usersData valueForKey:@"date_of_birth"] objectAtIndex:i]];
                    userDataObject.userEmail = [appDelegate checkForNullValue:[[usersData valueForKey:@"email"] objectAtIndex:i]];
                    
                    userDataObject.userCountryCode = [appDelegate checkForNullValue:[[usersData valueForKey:@"country"] objectAtIndex:i]];
                    userDataObject.userDistance = [appDelegate checkForNullValue:[[usersData valueForKey:@"distance"] objectAtIndex:i]];
                    
                    userDataObject.userCity = [appDelegate checkForNullValue:[[usersData valueForKey:@"city"] objectAtIndex:i]];
                    userDataObject.userState = [appDelegate checkForNullValue:[[usersData valueForKey:@"state"] objectAtIndex:i]];
                    
                    userDataObject.userAge = [appDelegate checkForNullValue:[[usersData valueForKey:@"age"] objectAtIndex:i]];
                    userDataObject.userIsNew = [appDelegate checkForNullValue:[[usersData valueForKey:@"isnew"] objectAtIndex:i]];
                    
                    
                    userDataObject.userProfileSmall = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicSmall"] objectAtIndex:i]];
                    userDataObject.userProfileMedium = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePic"] objectAtIndex:i]];
                    userDataObject.userProfileBig = [appDelegate checkForNullValue:[[usersData valueForKey:@"profilePicBig"] objectAtIndex:i]];
                    
                    
                    [dataArray addObject:userDataObject];
                    userDataObject = nil;
                }
            }

            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithRadarUsers:)])
                [userManagerDelegate successWithRadarUsers:dataArray];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"invite_contact"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSString *message = [[[json valueForKey:@"response"] valueForKey:@"data"] valueForKey:@"msgallready"];
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithInviteContact:)])
                [userManagerDelegate successWithInviteContact:message];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:NSLocalizedString(@"select_country", nil)];
            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"one_one_history"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"]  valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            
            NSMutableDictionary *chatDict = [[json valueForKey:@"response"]  valueForKey:@"data"];
            
            for(int i =0; i<[chatDict count]; i++)
            {
                ChatHistoryData *chatHistoryObject = [[ChatHistoryData alloc] init];
                
                chatHistoryObject.messageId = [appDelegate checkForNullValue:[[chatDict valueForKey:@"id"] objectAtIndex:i]];
                chatHistoryObject.message = [appDelegate checkForNullValue:[[chatDict valueForKey:@"message"] objectAtIndex:i]];
                
                chatHistoryObject.messageFromId = [appDelegate checkForNullValue:[[chatDict valueForKey:@"from"] objectAtIndex:i]];
                chatHistoryObject.messageToId = [appDelegate checkForNullValue:[[chatDict valueForKey:@"to"] objectAtIndex:i]];

                chatHistoryObject.messageRead = [appDelegate checkForNullValue:[[chatDict valueForKey:@"read"] objectAtIndex:i]];
                chatHistoryObject.messageDirection = [appDelegate checkForNullValue:[[chatDict valueForKey:@"direction"] objectAtIndex:i]];

                chatHistoryObject.messageSent = [appDelegate checkForNullValue:[[chatDict valueForKey:@"sent"] objectAtIndex:i]];

                [dataArray addObject:chatHistoryObject];
                chatHistoryObject = nil;
                
            }
            
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithOneToOneChatHistory:)])
                [userManagerDelegate successWithOneToOneChatHistory:dataArray];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"inbox_chat_history"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"response"]]);
        
        NSString *strMessage = [[json valueForKey:@"response"]  valueForKey:@"message"];
        
        if([[[json valueForKey:@"response"] valueForKey:@"status"] isEqualToString:@"success"])
        {
            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
            
            NSMutableDictionary *chatDict = [[json valueForKey:@"response"]  valueForKey:@"data"];
            
            NSArray *keyArray = [chatDict allKeys];
            
            for(int i =0; i<[keyArray count]; i++)
            {
                ChatHistoryData *chatInboxObject = [[ChatHistoryData alloc] init];

                NSLog(@"-- KEY :%@", [keyArray objectAtIndex:i]);
                NSMutableDictionary *data = [chatDict valueForKey:[keyArray objectAtIndex:i]];
                
                NSLog(@"-- KEY :%@", [[data valueForKey:@"message"] objectAtIndex:0]);

                
                chatInboxObject.otherChatUserId = [keyArray objectAtIndex:i];
                chatInboxObject.arrayOneToOneChat = [[NSMutableArray alloc]init];
                
                for(int j = 0; j<[data count]; j++)
                {
                    ChatHistoryData *chatHistoryObject = [[ChatHistoryData alloc] init];
                    
                    chatHistoryObject.messageId = [appDelegate checkForNullValue:[[data valueForKey:@"id"] objectAtIndex:j]];
                    chatHistoryObject.message = [appDelegate checkForNullValue:[[data valueForKey:@"message"] objectAtIndex:j]];
                    
                    chatHistoryObject.messageFromId = [appDelegate checkForNullValue:[[data valueForKey:@"from"] objectAtIndex:j]];
                    chatHistoryObject.messageToId = [appDelegate checkForNullValue:[[data valueForKey:@"to"] objectAtIndex:j]];
                    
                    chatHistoryObject.messageRead = [appDelegate checkForNullValue:[[data valueForKey:@"read"] objectAtIndex:j]];
                    chatHistoryObject.messageDirection = [appDelegate checkForNullValue:[[data valueForKey:@"direction"] objectAtIndex:j]];
                    
                    chatHistoryObject.messageSent = [appDelegate checkForNullValue:[[data valueForKey:@"sent"] objectAtIndex:j]];
                    
                    [chatInboxObject.arrayOneToOneChat addObject:chatHistoryObject];
                    chatHistoryObject = nil;

                }
                
                [dataArray addObject:chatInboxObject];
                chatInboxObject = nil;
                
            }

            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(successWithInboxChatHistory:)])
                [userManagerDelegate successWithInboxChatHistory:dataArray];
            
        }
        else
        {
            if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [userManagerDelegate problemForGettingResponse:strMessage];
            
        }
    }
    
}

- (void)didFailWithError:(NSDictionary *)error
{
#if DEBUG
    NSLog(@"-- Request Fail :%@",error);
#endif
    
    if(userManagerDelegate!=nil && [userManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [userManagerDelegate requestFailWithError:@"Request fail"];
    
}

-(void)didRecieveResponseForUploadImages:(NSDictionary *)responseDictionary
{
    [appDelegate stopSpinner];
}

-(void)didFailWithErrorForUploadImages:(NSDictionary *)error
{
    [appDelegate stopSpinner];
}

#pragma mark -----  -----  -----  ------


@end
