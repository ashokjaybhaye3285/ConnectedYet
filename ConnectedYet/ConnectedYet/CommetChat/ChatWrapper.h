//
//  ChatWrapper.h
//
//
//  Created by Rajesh.
//  Copyright (c) 2015 Rajesh Pardeshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CometChatSDK/CometChat.h>

// DTO Classes for data traversing
#import "chatAnnouncementDTO.h"
#import "chatUser.h"
#import "chatMessageDTO.h"
#import "Constant.h"


@class AppDelegate;
@class DatabaseConnection;

@protocol CometChatObserver <NSObject>
@optional

// When the server sends an update related to your profile
-(void)didReceivedMyProfileUpdate:(NSDictionary*)userInfo;

// When the server sends an updated user’s list
-(void)didReceivedOnlineUsersList:(NSDictionary*)onlineUsersList;

/**
 * When a message is received
 * type = 0 : For normal text messages
 * type = 1 : For messages containing emoticons
 * type = 2 : For join chatroom invite message
 * type = 3 : For image messages
 * type = 4 : For video messages
 **/
-(void)didReceivedMessage:(chatMessageDTO*)message;

// When the admin sends a site-wide announcement
-(void)didReceivedAdminAnnouncement:(NSDictionary*)adminAnnouncement;

/**
 * When an audio video chat message is received
 * Types of messages received
 
 * AVCHAT_CALL_ACCEPTED
 * type = 1 : Audio video call request has been accepted
 
 * AVCHAT_INCOMING_CALL
 * type = 2 : Incoming audio video call request
 
 * AVCHAT_INCOMING_CALL_USER_BUSY
 * type = 3 : Incoming audio video call request while user is busy
 
 * AVCHAT_END_CALL
 * type = 4 : Audio video call has been ended
 
 * AVCHAT_REJECT_CALL
 * type = 5 : Audio video call request has been rejected
 
 * AVCHAT_CANCEL_CALL
 * type = 6 : Audio video call has been cancelled
 
 * AVCHAT_NO_ANSWER
 * type = 7 : No answer received for audio video call request sent
 
 * AVCHAT_BUSY_CALL
 * type = 8 : Busy call received for audio video call request sent
 **/
-(void)didReceivedAVChat:(chatMessageDTO*)message;

// If there’s an error while performing the subscribing
// NSError containing error code and message
-(void)didReceivedErrorWithInfo:(NSError*)error;

@end


@interface ChatWrapper : NSObject
{
    DatabaseConnection *database;
    AppDelegate *appDelegate;
    
}

@property(weak,nonatomic) id <CometChatObserver> ChatObserver;
@property(nonatomic,retain)CometChat *cometchat;

// Login with user id with completion block
-(void)loginWithUserId:(NSString*)userId
       completionBlock:(void (^)(BOOL status))completionBloack;

// Login with user name and password with completion block
-(void)loginWithUserName:(NSString*)userName andPassword:(NSString*)password
         completionBlock:(void (^)(BOOL status))completionBloack;


// Instanciate the chat object
-(id)initChat;

-(void)getChatHistory;

// Send message to specific user with completion block
- (void)sendMessage:(NSString *)message
             toUser:(NSString *)userID
            completionBlock:(void (^)(BOOL status))completionBloack;

// Send Image
- (void)sendImageWithData: (NSData * ) imageData
                   toUser: (NSString * ) userID
                        completionBlock:(void (^)(BOOL status))completionBloack;

//Video With Path
-(void)sendVideoWithPath:(NSString *)videoPath toUser:(NSString *)userID completionBlock:(void (^)(BOOL status))completionBloack;


// Send Video
-(void) sendVideoWithURL: (NSURL * ) videoURL
                   toUser:(NSString * ) userID
                        completionBlock:(void (^)(BOOL status))completionBloack;

+(ChatWrapper*)sharedChatWrapper;
-(void)instantiateChat;

-(BOOL)isLoing;
-(void)logoutExistingUser; //Log out

@end
