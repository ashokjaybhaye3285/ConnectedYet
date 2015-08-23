//
//  UserManager.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 28/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "ChatDataManager.h"

#import "MYSStringUtils.h"
#import "JSONStringGenerator.h"
#import "Constant.h"


@implementation ChatDataManager

@synthesize delegate;


#pragma mark -----  -----  -----  ------
#pragma mark -----  -----  GET METHODS -----  ------

//Get All Chatting threads against UserId
-(void)getAllChatForUser:(NSString *)userId
{
    // http://aegis-infotech.com/connectedyet/web/api/chathistories/234
    
#if DEBUG
    NSLog(@"-- Get All Users For :%@", userId);
#endif
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"chathistories/%@",[NSString stringWithFormat:@"%@",userId]] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"chathistories"];
}

//Get Chat history between two users
-(void)getChatHistoryForUser:(NSString *)fromUserId withUser:(NSString*)toUserId
{
    // http://aegis-infotech.com/connectedyet/web/api/histories/234/datas/178
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [proxy asyncronouslyGETRequestURL:[NSString stringWithFormat:@"histories/%@/datas/%@",[NSString stringWithFormat:@"%@",fromUserId],[NSString stringWithFormat:@"%@",toUserId]] withBodyParameters:nil withHeaderParameters:nil withRequestId:@"oneToOneChat"];
    
    // chatHistoryBetweenRequestedUsers
}

#pragma mark ---- API Response Methods  ----

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    NSLog(@"--- Response :%@",responseDictionary);
    
    NSMutableData *data = [responseDictionary valueForKey:MYS_RESPONSE_DATA_KEY];
    NSError* error = nil;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"--- Response :%@",json);
    
    if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"chathistories"])
    {
        NSMutableDictionary *dataDict=[[json objectForKey:@"response"] objectForKey:@"data"];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(allChatResponseWithData:message:)])
        {
            [self.delegate allChatResponseWithData:dataDict message:[[json objectForKey:@"response"] objectForKey:@"message"]];
        }
    }
    else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"oneToOneChat"])
    {
        NSDictionary *dataDict=[[json objectForKey:@"response"] objectForKey:@"data"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatHistoryBetweenRequestedUsers:)]) {
            
            NSMutableArray *historyArray=[[NSMutableArray alloc] init];
            
            // Extract messages
            for (NSDictionary *msgDict in dataDict)
            {
                chatMessageDTO *chatMsg=[chatMessageDTO new];
                chatMsg.messageType=@"10";
                chatMsg.messageFromUserId=[msgDict objectForKey:@"from"];
                chatMsg.messageToUserId=[msgDict objectForKey:@"to"];
                chatMsg.messageId=[msgDict objectForKey:@"id"];
                chatMsg.message=[msgDict objectForKey:@"message"];
                chatMsg.messageSent=[msgDict objectForKey:@"sent"];
                
                [historyArray addObject:chatMsg];
            }
            
            [self.delegate chatHistoryBetweenRequestedUsers:historyArray];
        }
    }
}

- (void)didFailWithError:(NSDictionary *)error
{
#if DEBUG
    NSLog(@"-- Request Fail :%@",error);
#endif
    
    if(delegate!=nil && [delegate respondsToSelector:@selector(requestFailWithError:)])
        [delegate requestFailWithError:@"Request fail"];
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
