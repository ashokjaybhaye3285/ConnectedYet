




#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"

@interface VerificationViewController : UIViewController <LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    
    IBOutlet UILabel *labelVerification;
    IBOutlet UITextField *textOTP;
    

}

@property (nonatomic, retain) NSString *otpType;


@end
