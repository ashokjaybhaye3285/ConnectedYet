



#import <UIKit/UIKit.h>

//#import "LogOutManager.h"

@class AppDelegate;


@interface MVYMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    AppDelegate *appDelegate;
    
    NSMutableArray *arrayMenuOption;
    NSMutableArray *arrayMenuIcon;

    NSMutableArray *arraySection;

    UIAlertView *alertLogout;
    
}

@end
