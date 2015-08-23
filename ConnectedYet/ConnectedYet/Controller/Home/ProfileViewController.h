//
//  ProfileViewController.h
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UsersData.h"
#import "AsyncImageView.h"

@interface ProfileViewController : UIViewController
{
    AppDelegate *appDelegate;
    UsersData *usersDetailsObject;
    
    IBOutlet AsyncImageView *imageProfile;
    
    IBOutlet UIButton *btnBack, *btnEdit;
    
    IBOutlet UILabel *labelUserName, *labelUserGender, *labelDistance, *labelMessage, *labelLocation, *labelRelStatus, *labelSexuality, *labelHeight, *labelSmoking, *labelDrinking, *labelEducation, *labelLanguage;
    
    IBOutlet UIButton *btnPersonalDetails, *btnLoginDetails, *btnCancel, *btnProfileDetails;
    UIView *viewEditViewBg, *viewEditView;
}

-(void)initWithUsersDetails:(UsersData *)_usersDetails;


@end
