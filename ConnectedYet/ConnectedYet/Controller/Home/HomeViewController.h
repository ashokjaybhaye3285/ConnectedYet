




#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

#import <AddressBook/AddressBook.h>

#import "UserManager.h"
#import "UsersData.h"
#import "LoginManager.h"

#import "AsyncImageView.h"
#import "SVPullToRefresh.h"

#import "ChatWrapper.h"
#import "UsersData.h"

@interface HomeViewController : UIViewController <MKMapViewDelegate, UserManagerDelegate, LoginManagerDelegate, CometChatObserver>
{
    AppDelegate *appDelegate;
    UserManager *userManager;
    
    
    MKMapView *mapView;
    
    IBOutlet UITableView *tableUser;
    
    NSMutableArray *arrayUserDetails, *arrayOriginalData;
    
    IBOutlet UIView *bottomView;
    IBOutlet UIButton *btnListView, *btnMapView, *btnGridView;//, *btnSettings;
    IBOutlet UIButton *btnAll, *btnGirls, *btnOnline, *btnBoys, *btnNew;
    
    IBOutlet UIImageView *imageSelection;
    
    UIScrollView *scrollGridView;
    
    int actualX;
    UIButton *btnAnimator;
    
    BOOL isAllData;
    NSString *currentFilterString;
    
}

@property (nonatomic, readwrite) BOOL isYourMatch;

@property(nonatomic,retain)ChatWrapper *chatObj;

@end
