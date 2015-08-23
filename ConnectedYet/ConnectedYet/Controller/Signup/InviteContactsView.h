



#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UserManager.h"
#import <AddressBook/AddressBook.h>

#import "ContactData.h"

@interface InviteContactsView : UIViewController <UserManagerDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;
    
    IBOutlet UILabel *labelRecordNotFound;
    IBOutlet UITableView *tableInviteContacts;
    IBOutlet UIButton *btnSkip;
    
    NSMutableArray *arrayContacts;
    

    
}

@property (nonatomic, readwrite) BOOL isForEdit;


@end
