//
//  EncountersViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 30/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UserManager.h"
#import "AsyncImageView.h"

@interface EncountersViewController : UIViewController <UserManagerDelegate, UIScrollViewDelegate>
{
    
    AppDelegate *appDelegate;
    UserManager *userManager;
    UsersData *usersDataObeject;
    
    IBOutlet UIScrollView *scrollProfilePicture, *scrollBigImages;
    IBOutlet UIImageView *imageChat;
    IBOutlet UIButton *btnChat;

    NSMutableArray *arrayProfileImages;
    
    IBOutlet UILabel *labelName, *labelAddress;
    int currentIndex;
    
    IBOutlet UIButton *btnNext, *btnPrevious;
    
}


@end
