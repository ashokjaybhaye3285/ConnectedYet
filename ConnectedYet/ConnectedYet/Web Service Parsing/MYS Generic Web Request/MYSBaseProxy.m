//
//  MYSBaseProxy.m
//  MYSWebRequestComponent
//
//  Created by IMAC05 on 26/06/14.
//  Copyright (c) 2014 IMAC05. All rights reserved.
//

#import "MYSBaseProxy.h"
#import "Reachability.h"

#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

#define kBoundary   @"---------------------------14737809831466499882746641449"

@interface MYSBaseProxy ()
{
    ASIFormDataRequest *multipartRequest;
    ASINetworkQueue *networkQueue;
}

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSTimer *connectionTimer;

@end


@implementation MYSBaseProxy

@synthesize baseProxyListener = _baseProxyListener;
@synthesize urlConnection = _urlConnection;
@synthesize receivedData = _receivedData;
@synthesize connectionTimer = _connectionTimer;

- (id)init
{
    _urlConnection = [[NSURLConnection alloc] init];
    _receivedData = [[NSMutableData alloc] init];
    
    return self;
}

+ (BOOL)isNetworkAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (NSInteger)requestMYSProxyToURL:(NSString *) requestURLString
     isRequestTypeSyncronous:(BOOL) isSynchronousBool
           withRequestMethod:(NSString *) requestMethodString
          withBodyParameters:(NSData *)bodyData
        withHeaderParameters:(NSDictionary *)headerParametersDict
               withRequestId:(NSString *)requestIdString
            withResponseData:(NSData **)responseData
{
    if ([MYSBaseProxy isNetworkAvailable])
    {
        NSString *requestUrl = [NSString stringWithFormat:@"%@%@",MYS_REQUEST_BASE_URL,requestURLString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
#if DEBUG
        NSLog(@"-- Request URL :%@",requestUrl);
#endif
        
        if (![requestUrl isEqualToString:@""] && ![requestMethodString isEqualToString:@""])
        {
            [request setURL:[NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            [request setHTTPMethod:requestMethodString];
            [request setTimeoutInterval:MYS_REQUEST_TIMEOUT];
            [request setValue:requestIdString forHTTPHeaderField:MYS_REQUEST_ID_KEY];
            
            [self setMYSRequestHeaderContentType:request withContentTypeString:MYS_CONTENT_TYPE_VALUE];
            
            if (headerParametersDict)
                [self setMYSRequestHeaderParameters:request withHeaderParametersDict:headerParametersDict];
            else
                NSLog(@"No header set for %@ request.",requestIdString);
            
            if (bodyData)
                [request setHTTPBody:bodyData];
            else
                NSLog(@"No body set for %@ request.",requestIdString);
            
        }
        else
        {
            NSLog(@"%s:%s: Request URL not found.",__FILE__,__FUNCTION__);
            return MYS_INCORRECT_REQUEST;
        }
        
        
        if (isSynchronousBool)
        {
            NSURLResponse *response;
            NSError *error;
            *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (!error)
            {
                if (responseData)
                {
                    return MYS_REQUEST_SUCCESSFULL;
                }
                else
                {
                    NSLog(@"Empty response data.");
                    return MYS_REQUEST_SUCCESSFULL;
                }
            }
            else
            {
                if (error.code)
                {
                    NSLog(@"Error : %@",error);
                    return error.code;
                }
            }
        }
        else
        {
            _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [self.urlConnection start];
            
            [self.connectionTimer invalidate];
            self.connectionTimer = [NSTimer scheduledTimerWithTimeInterval:MYS_REQUEST_TIMEOUT
                                                                    target: self
                                                                  selector: @selector(urlConnectionTimedOut:)
                                                                  userInfo: nil
                                                                   repeats: NO];
        }
    }
    else
    {
        if (!isSynchronousBool)
        {
            [self.connectionTimer invalidate];
        }
        
        NSError *error = [NSError errorWithDomain:@"MYSNetworkCheckDomain" code:-1005 userInfo:@{NSLocalizedDescriptionKey : @"Please check device network."}];
        
        if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithError:)])
        {
            [self.baseProxyListener didFailWithError:@{MYS_REQUEST_ID_KEY : requestIdString,
                                                       @"error":error}];
        }
    }
    
    return 0;
}


- (NSInteger)uploadImageWithImage:(NSDictionary *)imagesDict postData:(NSString *)_postData
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/pictures/%@", appDelegate.userDetails.userId];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    
    //[post_dict setObject:_postData forKey:@"post_data"];

    // add params (all params are strings)
    for (NSString *param in post_dict) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [post_dict objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    //NSLog(@"-- Images :%@",imagesDict);
    
    NSArray*keys=[imagesDict allKeys];
    
    for(int i =0; i<[keys count]; i++)
    {
        NSLog(@"-- Keys  :%@",[keys objectAtIndex:i]);
        
        NSString *imageKey = [keys objectAtIndex:i];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", imageKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[imagesDict valueForKey:imageKey]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Close off the request with the boundary
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:baseurl]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         //  NSLog(@"-- RESULT :%@",result);
         //  NSLog(@"-- response :%@",response);
         
         if (data)
         {
             NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
             
             if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didRecieveResponseForUploadImages:)])
             {
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions
                                                                        error:&error];
                 
                 [self.baseProxyListener didRecieveResponseForUploadImages:json];
                 
             }
             
         }
         else
         {
             NSLog(@"Error : %@",error.debugDescription);
             
             if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithErrorForUploadImages:)])
                 [self.baseProxyListener didFailWithErrorForUploadImages:@{@"error":error}];
             
             
         }
         
     }];
    
    return 0;
    
}


- (NSInteger)uploadGalleryImageWithImage:(NSDictionary *)imagesDict postData:(NSString *)_postData withRequestUrl:(NSString *)baseurl
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //NSString *baseurl = [NSString stringWithFormat:@"http://aegis-infotech.com/connectedyet/web/api/galleries/%@", appDelegate.userDetails.userId];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];

    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    
    //[post_dict setObject:_postData forKey:@"post_data"];
    
    // add params (all params are strings)
    for (NSString *param in post_dict) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [post_dict objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    //NSLog(@"-- Images :%@",imagesDict);
    
    NSArray*keys=[imagesDict allKeys];
    
    for(int i =0; i<[keys count]; i++)
    {
        NSLog(@"-- Keys  :%@",[keys objectAtIndex:i]);
        
        NSString *imageKey = [keys objectAtIndex:i];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", imageKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[imagesDict valueForKey:imageKey]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Close off the request with the boundary
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:baseurl]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data)
         {
             NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
             
             if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didRecieveResponseForUploadImages:)])
             {
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions
                                                                        error:&error];
                 
                 [self.baseProxyListener didRecieveResponseForUploadImages:json];
                 
             }
             
         }
         else
         {
             NSLog(@"Error : %@",error.debugDescription);
             
             if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithErrorForUploadImages:)])
                 [self.baseProxyListener didFailWithErrorForUploadImages:@{@"error":error}];
             
             
         }
         
     }];
    
    return 0;
    
}

- (void)cancelRequest:(NSString *)requestIdString
{
    NSURLRequest *request = [self.urlConnection currentRequest];

    if ([[request valueForHTTPHeaderField:MYS_REQUEST_ID_KEY] isEqualToString:requestIdString])
    {
        [self.connectionTimer invalidate];
        [self.urlConnection cancel];
        self.baseProxyListener = nil;
    }
    else
    {
        NSLog(@"Because of incorrect request id cancel request call failed.");
    }
}

#pragma mark -
#pragma mark - Selector Methods

- (void)urlConnectionTimedOut:(NSTimer *)timerObj
{
    [self.urlConnection cancel]; //NSURLConnection object
    [self.connectionTimer invalidate];
    
    if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithError:)])
        [self.baseProxyListener didFailWithError:@{MYS_REQUEST_ID_KEY : [self.urlConnection.currentRequest valueForHTTPHeaderField:MYS_REQUEST_ID_KEY]}];
}

#pragma mark -
#pragma mark - NSURLConnection Delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if ([data length] > 0)
        [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didRecieveResponse:)])
    {
        NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      STATUS_SUCCESS, MYS_RESPONSE_STATUS_KEY ,
                                      self.receivedData, MYS_RESPONSE_DATA_KEY,
                                      [connection.currentRequest valueForHTTPHeaderField:MYS_REQUEST_ID_KEY],MYS_REQUEST_ID_KEY,
                                      nil];
        
        [self.baseProxyListener didRecieveResponse:responseDict];
    }
    
    self.receivedData = [[NSMutableData alloc] init];
    [self.connectionTimer invalidate];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.connectionTimer invalidate];
    
    if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithError:)])
        [self.baseProxyListener didFailWithError:@{MYS_REQUEST_ID_KEY : [self.urlConnection.currentRequest valueForHTTPHeaderField:MYS_REQUEST_ID_KEY],
                                                   @"error":error}];
}

#pragma mark -
#pragma mark - Local Methods

- (void)setMYSRequestHeaderParameters:(NSMutableURLRequest *)urlRequest
             withHeaderParametersDict:(NSDictionary *)headerParametersDict
{
    for (NSString *key in [headerParametersDict allKeys])
        [urlRequest setValue:[headerParametersDict valueForKey:key] forHTTPHeaderField:key];
}

- (void)setMYSRequestHeaderContentType:(NSMutableURLRequest *)urlRequest
             withContentTypeString:(NSString *)contentTypeString
{
    [urlRequest setValue:contentTypeString forHTTPHeaderField:MYS_CONTENT_TYPE_KEY];
}

#pragma mark =
#pragma mark = Local Methods

//Multipart Request
-(void)uploadVideo:(NSString *)inputJSONString
 withVideoFilePath:(NSString *)videoPath
withThumbnailImageFilePath:(NSData *)thumbnailPath
{
    if ([MYSBaseProxy isNetworkAvailable])
    {
        NSString *url = [NSString stringWithFormat:MYS_VIDEO_UPLOAD_REQUEST_BASE_URL];
        networkQueue = [[ASINetworkQueue alloc] init];
        [networkQueue cancelAllOperations];
        [networkQueue setShowAccurateProgress:YES];
        [networkQueue setDelegate:self];
        [networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [networkQueue setRequestDidFailSelector: @selector(requestFailed:)];
        
        multipartRequest= [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] ;
        
        [multipartRequest addRequestHeader:@"Content-Type"
                                     value:@"application/x-www-form-urlencoded"];
        
        [multipartRequest addRequestHeader:@"vanswer_details"
                                     value:inputJSONString];
        
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:videoPath error:NULL];
        unsigned long long fileSize = [attributes fileSize];
        NSLog(@"While uploading Video file size = %llu",fileSize);
        
        NSLog(@"While uploading Thumbnail file size = %@",[NSByteCountFormatter stringFromByteCount:thumbnailPath.length
                                                                                         countStyle:NSByteCountFormatterCountStyleFile]);
        
        NSMutableData *videoFileData = [NSMutableData dataWithContentsOfFile:videoPath];
        [multipartRequest addData:videoFileData withFileName:@"testVideo.mov" andContentType:@"video/quicktime" forKey:@"uploaded_file"];
        [multipartRequest addData:thumbnailPath withFileName:@"testImage.jpg" andContentType:@"image/jpeg" forKey:@"uploaded_thumb"];
        
        [multipartRequest setTimeOutSeconds:20];
        [networkQueue addOperation:multipartRequest];
        [networkQueue go];
    }
    else
    {
        NSError *error = [NSError errorWithDomain:@"MYSNetworkCheckDomain" code:-1005 userInfo:@{NSLocalizedDescriptionKey : @"Please check device network."}];
        
        if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithError:)])
        {
            [self.baseProxyListener didFailWithError:@{MYS_REQUEST_ID_KEY : @"VideoUploaded",
                                                       @"error":error}];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)req
{
    if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didFailWithError:)])
    {
        [self.baseProxyListener didFailWithError:@{MYS_REQUEST_ID_KEY : @"VideoUploaded",
                                                   @"error":req.error}];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)req
{
    NSLog(@"response = %@",req.responseString);
    if (self.baseProxyListener && [self.baseProxyListener respondsToSelector:@selector(didRecieveResponse:)])
    {
        NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      STATUS_SUCCESS, MYS_RESPONSE_STATUS_KEY ,
                                      [req.responseString dataUsingEncoding:NSUTF8StringEncoding], MYS_RESPONSE_DATA_KEY,
                                      @"VideoUploaded",MYS_REQUEST_ID_KEY,
                                      nil];
        
        [self.baseProxyListener didRecieveResponse:responseDict];
    }
}

@end
