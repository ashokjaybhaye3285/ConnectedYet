//
//  InboxViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "ChatDataManager.h"
#import "CustomAlertView.h"

#import "AsyncImageView.h"


@interface InboxViewController : UIViewController <ChatDataManager>
{
    AppDelegate *appDelegate;
    
    IBOutlet UITableView *tableMessages;
    
    NSMutableArray *arrayMessages;
    
}
@property(nonatomic,retain)ChatDataManager *chatManager;


@end
