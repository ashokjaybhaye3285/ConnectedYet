//
//  ChatWrapper.h
//
//
//  Created by Rajesh.
//  Copyright (c) 2015 Rajesh Pardeshi. All rights reserved.
//

#import "ChatWrapper.h"

static ChatWrapper *chatObject=nil;

@implementation ChatWrapper
@synthesize ChatObserver,cometchat;

// Instanciate the chat object
-(id)initChat
{
    self=[super init];
    if (self) {
        self.cometchat =  [[CometChat alloc] init];
    }
    return self;
}

+(ChatWrapper*)sharedChatWrapper{
    if (chatObject==nil) {
        chatObject=[[ChatWrapper alloc] init];
    }
    return chatObject;
}

-(void)instantiateChat
{
    if (self.cometchat==nil) {
        self.cometchat =  [[CometChat alloc] init];
    }
}

-(BOOL)isLoing
{
    if ([CometChat isLoggedIn]) {
        return true;
    }
    else{
        return false;
    }
}

-(void)getChatHistory
{
    [cometchat getChatHistoryOfUser:@"240" messageID:@"884"
                            success:^(NSDictionary *response)
     {
         NSLog(@"-- Chat History Respone :%@", response);
         
     } failure:^(NSError *error)
     {
         NSLog(@"-- Chat History Respone :%@", [error description]);

    }];

}

// Login with user name and password with completion block
-(void)loginWithUserName:(NSString*)userName andPassword:(NSString*)password
       completionBlock:(void (^)(BOOL status))completionBloack
{
    
    [self.cometchat loginWithURL:chatUrl
                        username:userName
                   password:password
                    success:^(NSDictionary *response){
                        
                        // start listing the incomming response
                        [self listingResponse];

                        completionBloack(true);
                    } failure:^(NSError *error) {
                        
                        NSLog(@"Error %@",[error description]);
                        completionBloack(false);
                    }];
}

// Login with user id with completion block
-(void)loginWithUserId:(NSString*)userId
       completionBlock:(void (^)(BOOL status))completionBloack
{
    [self.cometchat loginWithURL:chatUrl userID:[NSString stringWithFormat:@"%@",userId] success:^(NSDictionary *response){
        
        // start listing the incomming response
        [self listingResponse];
        
        completionBloack(true);
    }failure:^(NSError *error){
        completionBloack(false);
        
        NSLog(@"Error %@",[error description]);
    }];
}

// Send message to specific user with completion block
- (void)sendMessage:(NSString *)message
             toUser:(NSString *)userID
    completionBlock:(void (^)(BOOL status))completionBloack
{
    [self.cometchat sendMessage:message toUser:[NSString stringWithFormat:@"%@",userID] success:^(NSDictionary *response){
        completionBloack(true);
    } failure:^(NSError *error){
        completionBloack(false);
    }];
}

// Send image
- (void)sendImageWithData: (NSData * ) imageData
                   toUser: (NSString * ) userID
          completionBlock:(void (^)(BOOL status))completionBloack{
    
    [self.cometchat sendImageWithData:imageData toUser:[NSString stringWithFormat:@"%@",userID] success:^(NSDictionary *response){
        NSLog(@"Success Image");
        completionBloack(true);
    }failure:^(NSError *error){
        NSLog(@"Failur Image");
        completionBloack(false);
    }];
    
}

//TODO:  Send Video With Path
-(void)sendVideoWithPath:(NSString *)videoPath toUser:(NSString *)userID completionBlock:(void (^)(BOOL status))completionBloack
{
    [self.cometchat sendVideoWithPath: videoPath toUser:[NSString stringWithFormat:@"%@",userID] success: ^ (NSDictionary * response) {
        NSLog(@"videoPath %@",videoPath);
        
        
        NSLog(@"Video Response : %@",[response description]);
        completionBloack(true);
    }
    failure: ^ (NSError * error) {
        
        NSLog(@"Video Response : %@",[error description]);
        completionBloack(false);
    }];
}

// Send video With URL
-(void) sendVideoWithURL: (NSURL * ) videoURL
                   toUser: (NSString * ) userID
          completionBlock:(void (^)(BOOL status))completionBloack
{
    [self.cometchat sendVideoWithURL:videoURL toUser:[NSString stringWithFormat:@"%@",userID] success:^(NSDictionary *response){
        NSLog(@"Response dict is ---> %@",[response description]);
    }failure:^(NSError *error){
        NSLog(@"Error dict is ---> %@",[error description]);
    }];
}


// Start listing the incomming response
-(void)listingResponse
{
    [self.cometchat subscribeWithMode:YES onMyInfoReceived:^(NSDictionary *response)
     {
        // Get profile updates
        if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedMyProfileUpdate:)]) {
           
            [self.ChatObserver didReceivedMyProfileUpdate:response];
        }
         
    } onGetOnlineUsers:^(NSDictionary *response)
     {
        // Get list of online users
        if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedOnlineUsersList:)]) {
            [self.ChatObserver didReceivedOnlineUsersList:response];
        }
         
    } onMessageReceived:^(NSDictionary *response)
    {
        // Get message received to user
        if ([[response objectForKey:@"self"] integerValue]!=1)
        {
            if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedMessage:)]) {
                [self.ChatObserver didReceivedMessage:[self getChatMessageObjWithDictionary:response]];
            }
        }
        
    } onAnnouncementReceived:^(NSDictionary *response)
    {
        // Get announcement received from admin
        if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedAdminAnnouncement:)])
        {
            [self.ChatObserver didReceivedAdminAnnouncement:response];
        }
        
    } onAVChatMessageReceived:^(NSDictionary *response)
    {
        // Get audio/video message received with info
        if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedAVChat:)])
        {
            [self.ChatObserver didReceivedAVChat:[self getChatMessageObjWithDictionary:response]];
        }
        
    }
    failure:^(NSError *error)
    {
        // Get error info - if occured
        if (self.ChatObserver && [self.ChatObserver respondsToSelector:@selector(didReceivedErrorWithInfo:)]) {
            [self.ChatObserver didReceivedErrorWithInfo:error];
        }
    }];
}

#pragma mark -- Data extraction methods

-(chatMessageDTO*)getChatMessageObjWithDictionary:(NSDictionary*)response{

    chatMessageDTO *chatMessage=[chatMessageDTO new];
    chatMessage.messageType = [response objectForKey:@"message_type"];
    chatMessage.messageToUserId = [response objectForKey:@"to"];
    chatMessage.messageFromUserId = [response objectForKey:@"from"];
    chatMessage.messageId = [response objectForKey:@"id"];
    chatMessage.message = [response objectForKey:@"message"];
    chatMessage.messageSelf = [response objectForKey:@"self"];
    chatMessage.messageOld = [response objectForKey:@"old"];
    chatMessage.messageSent = [response objectForKey:@"sent"];
    
    return chatMessage;
}

@end
