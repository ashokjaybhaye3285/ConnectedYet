//
//  UserManager.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 28/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"
#import "MYSGenericProxy.h"
#import "chatMessageDTO.h"
#import "UsersData.h"

@protocol  ChatDataManager <NSObject>

-(void)requestFailWithError:(NSString *)_errorMessage;

@optional

-(void)allChatResponseWithData:(NSDictionary*)data message:(NSString*)message;
-(void)chatHistoryBetweenRequestedUsers:(NSMutableArray*)data;

@end


@interface ChatDataManager : NSObject <MYSWebRequestProxyDelegate>
{
    AppDelegate *appDelegate;
    MYSGenericProxy *proxy;
}

@property (nonatomic, assign) id<ChatDataManager> delegate;

//Get All Chatting threads against UserId
-(void)getAllChatForUser:(NSString *)userId;

//Get Chat history between two users
-(void)getChatHistoryForUser:(NSString *)fromUserId withUser:(NSString*)toUserId;


@end
