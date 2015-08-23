



#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface UserListView : UIViewController
{
    
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIView *bottomView;
    IBOutlet UIButton *btnListView, *btnMapView;
    
    IBOutlet UIImageView *imageSelection;
    
    NSMutableArray *arrayUserDetails;

}

@end
