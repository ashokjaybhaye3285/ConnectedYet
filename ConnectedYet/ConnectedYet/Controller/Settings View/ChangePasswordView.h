//
//  ChangePasswordView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 18/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"

#import "AppDelegate.h"


@interface ChangePasswordView : UIViewController <LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;

    IBOutlet UITextField *textNewPass, *textCurrentPass, *textConfirmPass;
    
    
}

@end
