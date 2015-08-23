//
//  MYSGenericProxy.m
//  MYSWebRequestComponent
//
//  Created by IMAC05 on 27/06/14.
//  Copyright (c) 2014 IMAC05. All rights reserved.
//

#import "MYSGenericProxy.h"

@interface MYSGenericProxy()

@property (nonatomic, strong) MYSBaseProxy *baseProxyObj;

@end

@implementation MYSGenericProxy

@synthesize genericProxyListener = _genericProxyListener;
@synthesize baseProxyObj = _baseProxyObj;

- (id)init
{
    _baseProxyObj = [[MYSBaseProxy alloc] init];
    self.baseProxyObj.baseProxyListener = self;
    return self;
}

#pragma mark -
#pragma mark MYS - Network Availability methods

+ (BOOL)isNetworkAvailable
{
    return [MYSBaseProxy isNetworkAvailable];
}

#pragma mark MYS - Synchronous methods

- (NSInteger)syncronouslyGETRequestURL:(NSString *) requestURLString
                    withBodyParameters:(NSData *)bodyData
                  withHeaderParameters:(NSDictionary *)headerParametersDict
                         withRequestId:(NSString *)requestIdString
                      withResponseData:(NSData **)responseData
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:YES
                      withRequestMethod:@"GET"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:responseData];
}


- (NSInteger)syncronouslyPOSTRequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString
                       withResponseData:(NSData **)responseData
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:YES
                      withRequestMethod:@"POST"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:responseData];
}

- (NSInteger)syncronouslyPUTRequestURL:(NSString *) requestURLString
                    withBodyParameters:(NSData *)bodyData
                  withHeaderParameters:(NSDictionary *)headerParametersDict
                         withRequestId:(NSString *)requestIdString
                      withResponseData:(NSData **)responseData
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:YES
                      withRequestMethod:@"PUT"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:responseData];
}

- (NSInteger)syncronouslyDELETERequestURL:(NSString *) requestURLString
                       withBodyParameters:(NSData *)bodyData
                     withHeaderParameters:(NSDictionary *)headerParametersDict
                            withRequestId:(NSString *)requestIdString
                         withResponseData:(NSData **)responseData
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:YES
                      withRequestMethod:@"DELETE"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:responseData];
}


#pragma mark MYS - Asynchronous methods

- (NSInteger)asyncronouslyGETRequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:NO
                      withRequestMethod:@"GET"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:nil];
}

- (NSInteger)asyncronouslyPOSTRequestURL:(NSString *) requestURLString
                      withBodyParameters:(NSData *)bodyData
                    withHeaderParameters:(NSDictionary *)headerParametersDict
                           withRequestId:(NSString *)requestIdString
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:NO
                      withRequestMethod:@"POST"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:nil];
}

- (NSInteger)asyncronouslyPUTRequestURL:(NSString *) requestURLString
                     withBodyParameters:(NSData *)bodyData
                   withHeaderParameters:(NSDictionary *)headerParametersDict
                          withRequestId:(NSString *)requestIdString
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:NO
                      withRequestMethod:@"PUT"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:nil];
}

- (NSInteger)asyncronouslyDELETERequestURL:(NSString *) requestURLString
                        withBodyParameters:(NSData *)bodyData
                      withHeaderParameters:(NSDictionary *)headerParametersDict
                             withRequestId:(NSString *)requestIdString
{
    return [_baseProxyObj requestMYSProxyToURL:requestURLString
                isRequestTypeSyncronous:NO
                      withRequestMethod:@"DELETE"
                     withBodyParameters:bodyData
                   withHeaderParameters:headerParametersDict
                          withRequestId:requestIdString
                       withResponseData:nil];
}

-(void)uploadVideo:(NSString *)inputJSONString
 withVideoFilePath:(NSString *)videoPath
withThumbnailImageFilePath:(NSData *)thumbnailPath
{
    [_baseProxyObj uploadVideo:inputJSONString
             withVideoFilePath:videoPath
    withThumbnailImageFilePath:thumbnailPath];
}

// NEW METHOD  For Add images ---
- (NSInteger)asyncronouslyUploadImage:(NSDictionary *)_imageDict
                             postData:(NSString *)_postData
{
    
    return [_baseProxyObj uploadImageWithImage:_imageDict postData:_postData];
    
}

- (NSInteger)asyncronouslyUploadGalleryImage:(NSDictionary *)_imageDict
                             postData:(NSString *)_postData withRequestUrl:(NSString *)baseurl
{
    return [_baseProxyObj uploadGalleryImageWithImage:_imageDict postData:_postData  withRequestUrl:(NSString *)baseurl];

}

#pragma mark Cancel request method

- (void)cancelRequest:(NSString *)requestIdString
{
    [_baseProxyObj cancelRequest:requestIdString];
}

#pragma mark -
#pragma mark Base Proxy Delegate methods

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    if (self.genericProxyListener && [self.genericProxyListener respondsToSelector:@selector(didRecieveResponse:)])
    {
        [self.genericProxyListener didRecieveResponse:responseDictionary];
    }
}

- (void)didFailWithError:(NSDictionary *)error
{
    if (self.genericProxyListener && [self.genericProxyListener respondsToSelector:@selector(didFailWithError:)])
    {
        [self.genericProxyListener didFailWithError:error];
    }
}


- (void)didRecieveResponseForUploadImages:(NSDictionary *)responseDictionary;
{
    if (self.genericProxyListener && [self.genericProxyListener respondsToSelector:@selector(didRecieveResponseForUploadImages:)])
    {
        [self.genericProxyListener didRecieveResponseForUploadImages:responseDictionary];
    }
}


- (void)didFailWithErrorForUploadImages:(NSDictionary *)error
{
    if (self.genericProxyListener && [self.genericProxyListener respondsToSelector:@selector(didFailWithErrorForUploadImages:)])
    {
        [self.genericProxyListener didFailWithErrorForUploadImages:error];
    }
}


@end
