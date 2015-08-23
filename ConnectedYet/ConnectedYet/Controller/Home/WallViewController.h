//
//  WallViewController.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 23/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UsersData.h"
#import "UserManager.h"

#import "AsyncImageView.h"
#import "LoginManager.h"

@interface WallViewController : UIViewController< UIImagePickerControllerDelegate, UINavigationControllerDelegate, UserManagerDelegate, LoginManagerDelegate, UIActionSheetDelegate>
{
    AppDelegate *appDelegate;
    UsersData *usersDetailsObject;
    LoginManager *loginManager;
    
    UserManager *userManager;
    
    UIImage *imageWallPost;
    
    IBOutlet UILabel *labelTopHeader;
    
    IBOutlet AsyncImageView *imageCover, *imageProfile;
    
    IBOutlet UIButton *btnAddAttachment, *btnUploadPhoto, *btnCapturePhoto, *btnAddPost, *btnLikePost;
    
    //UIImageView *imageUploadPhoto, *imageCapturePhoto, *imageAddPost;
    UIImagePickerController *imagePicker;
    
    IBOutlet UIView *viewAttachment, *viewComment, *viewCommentList;
    
    IBOutlet UITableView *tablePosts, *tableCommentsList;
    
    IBOutlet UITextField *textComment;
    
    NSMutableArray *arrayWallPostData, *arrayLikeFlag, *arrayCommentList;
    int selectedIndex, selectedPostIndex;
    
    UIView *viewWallPost;
    IBOutlet UITextField *textWallPost;
    IBOutlet UIButton *btnCancelWallPost, *btnDoneWallPost, *btnUploadCoverPhoto;
 
    BOOL isCoverPhoto;

    UIView *fullImageView;
    
}

@property (nonatomic,  readwrite) BOOL isEditable;

-(void)initWithUsersDetails:(UsersData *)_usersDetails;

@end
