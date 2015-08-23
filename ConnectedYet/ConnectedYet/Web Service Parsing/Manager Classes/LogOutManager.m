//
//  LogOutManager.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/05/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "LogOutManager.h"
#import "MYSStringUtils.h"
#import "JSONStringGenerator.h"
#import "Constant.h"

@implementation LogOutManager

@synthesize logOutManagerDelegate;



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


#pragma mark --- --- ---- ---- ----
#pragma mark ---- API Response Methods  ----

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    NSMutableData *data = [responseDictionary valueForKey:MYS_RESPONSE_DATA_KEY];
    NSError* error = nil;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    //int status = [[json valueForKey:@"RequestStatus"] intValue];
    NSLog(@"--- Response :%@",json);
    
    
    if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"logout"])
    {
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"dropdownlist"]]);
        /*
        if([status isEqualToString:@"success"])
        {
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithMatrimonyAboutYourselfs:)])
                [loginManagerDelegate successWithMatrimonyAboutYourselfs:strMessage];
        }
        else
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
                [loginManagerDelegate problemForGettingResponse:strMessage];
            
        }
        */
    }
}


- (void)didFailWithError:(NSDictionary *)error
{
#if DEBUG
    NSLog(@"-- Request Fail :%@",error);
#endif
    
    if(logOutManagerDelegate!=nil && [logOutManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [logOutManagerDelegate requestFailWithError:@"ERROR"];
    
}

- (void)didRecieveResponseForUploadImages:(NSDictionary *)responseDictionary
{
    
}
    
-(void)didFailWithErrorForUploadImages:(NSDictionary *)error
{
    
}

@end
