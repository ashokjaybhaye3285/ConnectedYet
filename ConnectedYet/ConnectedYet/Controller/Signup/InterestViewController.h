



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"

@interface InterestViewController : UIViewController <LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UIButton *btnChatting, *btnDating, *btnMatrimony, *btnNext;
    IBOutlet UILabel *labelNoWorries;
    
    int selectedInterest;
    
}

@end
