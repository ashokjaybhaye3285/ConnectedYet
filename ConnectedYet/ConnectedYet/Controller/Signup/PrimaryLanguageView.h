



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"

@interface PrimaryLanguageView : UIViewController <UITableViewDataSource, UITableViewDelegate, LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UITextField *textLanguage;
    UIView *languageView;
    IBOutlet UIButton *btnSelectDate;
    
    NSMutableArray *arrayLanguages;
   
    IBOutlet UILabel *labelDescription;

    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;

    NSString *selectedLanguageCode;
    
}

@end
