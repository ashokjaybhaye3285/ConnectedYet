//
//  LoginManager.m
//  Kntor
//
//  Created by IMAC05 on 03/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "LoginManager.h"

#import "MYSStringUtils.h"
#import "JSONStringGenerator.h"
#import "Constant.h"

@implementation LoginManager

@synthesize loginManagerDelegate;


#pragma mark -----  -----  -----  ------
#pragma mark -----  -----  GET METHODS -----  ------


-(void)getLogOut;   // Get Log Out
{
    // http://aegis-infotech.com/connectedyet/web/api/logout

#if DEBUG
    NSLog(@"-- Get All Country Details ");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:@"logout" withBodyParameters:nil withHeaderParameters:nil withRequestId:@"logout"];
    
}

-(void)getAllCountryDetails
{
    //http://aegis-infotech.com/connectedyet/web/api/countries
#if DEBUG
    NSLog(@"-- Get All Country Details ");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:@"countries" withBodyParameters:nil withHeaderParameters:nil withRequestId:@"country_details"];

}


-(void)getAllLanguages   // Get All Language Details
{
    //http://aegis-infotech.com/connectedyet/web/api/countries
#if DEBUG
    NSLog(@"-- Get All Country Details ");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:@"languages" withBodyParameters:nil withHeaderParameters:nil withRequestId:@"language_details"];
    
}


-(void)getDropDownValuesDetails   // Get All Dropdown Details
{
    //http://aegis-infotech.com/connectedyet/web/api/dropdown

#if DEBUG
    NSLog(@"-- Get Drop down Details ");
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyGETRequestURL:@"dropdown" withBodyParameters:nil withHeaderParameters:nil withRequestId:@"dropdown_details"];
    
}


#pragma mark -----  -----  -----  ------
#pragma mark -----  -----  POST METHODS -----  ------


-(void)getLogin:(NSMutableDictionary *)_dataDict  // Login
{
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    //http://aegis-infotech.com/connectedyet/web/api/login

    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:@"logins"
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"logins"];
    

}


-(void)getPasswordForLoginUser:(NSMutableDictionary *)_dataDict
{
    // http://aegis-infotech.com/connectedyet/web/api/forgotpasswords
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:@"forgotpasswords"
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"forgot_password"];
    
    
}


-(void)changePasswordForLoginUser:(NSMutableDictionary *)_dataDict
{
    //http://aegis-infotech.com/connectedyet/web/api/changepasswords/{id}
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"changepasswords/%@",appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"change_password"];
    
}


-(void)registerNewUser:(NSMutableDictionary *)_dataDict
{
     NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
  
    [proxy asyncronouslyPOSTRequestURL:@"users"
        withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
         withHeaderParameters:nil
              withRequestId:@"register_user"];
    
    
}

-(void)updatePersonalDetails:(NSMutableDictionary *)_dataDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"users/%@/edits", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"update_personal_details"];
    
//http://aegis-infotech.com/connectedyet/web/api/users/{id}/updates

}

-(void)updateLoginDetails:(NSMutableDictionary *)_dataDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"users/%@/infos", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"update_login_details"];
    
}

/*-(void)registerNewUser:(NSMutableDictionary *)_dataDict imagesDict:(NSMutableDictionary *)_imagesDict
{
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];

    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyUploadImage:_imagesDict postData:jsonInput auth:nil];
    
}
*/

-(void)uploadProfilePicture:(NSMutableDictionary *)_imagesDict
{
    //NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyUploadImage:_imagesDict postData:nil];
    
}


-(void)updateUsersProfilePicture:(NSMutableDictionary *)_imagesDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    ;
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/pictures/%@", appDelegate.userDetails.userId];
    uploadRequestId = @"update_profile_images";
    
    [proxy asyncronouslyUploadGalleryImage:_imagesDict postData:nil withRequestUrl:baseurl];
    
}

-(void)uploadGalleryImages:(NSMutableDictionary *)_imagesDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    ;
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/galleries/%@", appDelegate.userDetails.userId];
    uploadRequestId = @"upload_gallery_images";
    
    [proxy asyncronouslyUploadGalleryImage:_imagesDict postData:nil withRequestUrl:baseurl];
    
}

-(void)uploadWallPostImages:(NSMutableDictionary *)_imagesDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    ;
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/addwallfiles/%@", appDelegate.userDetails.userId];
    uploadRequestId = @"upload_wallpost_images";
    
    [proxy asyncronouslyUploadGalleryImage:_imagesDict postData:nil withRequestUrl:baseurl];
    
}


-(void)uploadCoverImages:(NSMutableDictionary *)_imagesDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    ;
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/covers/%@", appDelegate.userDetails.userId];
    uploadRequestId = @"upload_cover_images";
    
    [proxy asyncronouslyUploadGalleryImage:_imagesDict postData:nil withRequestUrl:baseurl];
    
}


-(void)uploadVoiceNote:(NSMutableDictionary *)_imagesDict
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    ;
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/audios/%@", appDelegate.userDetails.userId];
   
    uploadRequestId = @"upload_voice_note";
    
    [proxy asyncronouslyUploadGalleryImage:_imagesDict postData:nil withRequestUrl:baseurl];
    
}


-(void)verifyYourOTP:(NSMutableDictionary *)_dataDict
{
//http://aegis-infotech.com/connectedyet/web/api/optusers/(user_id)
    
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;

    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"optusers/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"verify_otp"];
    
}


-(void)addInterestAgainstUser:(NSMutableDictionary *)_dataDict
{
    //    http://aegis-infotech.com/connectedyet/web/api/interests/(user_id)

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;

    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"interests/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"add_interest"];
    
}


-(void)setMatrimonyPersonalInformation:(NSMutableDictionary *)_dataDict
{
    // http://aegis-infotech.com/connectedyet/web/api/matrimonies/(user_id)

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"matrimony_personal_info"];
    
    
}

-(void)setMatrimonyAboutYourself:(NSMutableDictionary *)_dataDict
{
    //http://aegis-infotech.com/connectedyet/web/api/matrimonies/(user_id)/yourselves

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@/yourselves", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"matrimony_about_yourselfs"];
    
    
}

-(void)setMatrimonyAboutLifeStyle:(NSMutableDictionary *)_dataDict
{
    //http://aegis-infotech.com/connectedyet/web/api/matrimonies/(user_id)/lifestyles
    
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@/lifestyles", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"matrimony_about_lifestyle"];
    
    
}

-(void)setMatrimonyAboutValues:(NSMutableDictionary *)_dataDict
{
 //http://aegis-infotech.com/connectedyet/web/api/matrimonies/(user_id)/values
   
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@/values", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"matrimony_about_values"];
    
    
}


-(void)setDatingInfo:(NSMutableDictionary *)_dataDict
{
    // http://aegis-infotech.com/connectedyet/web/api/dattings/(user_id)

    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;

    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"dattings/%@", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"datting_info"];
    
}

-(void)setMatrimonyMatch:(NSMutableDictionary *)_dataDict
{
    // http://aegis-infotech.com/connectedyet/web/api/matrimonies/(user_id)/matches
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
#if DEBUG
    NSLog(@"-- Request Parameter :%@",jsonInput);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    [proxy asyncronouslyPOSTRequestURL:[NSString stringWithFormat:@"matrimonies/%@/matches", appDelegate.userDetails.userId]
                    withBodyParameters:[jsonInput dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"matrimony_matches"];
    
    
}

#pragma mark -----  -----  -----  ------

-(void)cancelAPIRequest
{
    proxy = [[MYSGenericProxy alloc] init];
    [proxy cancelRequest:@"get_Category"];
    
}


#pragma mark --- --- ---- ---- ----
#pragma mark ---- API Response Methods  ----

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    //NSLog(@"--- Response :%@",responseDictionary);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSMutableData *data = [responseDictionary valueForKey:MYS_RESPONSE_DATA_KEY];
    NSError* error = nil;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    //int status = [[json valueForKey:@"RequestStatus"] intValue];
    NSLog(@"--- Response :%@",json);

    if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"logins"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"message"];
        
        if([status isEqualToString:@"true"])
        {
            NSMutableDictionary *userData = [userDict valueForKey:@"data"];
            
            UsersData *userDataObject = [[UsersData alloc]init];
          
            userDataObject.userId = [appDelegate checkForNullValue:[userData valueForKey:@"id"]];
            userDataObject.userName = [appDelegate checkForNullValue:[userData valueForKey:@"username"]];
            userDataObject.userPhone = [appDelegate checkForNullValue:[userData valueForKey:@"phone"]];
            userDataObject.userInterest = [appDelegate checkForNullValue:[userData valueForKey:@"userintrest"]];

            userDataObject.userFirstName = [appDelegate checkForNullValue:[userData valueForKey:@"fisrtname"]];
            userDataObject.userLastName = [appDelegate checkForNullValue:[userData valueForKey:@"lastname"]];

            userDataObject.userEmail = [appDelegate checkForNullValue:[userData valueForKey:@"email"]];
            userDataObject.userCountryCode = [appDelegate checkForNullValue:[userData valueForKey:@"country"]];
            userDataObject.userBirthDate = [appDelegate checkForNullValue:[userData valueForKey:@"date_of_birth"]];
            
            userDataObject.userAge = [appDelegate checkForNullValue:[userData valueForKey:@"age"]];
            userDataObject.userAudio = [appDelegate checkForNullValue:[userData valueForKey:@"audio"]];

            userDataObject.userCity = [appDelegate checkForNullValue:[userData valueForKey:@"city"]];
            userDataObject.userGender = [appDelegate checkForNullValue:[userData valueForKey:@"gender"]];
            userDataObject.userState = [appDelegate checkForNullValue:[userData valueForKey:@"state"]];

            userDataObject.userLatitude = [appDelegate checkForNullValue:[userData valueForKey:@"latitude"]];
            userDataObject.userLongitude = [appDelegate checkForNullValue:[userData valueForKey:@"longitude"]];

            
            userDataObject.userProfileSmall = [appDelegate checkForNullValue:[userData valueForKey:@"profilePicSmall"]];
            userDataObject.userProfileMedium = [appDelegate checkForNullValue:[userData valueForKey:@"profilePic"]];
            userDataObject.userProfileBig = [appDelegate checkForNullValue:[userData valueForKey:@"profilePicBig"]];

            //-------------
            
            userDataObject.userBiography = [appDelegate checkForNullValue:[userData valueForKey:@"biography"]];
            userDataObject.userBodyType = [appDelegate checkForNullValue:[userData valueForKey:@"body_type"]];
            userDataObject.userDrink = [appDelegate checkForNullValue:[userData valueForKey:@"drink"]];

            userDataObject.userExcersize = [appDelegate checkForNullValue:[userData valueForKey:@"excersize"]];
            userDataObject.userEyeColor = [appDelegate checkForNullValue:[userData valueForKey:@"eye_color"]];

            userDataObject.userHairColor = [appDelegate checkForNullValue:[userData valueForKey:@"hair_color"]];
            userDataObject.userInterestedIn = [appDelegate checkForNullValue:[userData valueForKey:@"interestedin"]];

            userDataObject.userIsHowMany = [appDelegate checkForNullValue:[userData valueForKey:@"ishowmany"]];
            userDataObject.userKids = [appDelegate checkForNullValue:[userData valueForKey:@"kids"]];

            userDataObject.userPreferedLang = [appDelegate checkForNullValue:[userData valueForKey:@"prefered_lang"]];
            userDataObject.userRelStatus = [appDelegate checkForNullValue:[userData valueForKey:@"relation_status"]];

            userDataObject.userSign = [appDelegate checkForNullValue:[userData valueForKey:@"sign"]];
            userDataObject.userlocale = [appDelegate checkForNullValue:[userData valueForKey:@"locale"]];

            userDataObject.userSmoke = [appDelegate checkForNullValue:[userData valueForKey:@"smoke"]];
            userDataObject.userWantMore = [appDelegate checkForNullValue:[userData valueForKey:@"whatmore"]];


            NSMutableDictionary *eduDict = [userData valueForKey:@"edu_level"];
            if([eduDict count])
            {
                userDataObject.userEducation = [appDelegate checkForNullValue:[eduDict valueForKey:@"name"]];
                userDataObject.userEducationId = [appDelegate checkForNullValue:[eduDict valueForKey:@"id"]];
            }
           
            NSMutableDictionary *ethDict = [userData valueForKey:@"ethnicity"];
            if([ethDict count])
            {
                userDataObject.userEthnicity = [appDelegate checkForNullValue:[ethDict valueForKey:@"name"]];
                userDataObject.userEthnicityId = [appDelegate checkForNullValue:[ethDict valueForKey:@"id"]];
            }
            
            NSMutableDictionary *excDict = [userData valueForKey:@"excersize_sport"];
            if([excDict count])
            {
                userDataObject.userExSport = [appDelegate checkForNullValue:[excDict valueForKey:@"name"]];
                userDataObject.userExSportId = [appDelegate checkForNullValue:[excDict valueForKey:@"id"]];
            }
            
            NSMutableDictionary *heightDict = [userData valueForKey:@"height"];
            if([heightDict count])
            {
                userDataObject.userHeight = [appDelegate checkForNullValue:[heightDict valueForKey:@"name"]];
                userDataObject.userHeightId = [appDelegate checkForNullValue:[heightDict valueForKey:@"id"]];
            }
            
            NSArray *langArray = [userData valueForKey:@"lang_speak"];
            if(langArray.count)
                userDataObject.userLanguage = [appDelegate checkForNullValue:[langArray objectAtIndex:0]];
           
            //NSMutableDictionary *langDict = [userData valueForKey:@"lang_speak"];
            //if([langDict count])
            //{
                //userDataObject.userLanguage = [appDelegate checkForNullValue:[langDict object]];
                //userDataObject.userLanguageId = [appDelegate checkForNullValue:[langDict valueForKey:@"id"]];
            //}
            
            NSMutableDictionary *movieDict = [userData valueForKey:@"movies"];
            if([movieDict count])
            {
                userDataObject.userMovie = [appDelegate checkForNullValue:[movieDict valueForKey:@"name"]];
                userDataObject.userMovieId = [appDelegate checkForNullValue:[movieDict valueForKey:@"id"]];
            }

            NSMutableDictionary *occDict = [userData valueForKey:@"occupation"];
            if([occDict count])
            {
                userDataObject.userOccupation = [appDelegate checkForNullValue:[occDict valueForKey:@"name"]];
                userDataObject.userOccupationId = [appDelegate checkForNullValue:[occDict valueForKey:@"id"]];
            }


            NSMutableDictionary *religionDict = [userData valueForKey:@"religion"];
            if([religionDict count])
            {
                userDataObject.userReligion = [appDelegate checkForNullValue:[religionDict valueForKey:@"name"]];
                userDataObject.userReligionId = [appDelegate checkForNullValue:[religionDict valueForKey:@"id"]];
            }

            NSMutableDictionary *salDict = [userData valueForKey:@"salary"];
            if([salDict count])
            {
                userDataObject.userSalary = [appDelegate checkForNullValue:[salDict valueForKey:@"name"]];
                userDataObject.userSalaryId = [appDelegate checkForNullValue:[salDict valueForKey:@"id"]];
            }
            
            appDelegate.userDetails = userDataObject;
            [appDelegate saveCustomObject:userDataObject];

            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithLogin:)])
                [loginManagerDelegate successWithLogin:strMessage];
            
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
            {
                if(strMessage.length !=0)
                    [loginManagerDelegate problemForGettingResponse:strMessage];
                else
                    [loginManagerDelegate problemForGettingResponse:@"Something went wrong"];
            }

            
        }

    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"country_details"])
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *countryDict = [json valueForKey:@"countries"];
        
        for(int i =0; i<[countryDict count]; i++)
        {
            CountryData *countryObject = [[CountryData alloc]init];
            
            countryObject.countryCode = [[countryDict valueForKey:@"country_code"] objectAtIndex:i];
            countryObject.countryName = [[countryDict valueForKey:@"country_name"] objectAtIndex:i];
            
            DatabaseConnection *database = [[DatabaseConnection alloc]init];
            
            NSString *query = [NSString stringWithFormat:@"Insert into Country(countryName, countryCode) values('%@', '%@')", countryObject.countryName, countryObject.countryCode];
            
            [database executeQuety:query];
            
            [dataArray addObject:countryObject];
            countryObject = nil;
            
        }
        
        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithCountryDetails:)])
            [loginManagerDelegate successWithCountryDetails:dataArray];
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"register_user"])
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            appDelegate.userDetails = [[UsersData alloc] init];
            
            appDelegate.userDetails.userId = [userDict valueForKey:@"user_id"];
            appDelegate.tempObject.userId = [userDict valueForKey:@"user_id"];
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithNewUserRegistration:)])
                [loginManagerDelegate successWithNewUserRegistration:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"verify_otp"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithOTP:)])
                [loginManagerDelegate successWithOTP:strMessage];
        }
        else
        {
            NSString *strMessage = [userDict valueForKey:@"Msg"];
   
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"add_interest"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyAddInterest:)])
                [loginManagerDelegate successfullyAddInterest:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"language_details"])
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *userDict = [json valueForKey:@"languages"];
        
        for(int i =0; i<[userDict count]; i++)
        {
            LanguageData *languageObject = [[LanguageData alloc]init];
            
            languageObject.languageCode = [[userDict valueForKey:@"lang_code"] objectAtIndex:i];
            languageObject.languageName = [[userDict valueForKey:@"lang_name"] objectAtIndex:i];

            [dataArray addObject:languageObject];
            languageObject = nil;
            
        }
        
        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithLanguageDetails:)])
            [loginManagerDelegate successWithLanguageDetails:dataArray];
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"matrimony_personal_info"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyPersonalInfo:)])
                [loginManagerDelegate successWithMatrimonyPersonalInfo:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"matrimony_about_yourselfs"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyAboutYourselfs:)])
                [loginManagerDelegate successWithMatrimonyAboutYourselfs:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"dropdown_details"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"dropdownlist"]]);

        NSMutableDictionary *dropDownDict = [json valueForKey:@"dropdownlist"];

        DropdownData *dropDownObject = [[DropdownData alloc]init];
        
//---- Sexual Preferences
        
        NSMutableDictionary *sexualPrefDict = [dropDownDict valueForKey:@"sexualpreferences"];
        dropDownObject.arraySexualPreferences = [[NSMutableArray alloc]init];

        for(int i =0 ; i<[sexualPrefDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];

            data.Id = [appDelegate checkForNullValue:[[sexualPrefDict valueForKey:@"id"] objectAtIndex:i]];
            data.name = [appDelegate checkForNullValue:[[sexualPrefDict valueForKey:@"name"] objectAtIndex:i]];
            
            [dropDownObject.arraySexualPreferences addObject:data];
            data = nil;
        }
        
//-----
//----- Religion
            
        NSMutableDictionary *religionDict = [dropDownDict valueForKey:@"religion"];
        dropDownObject.arrayReligion = [[NSMutableArray alloc]init];
            
        for(int i =0 ; i<[religionDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[religionDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[religionDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[religionDict valueForKey:@"created_on"] objectAtIndex:i]];
 
            [dropDownObject.arrayReligion addObject:data];
            data = nil;
        }
        
//-----
//-----  Hair Color
        NSMutableDictionary *hairColorDict = [dropDownDict valueForKey:@"haircolor"];
        dropDownObject.arrayHaircolor = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[hairColorDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[hairColorDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[hairColorDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[religionDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayHaircolor addObject:data];
            data = nil;
        }
        
//-----
//-----  Eye Color
        NSMutableDictionary *eyeColorDict = [dropDownDict valueForKey:@"eyecolor"];
        dropDownObject.arrayEyecolor = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[eyeColorDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[eyeColorDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[eyeColorDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[religionDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayEyecolor addObject:data];
            data = nil;
        }
        
//-----
//-----  Eduction Level
        NSMutableDictionary *educationLevelDict = [dropDownDict valueForKey:@"eductionlevel"];
        dropDownObject.arrayEductionLevel = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[educationLevelDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[educationLevelDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[educationLevelDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[educationLevelDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayEductionLevel addObject:data];
            data = nil;
        }
        
//-----
//----- Smoke
        NSMutableDictionary *smokeDict = [dropDownDict valueForKey:@"smoke"];
        dropDownObject.arraySmoke = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[smokeDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[smokeDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[smokeDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[smokeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arraySmoke addObject:data];
            data = nil;
        }
        
//-----
//----- Relationship Status
        NSMutableDictionary *relationshipStatusDict = [dropDownDict valueForKey:@"relationshipstatus"];
        dropDownObject.arrayRelationshipStatus = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[relationshipStatusDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[relationshipStatusDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[relationshipStatusDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[smokeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayRelationshipStatus addObject:data];
            data = nil;
        }
        
//-----
//----- Body Type
        NSMutableDictionary *bodyTypeDict = [dropDownDict valueForKey:@"bodytype"];
        dropDownObject.arrayBodyType = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[bodyTypeDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[bodyTypeDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[bodyTypeDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[smokeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayBodyType addObject:data];
            data = nil;
        }
        
//-----
//----- Sport Exercise
        NSMutableDictionary *sportExerciseDict = [dropDownDict valueForKey:@"checkboxes_sportexersize"];
        dropDownObject.arraySportExercise = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[sportExerciseDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[sportExerciseDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[sportExerciseDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[sportExerciseDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arraySportExercise addObject:data];
            data = nil;
        }
        
//-----
//----- Age From
        NSMutableDictionary *ageFromDict = [dropDownDict valueForKey:@"agefrom"];
        dropDownObject.arrayAgeFrom = [[NSMutableArray alloc]init];
        
        //for(int i =0 ; i<[ageFromDict count]; i++)
        for(int i =18 ; i<=70; i++) // TEMP
        {
            DropdownData *data = [[DropdownData alloc]init];
            NSString *keys = [NSString stringWithFormat:@"%d",i];
            
            data.Id =  keys;
            data.name =  keys;
            
            //data.Id =  [appDelegate checkForNullValue:[[sportExerciseDict valueForKey:@"id"] objectAtIndex:i]];
            //data.name =  [appDelegate checkForNullValue:[[ageFromDict valueForKey:@"name"] objectAtIndex:i]];
            
            [dropDownObject.arrayAgeFrom addObject:data];
            data = nil;
        }
        
//-----
//----- Age To
        NSMutableDictionary *ageToDict = [dropDownDict valueForKey:@"ageto"];
        dropDownObject.arrayAgeTo = [[NSMutableArray alloc]init];
        
        //for(int i =0 ; i<[ageToDict count]; i++)
        for(int i =18 ; i<=70 ; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            NSString *keys = [NSString stringWithFormat:@"%d",i];
            
            data.Id =  keys;
            data.name =  keys;

            //data.Id =  [appDelegate checkForNullValue:[[ageToDict valueForKey:@"id"] objectAtIndex:i]];
            //data.name =  [appDelegate checkForNullValue:[[ageToDict valueForKey:@"name"] objectAtIndex:i]];
            
            [dropDownObject.arrayAgeTo addObject:data];
            data = nil;
        }
        
//-----
//-----  Drink
        NSMutableDictionary *drinkDict = [dropDownDict valueForKey:@"drink"];
        dropDownObject.arrayDrink = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[drinkDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[drinkDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[drinkDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[ageToDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayDrink addObject:data];
            data = nil;
        }
        
//-----
//-----  Occupations
        NSMutableDictionary *occupationsDict = [dropDownDict valueForKey:@"occupations"];
        dropDownObject.arrayOccupations = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[occupationsDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[occupationsDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[occupationsDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[occupationsDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayOccupations addObject:data];
            data = nil;
        }
        
//-----
//-----  Sign
        NSMutableDictionary *signDict = [dropDownDict valueForKey:@"sign"];
        dropDownObject.arraySign = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[signDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[signDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[signDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[occupationsDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arraySign addObject:data];
            data = nil;
        }
        
//-----
//-----  Movies
        NSMutableDictionary *moviesDict = [dropDownDict valueForKey:@"checkboxes_movies"];
        dropDownObject.arrayMovies = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[moviesDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[moviesDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[moviesDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[occupationsDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayMovies addObject:data];
            data = nil;
        }
        
//-----
//-----  Ethnicity
        NSMutableDictionary *ethnicityDict = [dropDownDict valueForKey:@"checkboxes_ethnicity"];
        dropDownObject.arrayEthnicity = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[ethnicityDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[ethnicityDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[ethnicityDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[ethnicityDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayEthnicity addObject:data];
            data = nil;
        }
        
//-----
//----- Height
        NSMutableDictionary *heightDict = [dropDownDict valueForKey:@"height"];
        dropDownObject.arrayHeight = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[heightDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
           
            data.Id =  [appDelegate checkForNullValue:[[heightDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[heightDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[heightDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayHeight addObject:data];
            data = nil;
        }
        
//-----
//----- Want More
        NSMutableDictionary *wantMoreDict = [dropDownDict valueForKey:@"wantmore"];
        dropDownObject.arrayWantMore = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[wantMoreDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[wantMoreDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[wantMoreDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[wantMoreDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayWantMore addObject:data];
            data = nil;
        }
        
//-----
//-----  Exercise
        NSMutableDictionary *excersizeDict = [dropDownDict valueForKey:@"excersize"];
        dropDownObject.arrayExcersize = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[excersizeDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[excersizeDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[excersizeDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[excersizeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayExcersize addObject:data];
            data = nil;
        }
        
//-----
//----- Howmany
        NSMutableDictionary *howmanyDict = [dropDownDict valueForKey:@"howmany"];
        dropDownObject.arrayHowMany = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[howmanyDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[howmanyDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[howmanyDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[excersizeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayHowMany addObject:data];
            data = nil;
        }
        
//-----
//-----  Kids
        NSMutableDictionary *kidsDict = [dropDownDict valueForKey:@"kids"];
        dropDownObject.arrayKids = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[kidsDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[kidsDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[kidsDict valueForKey:@"name"] objectAtIndex:i]];
            //data.createdDate =  [appDelegate checkForNullValue:[[excersizeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayKids addObject:data];
            data = nil;
        }
        
//-----
//----- Salary Range
        NSMutableDictionary *salaryRangeDict = [dropDownDict valueForKey:@"salaryrange"];
        dropDownObject.arraySalaryRange = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[salaryRangeDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[salaryRangeDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[salaryRangeDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[salaryRangeDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arraySalaryRange addObject:data];
            data = nil;
        }
        
//-----
//----- Language Speak
        NSMutableDictionary *languageSpeakDict = [dropDownDict valueForKey:@"checkboxes_languagespeak"];
        dropDownObject.arrayLanguageSpeak = [[NSMutableArray alloc]init];
        
        for(int i =0 ; i<[languageSpeakDict count]; i++)
        {
            DropdownData *data = [[DropdownData alloc]init];
            
            data.Id =  [appDelegate checkForNullValue:[[languageSpeakDict valueForKey:@"id"] objectAtIndex:i]];
            data.name =  [appDelegate checkForNullValue:[[languageSpeakDict valueForKey:@"name"] objectAtIndex:i]];
            data.createdDate =  [appDelegate checkForNullValue:[[languageSpeakDict valueForKey:@"created_on"] objectAtIndex:i]];
            
            [dropDownObject.arrayLanguageSpeak addObject:data];
            data = nil;
        }
        
//-----
//-----
        
        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithDropDownData:)])
            [loginManagerDelegate successWithDropDownData:dropDownObject];

        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"matrimony_about_lifestyle"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyAboutLifestyle:)])
                [loginManagerDelegate successWithMatrimonyAboutLifestyle:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"matrimony_about_values"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];
        
        if([status isEqualToString:@"success"])
        {
            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyAboutValues:)])
                [loginManagerDelegate successWithMatrimonyAboutValues:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"datting_info"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        
        if([status isEqualToString:@"success"])
        {
            NSString *strMessage = [userDict valueForKey:@"Msg"];

            //appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithUpdateDattingInfo:)])
                [loginManagerDelegate successWithUpdateDattingInfo:strMessage];
        }
        else
        {
            NSString *strMessage = [userDict valueForKey:@"errorMsg"];

            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                if(strMessage.length !=0)
                    [loginManagerDelegate problemForGettingResponse:strMessage];
                else
                    [loginManagerDelegate problemForGettingResponse:@"Problem in data saving"];

            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"matrimony_matches"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"Msg"];

        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyMatch:)])
            [loginManagerDelegate successWithMatrimonyMatch:@"successfully upload information"];

        /*
        if([status isEqualToString:@"success"])
        {
            NSString *strMessage = [userDict valueForKey:@"Msg"];
            
            appDelegate.userId = [userDict valueForKey:@"user_id"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithUpdateDattingInfo:)])
                [loginManagerDelegate successWithUpdateDattingInfo:strMessage];
        }
        else
        {
            NSString *strMessage = [userDict valueForKey:@"errorMsg"];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
         */
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"logout"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [json valueForKey:@"success"];
        
        if([status intValue])
        {
            NSString *strMessage = [userDict valueForKey:@"Msg"];
            strMessage = @"Successfully log out";
            
            appDelegate.userDetails = nil;
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithLogOut:)])
                [loginManagerDelegate successWithLogOut:strMessage];
        }
        else
        {
            NSString *strMessage = [userDict valueForKey:@"errorMsg"];
            strMessage = @"Successfully log fail";

            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"forgot_password"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];

        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"message"];

        if([status isEqualToString:@"success"])
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithResetForgotPassword:)])
                [loginManagerDelegate successWithResetForgotPassword:strMessage];
        }
        else
        {            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
            {
                if(strMessage.length!=0)
                    [loginManagerDelegate problemForGettingResponse:strMessage];
                else
                    [loginManagerDelegate problemForGettingResponse:@"Something went wrong"];
            }

            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"change_password"])
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"message"];
        
        if([status isEqualToString:@"success"])
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithChangePassword:)])
                [loginManagerDelegate successWithChangePassword:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"update_personal_details"]) //TODO: After API change here..
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"message"];
        
        if([status isEqualToString:@"success"])
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWitUpdatePersonalDetails:)])
                [loginManagerDelegate successWitUpdatePersonalDetails:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:@"Internal Server Error"];
            
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"update_login_details"]) //TODO: After API change here..
    {
        NSMutableDictionary *userDict = [json valueForKey:@"response"];
        
        NSString *status = [userDict valueForKey:@"status"];
        NSString *strMessage = [userDict valueForKey:@"message"];
        
        if([status isEqualToString:@"success"])
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWitUpdateLoginDetails:)])
                [loginManagerDelegate successWitUpdateLoginDetails:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
    }
    
}

- (void)didFailWithError:(NSDictionary *)error
{
#if DEBUG
    NSLog(@"-- Request Fail :%@",error);
#endif
    
    if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [loginManagerDelegate requestFailWithError:@"ERROR"];
    
}


- (void)didRecieveResponseForUploadImages:(NSDictionary *)responseDictionary
{
#if DEBUG
    NSLog(@"-- Image Upload :%@",responseDictionary);
#endif
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSMutableDictionary *userDict = [responseDictionary valueForKey:@"response"];
    
    NSString *status = [userDict valueForKey:@"status"];
    NSString *strMessage = [userDict valueForKey:@"message"];

    if([status isEqualToString:@"success"])
    {
        if([uploadRequestId isEqualToString:@"upload_gallery_images"])
        {
            NSLog(@"--  Upload Gallery Images ---");
            
            NSMutableDictionary *dataDict = [userDict valueForKey:@"data"];
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
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadGalleryPicture: galleryImages:)])
                [loginManagerDelegate successfullyUploadGalleryPicture:strMessage galleryImages:dataArray];

        }
        else if([uploadRequestId isEqualToString:@"upload_wallpost_images"])
        {
            NSString *imageId = [appDelegate checkForNullValue:[userDict valueForKey:@"image_id"]];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadWallPictureWithId:)])
                [loginManagerDelegate successfullyUploadWallPictureWithId:imageId];
            
        }
        else if([uploadRequestId isEqualToString:@"upload_cover_images"])
        {
            
            //if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadCoverPicture:)])
              //  [loginManagerDelegate successfullyUploadCoverPicture:@""];
            
        }
        else if([uploadRequestId isEqualToString:@"upload_voice_note"])
        {
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadVoiceNote:)])
              [loginManagerDelegate successfullyUploadVoiceNote:@"User register successfully"];
            
        }
        else if([uploadRequestId isEqualToString:@"update_profile_images"])
        {
            NSString *strUrl = [appDelegate checkForNullValue:[userDict valueForKey:@"data"]];
            
            appDelegate.userDetails.userProfileBig = strUrl;
            appDelegate.userDetails.userProfileSmall = strUrl;
            appDelegate.userDetails.userProfileMedium = strUrl;

            appDelegate.tempObject.userProfileBig = strUrl;
            appDelegate.tempObject.userProfileSmall = strUrl;
            appDelegate.tempObject.userProfileMedium = strUrl;

            [appDelegate saveCustomObject:appDelegate.userDetails];
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadProfilePicture:)])
                [loginManagerDelegate successfullyUploadProfilePicture:strMessage];
            
        }
        else
        {
            NSString *strUrl = [appDelegate checkForNullValue:[userDict valueForKey:@"data"]];
            
            appDelegate.userDetails.userProfileBig = strUrl;
            appDelegate.userDetails.userProfileSmall = strUrl;
            appDelegate.userDetails.userProfileMedium = strUrl;
            
            [appDelegate saveCustomObject:appDelegate.userDetails];

            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyUploadProfilePicture:)])
                [loginManagerDelegate successfullyUploadProfilePicture:@"User register successfully"];
            
        }

    }
    else
    {
        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
            [loginManagerDelegate problemForGettingResponse:strMessage];
        
    }
}

-(void)didFailWithErrorForUploadImages:(NSDictionary *)error
{
#if DEBUG
    NSLog(@"-- Image Upload Fail :%@",[error description]);
#endif
    
    if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [loginManagerDelegate requestFailWithError:@"Error while uploading picture"];

}

#pragma mark -----  -----  -----  ------

@end
