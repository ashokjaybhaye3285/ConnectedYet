



#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyScrollView.h"

#import "UsersData.h"
#import "LoginManager.h"

#import "UserManager.h"
#import "AsyncImageView.h"

@interface PhotosViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, LoginManagerDelegate, UserManagerDelegate>
{
    AppDelegate *appDelegate;
    UsersData *usersDetailsObject;
    UserManager *userManager;
    
    LoginManager *loginManager;
    NSString *galleryUserId;
    
    UIImage *imageGallery;
    
    IBOutlet UILabel *labelNoImages;
    
    IBOutlet MyScrollView *scrollImages;
    AsyncImageView *imageFullScreen;
    
    IBOutlet UIButton *btnSettings, *btnDelete;
   
    UIAlertView *alertProfilePic;
    UIImagePickerController *imagePicker;

    int countPhotos;
    
    NSMutableArray *arrayPhotos, *arrayDeleteImagesId, *arrayDeleteGalleryFlag;
    
}

@property (nonatomic, readwrite) BOOL isForEdit;

-(void)initWithUsersDetails:(UsersData *)_usersDetails galleryUserId:(NSString *)_galleryUserId;

@end
