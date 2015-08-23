//
//  ForgotPasswordView.h
//  ConnectedYet
//
//  Created by Iphone_Dev on 28/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginManager.h"

@interface ForgotPasswordView : UIViewController < LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;

    
    IBOutlet UITextField *textEmailAdd;
    
}

@end
