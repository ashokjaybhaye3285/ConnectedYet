



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MYSFacebookHelper.h"

#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

#import "LoginDetails.h"

@class GPPSignInButton;

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginManagerDelegate, FBHelperDelegate, GPPSignInDelegate>
{
    LoginManager *loginManager;
    MYSFacebookHelper *FBHelperObj;

    LoginDetails *loginDetails;

    AppDelegate *appDelegate;
    
    IBOutlet UITextField *textUserName, *textPassword;
    IBOutlet UIButton *btnForgotPassword, *btnLogin, *btnFacebook, *btnTwitter, *btnGooglePlus, *btnRegister;
    
    BOOL iPad;
}


@end
