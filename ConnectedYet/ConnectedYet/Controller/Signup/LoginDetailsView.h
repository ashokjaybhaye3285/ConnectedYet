


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"

@interface LoginDetailsView : UIViewController <LoginManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UITextField *textUsername, *textEmail, *textCountryCode, *textCellPhone, *textPassword, *currentTextField;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *labelDescription, *labelTopHeader;
    
    NSString *selectedCountryCode;
    
    IBOutlet UIButton *btnSelectCountry, *btnNext;
    NSMutableArray *arrayCountry;
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;

    BOOL isEditProfile;
    
    IBOutlet UIImageView *imageDescBg;
    
}

-(void)initWithIsEditProfile:(BOOL)_isEditProfile;

@end
