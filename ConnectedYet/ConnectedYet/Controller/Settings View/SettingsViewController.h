//
//  SettingsViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CometChatSDK/CometChat.h>
#import "LoginManager.h"

@interface SettingsViewController : UIViewController <LoginManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *btnChatting, *btnDating, *btnMatrimony,*btnSelectlanguage;
    IBOutlet UIButton *btnChangeInterest;
    
    NSString *selectedInterest;
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    NSMutableArray *arrayLanguages;

}
@property(nonatomic) LANGUAGE lang;
@end
