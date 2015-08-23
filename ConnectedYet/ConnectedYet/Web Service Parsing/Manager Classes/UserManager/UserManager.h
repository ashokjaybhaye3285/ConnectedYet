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

#import "UsersData.h"
#import "ChatHistoryData.h"

#import "DatabaseConnection.h"

@protocol  UserManagerDelegate <NSObject>

-(void)requestFailWithError:(NSString *)_errorMessage;

@optional
-(void)problemForGettingResponse:(NSString *)_message;

-(void)successWithLogin:(NSString *)_message;
-(void)successWithUserListDetails:(NSMutableArray *)_dataArray;
-(void)successWithUserDetails:(UsersData *)_usersDataObject;
-(void)successWithAddContactRequest:(NSString *)_message;

-(void)successfullyPostComment:(NSString *)_message commentArray:(NSMutableArray *)_dataArray;
-(void)successfullyLikeUnlikePost:(NSString *)_message;

-(void)successWithEncounterDetails:(UsersData *)_usersDataObject;

-(void)successfullyDeletePost:(NSString *)_message;
-(void)successfullyDeleteComment:(NSString *)_message commentArray:(NSMutableArray *)_dataArray;

-(void)successWithCommentLikeDetails:(NSMutableArray *)_dataArray;
-(void)successWithGalleryImages:(NSMutableArray *)_dataArray;

-(void)successWithDeleteGalleryImages:(NSString *)_message withGalleryImages:(NSMutableArray *)_dataArray;

-(void)successWithFriendRequestStatus:(NSString *)_message;


-(void)successWithMyMatchList:(NSMutableArray *)_dataArray;
-(void)successWithUploadWallPost:(NSString *)_message postUserData:(UsersData *)_userData;


-(void)successWithSearchUsers:(NSMutableArray *)_dataArray;
-(void)successWithRadarUsers:(NSMutableArray *)_dataArray;


-(void)successWithInviteContact:(NSString *)_message;

-(void)successWithOneToOneChatHistory:(NSMutableArray *)_dataArray;
-(void)successWithInboxChatHistory:(NSMutableArray *)_dataArray;


@end


@interface UserManager : NSObject <MYSWebRequestProxyDelegate>
{
    AppDelegate *appDelegate;
    MYSGenericProxy *proxy;
    
    DatabaseConnection *database;
    
}

@property (nonatomic, assign) id<UserManagerDelegate> userManagerDelegate;


-(void)getAllUsersDetails:(NSString *)_keys;     //Get All USers Details
-(void)getUserDetails:(NSString *)_userId;     //Get USers Details

-(void)getEncounterDetailsWihEncounterId:(NSString *)_encounterId;


-(void)addNewContact:(NSMutableDictionary *)_dataDict;
-(void)postCommentOnServer:(NSMutableDictionary *)_dataDict;
-(void)postLikeUnlikeOnServer:(NSMutableDictionary *)_dataDict;


-(void)deletePostWithPostId:(NSString *)_postId loginUserId:(NSString *)_userId;
-(void)deleteCommentWithCommentId:(NSString *)_commentId loginUserId:(NSString *)_userId;

-(void)getWallPostCommentsAndLikeDetailsWithPostId:(NSString *)_postId;

-(void)getGalleryImagesForUserId:(NSString *)_galleryUserId withLoginUserId:(NSString *)_loginUserId;

-(void)deleteGalleryImagesForUserId:(NSString *)_userId withImageId:(NSMutableDictionary *)_dataDict;


-(void)setFriendRequestStatus:(NSMutableDictionary *)_dataDict;
-(void)getMyMatchListDetails;

-(void)uploadWallPost:(NSMutableDictionary *)_dataDict;
-(void)searchUsers:(NSMutableDictionary *)_dataDict;
-(void)getRadarUsersDetails:(NSMutableDictionary *)_dataDict;

-(void)inviteContactToApplication:(NSMutableDictionary *)_dataDict;


-(void)getUsersOneToOneChatHistoryForloginUserId:(NSString *)_loginUserId anotherUserId:(NSString *)_otherUserId;
-(void)getInboxChatHistoryDetailsForUserId:(NSString *)_loginUserId;


@end
