//
//  SignUpViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 13/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "SignUpViewController.h"
#import "EmailSignUpView.h"
#import "PrimaryLanguageView.h"

#import "MatrimonyAboutLifestyle.h"
#import "MatrimonyPersonalInfo.h"
#import "MatrimonyMatchView.h"

#import "CustomAlertView.h"
#import "Constant.h"

#import "InterestViewController.h"

#import <GoogleOpenSource/GoogleOpenSource.h>
static NSString * const kClientId = @"484728830826-h7a3okrtcsd26eiecbdekbr664lllv8r.apps.googleusercontent.com";


@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize signInButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[self setUpForGooglePlus];
}


-(void)setUpForGooglePlus
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- ------ ------ ------
#pragma mark ----- ------  BUTTON CLICK  ------ ------


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnFacebookTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        appDelegate.loginType = kFB;
        
        [appDelegate startSpinner];
        
        FBHelperObj =[[MYSFacebookHelper alloc]init];
        [FBHelperObj setFbHelperDelegate:self];
        
        [FBHelperObj FBLogIn];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"check_network", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        
        [alert show];
    }
    
}

-(IBAction)btnTwitterTapped:(id)sender
{
    appDelegate.loginType = kTwitter;

}

-(IBAction)btnGooglePlusTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        appDelegate.loginType = kGooglePlus;

        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        signIn.shouldFetchGooglePlusUser = YES;
        signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
        signIn.shouldFetchGoogleUserID = YES;
        
        signIn.clientID = kClientId;
                
        signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
        //signIn.scopes = @[ @"profile" ];            // "profile" scope
        
        signIn.delegate = self;
        [signIn authenticate];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"check_network", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        
        [alert show];
    }
  
}

-(IBAction)btnEmailTapped:(id)sender
{
    appDelegate.loginType = kEmail;
    
    EmailSignUpView *emailView;
    
    if(appDelegate.iPad)
        emailView = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView_iPad" bundle:nil];
    else
        emailView = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView" bundle:nil];
   
    [emailView isCommingForEditProfile:NO];
    
    [self.navigationController pushViewController:emailView animated:YES];
    
    /*
    MatrimonyAboutLifestyle *dating;
    
    if(appDelegate.iPad)
        dating = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle_iPad" bundle:nil];
    else
        dating = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle" bundle:nil];
    [self.navigationController pushViewController:dating animated:YES];
     
    
    MatrimonyMatchView *matrimony;
    appDelegate.userId = @"111";
    if(appDelegate.iPad)
        matrimony = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView_iPad" bundle:nil];
    else
        matrimony = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView" bundle:nil];
    
    [self.navigationController pushViewController:matrimony animated:YES];
    */
}

#pragma mark ----- ------ ------ ------
#pragma mark -----  Text View Delegate ------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


#pragma mark ----- ------ ------ ------

-(void)getLoginWithUserData:(LoginDetails *)_userData
{
#if DEBUG
    NSLog(@"--- Login With : %@",appDelegate.loginType);
#endif
    
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:_userData.userName forKey:@"username"];
    [dataDict setObject:_userData.userEmail forKey:@"email"];

    [dataDict setObject:_userData.userId forKey:@"password"];
    [dataDict setObject:_userData.userGender forKey:@"gender"];
    
    if(_userData.userBirthDate.length != 0)
        [dataDict setObject:_userData.userBirthDate forKey:@"date_of_birth"];
    else
        [dataDict setObject:@"" forKey:@"date_of_birth"];
    
    [dataDict setObject:@"" forKey:@"phone"];
    [dataDict setObject:@"" forKey:@"countrycode"];
    
    [dataDict setObject:_userData.userProfilePic forKey:@"profilePicturePath"];
    
    [dataDict setObject:@"en" forKey:@"locale"];
    [dataDict setObject:@"email" forKey:@"optby"];

    [loginManager registerNewUser:dataDict];

}

#pragma mark -----  Delegate Return Methods ------


-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}


-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}


-(void)successWithFBUserDetails:(LoginDetails *)_userData
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"--- FB Login Details :%@", _userData);
#endif
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [self getLoginWithUserData:_userData];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}


-(void)successWithNewUserRegistration:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        
        PrimaryLanguageView *language;
        
        if(appDelegate.iPad)
            language = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView_iPad" bundle:nil];
        else
            language = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView" bundle:nil];
        
        [self.navigationController pushViewController:language animated:YES];
        
    };
   
}


#pragma mark -----  ------   ---------
#pragma mark -----  Google Plus Delegate Methods ------


- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    [appDelegate stopSpinner];

#if DEBUG
    NSLog(@" Access Token : %@", auth.accessToken);
    NSLog(@"Email : %@", auth.userEmail);
#endif
    
    loginDetails = [[LoginDetails alloc]init];
    loginDetails.userEmail = auth.userEmail;

    ///------
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    
    [plusService setAuthorizer:auth];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error) {
                if (error) {
                    GTMLoggerError(@"Error: %@", error);
                } else {
                    
                    loginDetails.userId = person.identifier;
                    loginDetails.userName = person.displayName;

                    loginDetails.userFirstName = person.name.givenName;
                    loginDetails.userLastName = person.name.familyName;

                    loginDetails.userBirthDate = person.birthday;
                    loginDetails.userProfilePic = person.image.url;

                    loginDetails.userGender = person.gender;
                    
                    [self getLoginWithUserData:loginDetails];

#if DEBUG
                    NSLog(@"Google Id :%@",loginDetails.userId);
                    NSLog(@"User name :%@",loginDetails.userName);
                    
                    NSLog(@"User  first name :%@",loginDetails.userFirstName);
                    NSLog(@"User last name :%@",loginDetails.userLastName);

                    NSLog(@"User birth date :%@",loginDetails.userBirthDate);
                    NSLog(@"User profile pic :%@",loginDetails.userProfilePic);

                    NSLog(@"User gender :%@",loginDetails.userGender);
                    NSLog(@"About Me :%@",person.aboutMe);
#endif

                }
            }];
    
}

#pragma mark -----  ------   ---------

@end
