//
//  ChatViewController.h
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UsersData.h"
#import "MYSBaseProxy.h"

// Chat
#import "ChatWrapper.h"

#import "ChatDataManager.h"
#import "CustomAlertView.h"

#import "UUInputFunctionView.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"

#import "DatabaseConnection.h"

@interface ChatViewController : UIViewController <CometChatObserver,UUInputFunctionViewDelegate,UUMessageCellDelegate,ChatDataManager>
{
    AppDelegate *appDelegate;
    DatabaseConnection *datbase;
    
    IBOutlet UILabel *labelTopHeader;
    
    IBOutlet UITextField *textChat;
    IBOutlet UIView *bottomMessageView;
    
    ChatWrapper *chatObj;
}
@property(nonatomic,retain)UsersData *targetUser;
@property(nonatomic,retain)UsersData *loginUser;
@property(nonatomic,retain)ChatWrapper *chatObj;
@property(nonatomic,retain)ChatDataManager *chatManager;

-(id)initWithTargetUser:(UsersData*)_targetUser;

@end
