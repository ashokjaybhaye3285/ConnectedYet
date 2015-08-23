//
//  MYSGenericProxy.h
//  MYSWebRequestComponent
//
//  Created by IMAC05 on 27/06/14.
//  Copyright (c) 2014 IMAC05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSBaseProxy.h"

@protocol MYSWebRequestProxyDelegate <NSObject>

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


@interface MYSGenericProxy : NSObject<MYSBaseProxyDelegate>

@property (nonatomic, weak) id <MYSWebRequestProxyDelegate> genericProxyListener;

/*
 * isNetworkAvailable -
 * This method is for checking reachability
 * Returns network status
 */
+ (BOOL)isNetworkAvailable;



/*
 * syncronouslyGETRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * responseData - Response data
 * returns the status of the request
 */
- (NSInteger)syncronouslyGETRequestURL:(NSString *) requestURLString
               withBodyParameters:(NSData *)bodyData
             withHeaderParameters:(NSDictionary *)headerParametersDict
                    withRequestId:(NSString *)requestIdString
                 withResponseData:(NSData **)responseData;

/*
 * syncronouslyPOSTRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * responseData - Response data
 * returns the status of the request
 */
- (NSInteger)syncronouslyPOSTRequestURL:(NSString *) requestURLString
                    withBodyParameters:(NSData *)bodyData
                  withHeaderParameters:(NSDictionary *)headerParametersDict
                         withRequestId:(NSString *)requestIdString
                      withResponseData:(NSData **)responseData;

/*
 * syncronouslyPUTRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * responseData - Response data
 * returns the status of the request
 */
- (NSInteger)syncronouslyPUTRequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString
                       withResponseData:(NSData **)responseData;

/*
 * syncronouslyDELETERequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * responseData - Response data
 * returns the status of the request
 */
- (NSInteger)syncronouslyDELETERequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString
                       withResponseData:(NSData **)responseData;




/*
 * syncronouslyGETRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * returns the status of the request
 */
- (NSInteger)asyncronouslyGETRequestURL:(NSString *) requestURLString
                    withBodyParameters:(NSData *)bodyData
                  withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString;

/*
 * syncronouslyPOSTRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * returns the status of the request
 */
- (NSInteger)asyncronouslyPOSTRequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                           withRequestId:(NSString *)requestIdString;

/*
 * syncronouslyPUTRequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * returns the status of the request
 */
- (NSInteger)asyncronouslyPUTRequestURL:(NSString *) requestURLString
                    withBodyParameters:(NSData *)bodyData
                  withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString;

/*
 * syncronouslyDELETERequestURL -
 * This method is for making the http web request
 *
 * requestURLString - URL of the web server
 * bodyData - Request body data Dictionary
 * withHeaderParameters - Request Header data Dictionary
 * requestIdString - Request identifier
 * returns the status of the request
 */
- (NSInteger)asyncronouslyDELETERequestURL:(NSString *) requestURLString
                       withBodyParameters:(NSData *)bodyData
                     withHeaderParameters:(NSDictionary *)headerParametersDict
                             withRequestId:(NSString *)requestIdString;




/*
 * cancelConnections -
 * This method is for cancel Connection with server
 * requestIdString - for requestId of the request
 */

- (NSInteger)asyncronouslyUploadImage:(NSDictionary *)_imageDict
                             postData:(NSString *)_postData;
- (NSInteger)asyncronouslyUploadGalleryImage:(NSDictionary *)_imageDict
                                    postData:(NSString *)_postData withRequestUrl:(NSString *)baseurl;


- (void)cancelRequest:(NSString *)requestIdString;

-(void)uploadVideo:(NSString *)inputJSONString
 withVideoFilePath:(NSString *)videoPath
withThumbnailImageFilePath:(NSData *)thumbnailPath;

@end
