



#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SignUpViewController.h"
#import "ForgotPasswordView.h"

#import "CustomAlertView.h"
#import "SocialRadarView.h"

#import "InviteContactsView.h"
#import "InboxViewController.h"

#import "PrimaryLanguageView.h"

#import <GoogleOpenSource/GoogleOpenSource.h>
static NSString * const kClientId = @"484728830826-h7a3okrtcsd26eiecbdekbr664lllv8r.apps.googleusercontent.com";


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 45 : 35, 20)];
    textUserName.leftView = paddingView;
    textUserName.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 45 : 35, 20)];
    textPassword.leftView = paddingView;
    textPassword.leftViewMode = UITextFieldViewModeAlways;
    
    NSLog(@"-- LOGIN --");

    //textUserName.text = @"ashoka";
    //textPassword.text = @"ashoka";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnForgotPasswordTapped:(id)sender
{
    ForgotPasswordView *forgot;
    
    if(appDelegate.iPad)
        forgot = [[ForgotPasswordView alloc]initWithNibName:@"ForgotPasswordView_iPad" bundle:nil];
    else
        forgot = [[ForgotPasswordView alloc]initWithNibName:@"ForgotPasswordView" bundle:nil];

    [self.navigationController pushViewController:forgot animated:YES];
    
}

-(IBAction)btnLoginTapped:(id)sender
{
    [textUserName resignFirstResponder];
    [textPassword resignFirstResponder];
    
    if(textUserName.text.length != 0)
    {
        if(textPassword.text.length != 0)
        {
            if([MYSBaseProxy isNetworkAvailable])
            {
                [appDelegate startSpinner];
                
                loginManager = [[LoginManager alloc]init];
                [loginManager setLoginManagerDelegate:self];
                
                NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
                
                [dataDict setObject:textUserName.text forKey:@"username"];
                [dataDict setObject:textPassword.text forKey:@"password"];
                
                [loginManager getLogin:dataDict];

            }
            else
            {
                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                [alert show];
                
            }
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"password_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];

        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"username_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];

    }
     
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
    [self navigateToSignUpView];
/*
    InviteContactsView *invite;
    if(appDelegate.iPad)
        invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView_iPad" bundle:nil];
    else
        invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView" bundle:nil];
    
    invite.isForEdit = NO;
    [self.navigationController pushViewController:invite animated:YES];
    */
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

-(void)navigateToSignUpView
{
    SignUpViewController *signup;
    
    if(appDelegate.iPad)
        signup = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController_iPad" bundle:nil];
    else
        signup = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:signup animated:YES];

}

-(IBAction)btnRegisterTapped:(id)sender
{
    [self navigateToSignUpView];

}

#pragma mark -- -- -- -- 
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

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

-(void)successWithLogin:(NSString *)_message
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"-- Success With USer Id :%@", appDelegate.userDetails.userId);
#endif
    
     [appDelegate navigateToHomeViewController];

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
                    [appDelegate stopSpinner];
                    GTMLoggerError(@"Error: %@", error);
                }
                else {
                    
                    [appDelegate stopSpinner];

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
