



#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UsersData.h"

#import "UserManager.h"
#import "AsyncImageView.h"

#import <AVFoundation/AVFoundation.h>

@interface UserDetailsView : UIViewController <UserManagerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;
    
    UsersData *userDetailsObject;
    
    
    IBOutlet UILabel *labelTopHeader, *labelWelcomeMessage, *labelAgeSexAddDist, *labelOnlineTime;
    IBOutlet AsyncImageView *imageUser;
    IBOutlet UIButton *btnProfile, *btnWall, *btnPhotos, *btnChats, *btnAddToContacts;
    IBOutlet UIImageView *imageProfile, *imageWall, *imagePhotos, *imageChats, *imageAddToContacts;

    
    BOOL isImageClick;
    IBOutlet UIView *bottomUserDetailsView;
    IBOutlet UIButton *btnVoiceNote;
    
    AVAudioPlayer *player;

}


@property (nonatomic, retain) UsersData *userDetails;

//-(id)initWithUserDetails:(NSString *)_userDetails;

@end
