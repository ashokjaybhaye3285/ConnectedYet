//
//  MYSBaseProxy.h
//  MYSWebRequestComponent
//
//  Created by IMAC05 on 26/06/14.
//  Copyright (c) 2014 IMAC05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSWebRequestConstants.h"
#import "AppDelegate.h"



@protocol MYSBaseProxyDelegate <NSObject>

/*
 * didRecieveResponse : Callback resonse recieved from http request
 */
- (void)didRecieveResponse:(NSDictionary *)responseDictionary;
- (void)didRecieveResponseForUploadImages:(NSDictionary *)responseDictionary;

/*
 * didFailWithError : Callback error resonse recieved from http request
 */
- (void)didFailWithError:(NSDictionary *)error;
- (void)didFailWithErrorForUploadImages:(NSDictionary *)error;

@end




@interface MYSBaseProxy : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    AppDelegate *appDelegate;
    
}

@property (nonatomic, strong) id <MYSBaseProxyDelegate> baseProxyListener;

/*
 * isNetworkAvailable -
 * This method is for checking reachability
 * Returns network status
 */
+ (BOOL)isNetworkAvailable;

/*
 * requestMYSProxyToURL -
 * This method is for making the http web request
 * requestURLString - URL of the web server
 * isSynchronousBool - Synchronous/Asynchronous request
 * requestMethodString - GET/PUT/POST/DELETE
 * bodyDataDict - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * responseData - Response data
 * returns the status of the request
 */
- (NSInteger)requestMYSProxyToURL:(NSString *) requestURLString
     isRequestTypeSyncronous:(BOOL) isSynchronousBool
           withRequestMethod:(NSString *) requestMethodString
          withBodyParameters:(NSData *)bodyData
        withHeaderParameters:(NSDictionary *)headerParametersDict
               withRequestId:(NSString *)requestIdString
            withResponseData:(NSData **)responseData;

/*
 * uploadVideo -
 * This method is for Uploading Video with thumbnail image and other contents
 * inputJSONString - for jSON String content
 * videoPath - for local video file path
 * thumbnailPath - for local thumbnail image file path
 */
-(void)uploadVideo:(NSString *)inputJSONString
 withVideoFilePath:(NSString *)videoPath
withThumbnailImageFilePath:(NSData *)thumbnailPath;

/* 
 * cancelConnections -
 * This method is for cancel Connection with server
 * requestIdString - for requestId of the request
 */
- (void)cancelRequest:(NSString *)requestIdString;

//------------------

- (NSInteger)uploadImageWithImage:(NSDictionary *)imagesDict postData:(NSString *)_postData;
- (NSInteger)uploadGalleryImageWithImage:(NSDictionary *)imagesDict postData:(NSString *)_postData withRequestUrl:(NSString *)baseurl;


@end