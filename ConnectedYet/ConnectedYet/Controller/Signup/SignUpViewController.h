



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>
#import "MYSFacebookHelper.h"

#import "LoginManager.h"
#import "LoginDetails.h"

#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@class GPPSignInButton;

@interface SignUpViewController : UIViewController <FBHelperDelegate, LoginManagerDelegate, GPPSignInDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    LoginDetails *loginDetails;
    
    MYSFacebookHelper *FBHelperObj;
    
}

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@end
