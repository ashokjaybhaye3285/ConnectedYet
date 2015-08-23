//
//  MYSFacebookHelper.h
//  FacebookSharing
//
//  Created by IMAC04 on 27/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#import "LoginDetails.h"
#import "AppDelegate.h"

@protocol FBHelperDelegate <NSObject>

@optional
-(void)successWithFBUserDetails:(LoginDetails *)_userData;


@end


@interface MYSFacebookHelper : UIView
{
    AppDelegate *appDelegate;
    LoginDetails *loginUserObject;
    
}


@property (nonatomic, assign) id<FBHelperDelegate> fbHelperDelegate;



-(void)GetAppActive;
-(void)FBLogIn;
-(void)FBLogOut;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
- (void)showMessage:(NSString *)text withTitle:(NSString *)title;

//Share
-(void)FBShareMsg;
- (void)FBSharePhoto:(UIImage *)image;
- (void)FBShareVideo:(NSString *)filePath;


// --------------  NEW ADDED METHODS -------

- (BOOL)handleOpenUrl:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication;

- (void)shareLinkWithShareDialog:(NSURL *)url
OrWithnamecaptiondescriptionlinkpictureDictionary:(NSMutableDictionary *)inputDict;
- (void)postStatusUpdateWithShareDialog:(NSURL *)url;     //[NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"]

- (void)SharePhotoWithShareDialog:(UIImage *)img;


@end
