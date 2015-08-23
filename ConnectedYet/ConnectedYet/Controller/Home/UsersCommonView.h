//
//  UsersCommonView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UserManager.h"
#import "AsyncImageView.h"

#import "SVPullToRefresh.h"

@interface UsersCommonView : UIViewController <UserManagerDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;
    
    IBOutlet UILabel *labelTopHeader, *labelRecordNotFound;
    IBOutlet UITableView *tableUsers;
    IBOutlet UIButton *btnGridView;
    
    UIScrollView *scrollGridView;
    
    NSMutableArray *arrayUserDetails;
    
}

@property (nonatomic, retain) NSString *strHeaderTitle;
@property (nonatomic, retain) NSMutableArray *arrayUserDetails;


@end
