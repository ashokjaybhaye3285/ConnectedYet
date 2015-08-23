//
//  SettingsViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"

@interface SettingsViewController : UIViewController <LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *btnChatting, *btnDating, *btnMatrimony;
    IBOutlet UIButton *btnChangeInterest;
    
    NSString *selectedInterest;
    
}

@end
