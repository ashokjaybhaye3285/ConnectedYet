//
//  MYSFacebookHelper.m
//  FacebookSharing
//
//  Created by IMAC04 on 27/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MYSFacebookHelper.h"
#import "CustomAlertView.h"

@implementation MYSFacebookHelper

@synthesize fbHelperDelegate;


NSString* const kFacebookAppURLString = @"https://developers.facebook.com/docs/ios/share/";
//App Launch

-(void)GetAppActive
{
    // Whenever a person opens the app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                          
                                      }];
    }
}

#pragma mark Login
//For Login
-(void)FBLogIn
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        
        //[FBSession.activeSession closeAndClearTokenInformation];
        
        [self LoggedInUser];//Showing alert if user already logged in
         [self UserDetails];//print UserDetails
        
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"email",@"user_location",@"user_hometown", @"user_birthday"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
        
    }
}


- (void)UserDetails
{
    if ([[FBSession activeSession] isOpen])
    {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (! error)
             {

                 loginUserObject = [[LoginDetails alloc] init];
                 appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 
                 loginUserObject.userEmail = [appDelegate checkForNullValue:[user objectForKey:@"email"]];
                 loginUserObject.userName = [appDelegate checkForNullValue:[user objectForKey:@"name"]];

                 loginUserObject.userBirthDate = [appDelegate checkForNullValue:[user objectForKey:@"birthday"]];

                 loginUserObject.userFirstName = [appDelegate checkForNullValue:user.first_name];
                 loginUserObject.userLastName = [appDelegate checkForNullValue:user.last_name];
                 
                 loginUserObject.userId = [appDelegate checkForNullValue:[user objectForKey:@"id"]];
                 loginUserObject.userFBLink = [appDelegate checkForNullValue:[user objectForKey:@"link"]];
                 
                 loginUserObject.userGender = [appDelegate checkForNullValue:[user objectForKey:@"gender"]];
                 loginUserObject.userProfilePic = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [user objectID]];

                 
                 id<FBGraphPlace> objPlace = user.location;
                 id<FBGraphLocation> objLocation = objPlace.location;
 
#if DEBUG
                 NSLog(@"FB user location:%@",user.location);
                 NSLog(@"place.location : %@ location.street : %@",objPlace.location,objLocation.street);

                 //details of user
                 NSLog(@"User details =%@",user);
                 NSLog(@"FB user first name:%@",user.first_name);
                 NSLog(@"Birthday:%@",user.birthday);

                 NSLog(@"FB user last name:%@",user.last_name);
                 NSLog(@"FB user location:%@",user.location);
                 NSLog(@"FB user username:%@",user.username);
                 NSLog(@"email id:%@",[user objectForKey:@"email"]);
                 NSLog(@"location:%@", [NSString stringWithFormat:@"Location: %@\n\n",
                                        user.location[@"name"]]);
#endif
                 
                 if(fbHelperDelegate!=nil && [fbHelperDelegate respondsToSelector:@selector(successWithFBUserDetails:)])
                     [fbHelperDelegate successWithFBUserDetails:loginUserObject];
                 
             }
         }];
    }else
    {
        [[FBSession activeSession] closeAndClearTokenInformation];
    }
}
-(void)FBLogOut
{
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self UserDetails];
        [self userLoggedIn];
        
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

// Show the user the logged-out UI
- (void)userLoggedOut
{
    [self showMessage:@"You're now logged out" withTitle:@""];
}

// Show the user the logged-in UI
- (void)userLoggedIn
{
    [self showMessage:@"You're now logged in" withTitle:@"Welcome!"];
}

- (void)LoggedInUser;
{
    [self showMessage:@"You're Already Logged In" withTitle:@""];
}

// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
#if DEBUG
    NSLog(@"-- Status : %@",title);
#endif
    
    /*
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
     */
    
}

#pragma mark Share
//Sharing
- (void)performPublishAction:(void(^)(void))action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled) {
                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                                        message:@"Unable to get permission to post"
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                    [alertView show];
                                                }
                                            }];
    } else {
        action();
    }
}
//Share Photo
- (void)FBSharePhoto:(UIImage *)image
{
    if (FBSession.activeSession.state == FBSessionStateOpen){
        BOOL canPresent = [FBDialogs canPresentShareDialogWithPhotos];
        NSLog(@"canPresent: %d", canPresent);
        
        FBPhotoParams *params = [[FBPhotoParams alloc] init];
        params.photos = @[image];
        
        BOOL isSuccessful = NO;
        if (canPresent) {
            FBAppCall *appCall = [FBDialogs presentShareDialogWithPhotoParams:params
                                                                  clientState:nil
                                                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                                          if (error) {
                                                                              NSLog(@"Error: %@", error.description);
                                                                          } else {
                                                                              NSLog(@"Success!");
                                                                          }
                                                                      }];
            isSuccessful = (appCall  != nil);
        }
        
        if (!isSuccessful) {
            [self performPublishAction:^{
                FBRequestConnection *connection = [[FBRequestConnection alloc] init];
                connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
                | FBRequestConnectionErrorBehaviorAlertUser
                | FBRequestConnectionErrorBehaviorRetry;
                
                [connection addRequest:[FBRequest requestForUploadPhoto:image]
                     completionHandler:^(FBRequestConnection *innerConnection, id result, NSError *error) {
                         [self showAlert:@"Photo Post" result:result error:error];
                         if (FBSession.activeSession.isOpen) {
                         }
                     }];
                [connection start];
            }];
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You are not Logged In"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        alertView.tag=1;
        [alertView show];
        // [self LogIn];
    }
}
//Share Video

- (void)FBShareVideo:(NSString *)filePath
{
    if (FBSession.activeSession.state == FBSessionStateOpen){
        [self performPublishAction:^{
            FBRequestConnection *connection = [[FBRequestConnection alloc] init];
            connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
            | FBRequestConnectionErrorBehaviorAlertUser
            | FBRequestConnectionErrorBehaviorRetry;
            
            [connection addRequest:[FBRequest requestForUploadVideo:filePath]
                 completionHandler:^(FBRequestConnection *innerConnection, id result, NSError *error) {
                     [self showAlert:@"Video Post" result:result error:error];
                     if (FBSession.activeSession.isOpen) {
                     }
                 }];
            [connection start];
            
        }];
    }else{
        //Login
        //[self LogIn];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You are not Logged In"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        alertView.tag=2;
        [alertView show];
    }
}

//Share Msg
-(void)FBShareMsg
{
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:kFacebookAppURLString];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        //Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];}
    
    else {
        // Present the feed dialog
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Sharing Tutorial", @"name",
                                       @"Build great social apps and get more installs.", @"caption",
                                       @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                       @"https://developers.facebook.com/docs/ios/share/", @"link",
                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}


// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}
//AlertView msgs
- (void)showAlert:(NSString *)message result:(id)result error:(NSError *)error {
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==1 || alertView.tag == 2) {
        [self FBLogIn];
    }
    
}


#pragma mark ------------------------------      NEW DATA
////////------

//------------------handle open URL------------------

- (BOOL)handleOpenUrl:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
{
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:
                          ^(FBAppCall *call) {
                              // Parse the incoming URL to look for a target_url parameter
                              NSString *query = [url query];
                              NSDictionary *params = [self parseURLParams:query];
                              // Check if target URL exists
                              NSString *appLinkDataString = [params valueForKey:@"al_applink_data"];
                              if (appLinkDataString) {
                                  NSError *error = nil;
                                  NSDictionary *applinkData =
                                  [NSJSONSerialization JSONObjectWithData:[appLinkDataString dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:0
                                                                    error:&error];
                                  if (!error &&
                                      [applinkData isKindOfClass:[NSDictionary class]] &&
                                      applinkData[@"target_url"])
                                  {
                                      //appDelegate.refererAppLink = applinkData[@"referer_app_link"];
                                      NSString *targetURLString = applinkData[@"target_url"];
                                      
                                      // Show the incoming link in an alert
                                      // Your code to direct the user to the
                                      // appropriate flow within your app goes here
                                      [[[UIAlertView alloc] initWithTitle:@"Received link:"
                                                                  message:targetURLString
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil] show];
                                  }
                              }
                          }];
    
    return urlWasHandled;
}

//------------------------------------

//------------------Sharing a link using the share dialog------------------
- (void)shareLinkWithShareDialog:(NSURL *)url OrWithnamecaptiondescriptionlinkpictureDictionary:(NSMutableDictionary *)inputDict
{
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = url;
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:inputDict
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                                  
                                                                  CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"post_success", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                                                                  [alert show];
                                                                  
                                                                  
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}

//------------------------------------

//------------------Posting a status update using the share dialog------------------
- (void)postStatusUpdateWithShareDialog:(NSURL *)url
{
    // Check if the Facebook app is installed and we can present the share dialog
    
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = url;
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:nil
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}


//------------------------------------
//------------------Sharing a photo using the Share Dialog ------------------

- (void)SharePhotoWithShareDialog:(UIImage *)img
{
    // If the Facebook app is installed and we can present the share dialog
    if([FBDialogs canPresentShareDialogWithPhotos])
    {
        NSLog(@"canPresent");
        FBPhotoParams *params = [[FBPhotoParams alloc] init];
        params.photos = @[img];
        
        [FBDialogs presentShareDialogWithPhotoParams:params
                                         clientState:nil
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if (error) {
                                                     NSLog(@"Error: %@", error.description);
                                                 } else {
                                                     NSLog(@"Success!");
                                                 }
                                             }];
        
    } else {
        //The user doesn't have the Facebook for iOS app installed, so we can't present the Share Dialog
        /*Fallback: You have two options
         1. Share the photo as a Custom Story using a "share a photo" Open Graph action, and publish it using API calls.
         See our Custom Stories tutorial: https://developers.facebook.com/docs/ios/open-graph
         2. Upload the photo making a requestForUploadPhoto
         See the reference: https://developers.facebook.com/docs/reference/ios/current/class/FBRequest/#requestForUploadPhoto:
         */
    }
}

//------------------------------------


@end
