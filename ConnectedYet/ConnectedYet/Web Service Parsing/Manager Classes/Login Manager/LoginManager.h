//
//  LoginManager.h
//  Kntor
//
//  Created by IMAC05 on 03/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#import "MYSGenericProxy.h"

#import "LoginDetails.h"
#import "CountryData.h"
#import "LanguageData.h"

#import "DropdownData.h"
#import "UsersData.h"

#import "DatabaseConnection.h"


@protocol  LoginManagerDelegate <NSObject>

-(void)requestFailWithError:(NSString *)_errorMessage;


@optional
-(void)successWithLogin:(NSString *)_message;
-(void)successWithLogOut:(NSString *)_message;

-(void)problemForGettingResponse:(NSString *)_message;

-(void)successWithCountryDetails:(NSMutableArray *)_dataArray;
-(void)successWithLanguageDetails:(NSMutableArray *)_dataArray;


-(void)successWithNewUserRegistration:(NSString *)_message;
-(void)successfullyUploadProfilePicture:(NSString *)_message;

-(void)successWithOTP:(NSString *)_message;
-(void)successfullyAddInterest:(NSString *)_message;


-(void)successWithMatrimonyPersonalInfo:(NSString *)_message;
-(void)successWithMatrimonyAboutYourselfs:(NSString *)_message;
-(void)successWithMatrimonyAboutLifestyle:(NSString *)_message;
-(void)successWithMatrimonyAboutValues:(NSString *)_message;

-(void)successWithMatrimonyMatch:(NSString *)_message;

-(void)successWithUpdateDattingInfo:(NSString *)_message;

-(void)successWithDropDownData:(DropdownData *)_dropDownData;

-(void)successfullyUploadGalleryPicture:(NSString *)_message galleryImages:(NSMutableArray *)_dataArray;


-(void)successWithResetForgotPassword:(NSString *)_message;
-(void)successWithChangePassword:(NSString *)_message;

-(void)successfullyUploadWallPictureWithId:(NSString *)_imageId;
-(void)successfullyUploadVoiceNote:(NSString *)_message;


-(void)successWitUpdatePersonalDetails:(NSString *)_message;
-(void)successWitUpdateLoginDetails:(NSString *)_message;

@end


@class AppDelegate;

@interface LoginManager : NSObject <MYSWebRequestProxyDelegate>
{
    AppDelegate *appDelegate;
    MYSGenericProxy *proxy;
    
    NSString *uploadRequestId;
}



@property (nonatomic, assign) id<LoginManagerDelegate>loginManagerDelegate;


// ------ GET REQUEST ------

-(void)getAllCountryDetails;   // Get All Country Details
-(void)getAllLanguages;   // Get All Language Details
-(void)getDropDownValuesDetails;   // Get All Dropdown Details

-(void)getLogOut;   // Get Log Out


// ------ POST REQUEST ------

-(void)getLogin:(NSMutableDictionary *)_dataDict;  // Login


-(void)registerNewUser:(NSMutableDictionary *)_dataDict;

-(void)uploadProfilePicture:(NSMutableDictionary *)_imagesDict;
-(void)uploadGalleryImages:(NSMutableDictionary *)_imagesDict;
-(void)uploadWallPostImages:(NSMutableDictionary *)_imagesDict;
-(void)uploadCoverImages:(NSMutableDictionary *)_imagesDict;
-(void)updateUsersProfilePicture:(NSMutableDictionary *)_imagesDict;

-(void)uploadVoiceNote:(NSMutableDictionary *)_imagesDict;


//-(void)registerNewUser:(NSMutableDictionary *)_dataDict imagesDict:(NSMutableDictionary *)_imagesDict;

-(void)verifyYourOTP:(NSMutableDictionary *)_dataDict;
-(void)addInterestAgainstUser:(NSMutableDictionary *)_dataDict;


-(void)setMatrimonyPersonalInformation:(NSMutableDictionary *)_dataDict;
-(void)setMatrimonyAboutYourself:(NSMutableDictionary *)_dataDict;

-(void)setMatrimonyAboutLifeStyle:(NSMutableDictionary *)_dataDict;
-(void)setMatrimonyAboutValues:(NSMutableDictionary *)_dataDict;

-(void)setMatrimonyMatch:(NSMutableDictionary *)_dataDict;


-(void)setDatingInfo:(NSMutableDictionary *)_dataDict;
-(void)getPasswordForLoginUser:(NSMutableDictionary *)_dataDict;
-(void)changePasswordForLoginUser:(NSMutableDictionary *)_dataDict;

-(void)updatePersonalDetails:(NSMutableDictionary *)_dataDict;
-(void)updateLoginDetails:(NSMutableDictionary *)_dataDict;

-(void)cancelAPIRequest;

@end
