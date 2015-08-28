//
//  WallViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 23/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "WallViewController.h"
#import "Constant.h"

#import "wallPostsCell.h"
#import "LoadremoteImages.h"

#import "CustomAlertView.h"

#define kCellHeightiPad 300
#define kCellHeight 220

#define iPhoneOffset 120
#define iPadOffset 170

#define iPhoneCommentFont [UIFont fontWithName:@"Helvetica" size:14]
#define iPadCommentFont [UIFont fontWithName:@"Helvetica" size:16]

@interface WallViewController ()

@end

@implementation WallViewController


@synthesize isEditable;

-(void)initWithUsersDetails:(UsersData *)_usersDetails
{
    usersDetailsObject = _usersDetails;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if([appDelegate.userDetails.userId intValue] == [usersDetailsObject.userId intValue])
        btnUploadCoverPhoto.hidden = NO;
    else
        btnUploadCoverPhoto.hidden = YES;

        btnAddAttachment.hidden = NO;
   
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textComment.leftView = paddingView;
    textComment.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textWallPost.leftView = paddingView;
    textWallPost.leftViewMode = UITextFieldViewModeAlways;
    

    imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2;
    imageProfile.layer.masksToBounds = YES;
    imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    imageProfile.layer.borderWidth = 2.5f;
    
    
    //if(isEditable)
        //btnAddAttachment.hidden = NO;
    //else
        //btnAddAttachment.hidden = YES;
    
    
    if(usersDetailsObject)
    {
        labelTopHeader.text = usersDetailsObject.userName;
        
        NSLog(@"-- Cover Image :%@", usersDetailsObject.userCoverMedium);
        imageCover.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        
        if(usersDetailsObject.userCoverMedium.length !=0)
        {
            [imageCover loadImageFromURL:usersDetailsObject.userCoverBig];
            imageCover.contentMode = UIViewContentModeScaleToFill;
        }
        else
        {
            imageCover.loadingView.hidden = YES;
        }
        
        imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageProfile loadImageFromURL:usersDetailsObject.userProfileBig];

    }
    
    //-------

    arrayWallPostData = [[NSMutableArray alloc]init];
    arrayWallPostData = usersDetailsObject.arrayUserWallData;
    
    //arrayWallPostData = [[arrayWallPostData reverseObjectEnumerator] allObjects];
    
    arrayLikeFlag = [[NSMutableArray alloc]init];
    for(int i =0; i<[arrayWallPostData count]; i++)
    {
        NSLog(@"-- Like Data :%@",[[arrayWallPostData objectAtIndex:i] userPostLiked]);
        
        if([[[arrayWallPostData objectAtIndex:i] userPostLiked] isEqualToString:@"no"])
            [arrayLikeFlag addObject:@"0"];
        else
            [arrayLikeFlag addObject:@"1"];

    }
    
    [self getWallPostCommentsAndLikeForPostId:@"53"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getWallPostCommentsAndLikeForPostId:(NSString *)_postId
{
    //http://aegis-infotech.com/connectedyet/web/api/walls/178/datas/51
    //Where  51 post id and 178 login user ID.

    userManager = [[UserManager alloc]init];
    [userManager setUserManagerDelegate:self];
    
    [userManager getWallPostCommentsAndLikeDetailsWithPostId:_postId];
    
}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnAddAttachmentTapped:(id)sender
{
    isCoverPhoto = NO;
    
    if(btnAddAttachment.selected == NO)
    {
        btnAddAttachment.selected = YES;
        
        viewAttachment = [[UIView alloc]init];
        viewAttachment.backgroundColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1];
        [self.view addSubview:viewAttachment];

//-----------------
        btnUploadPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnUploadPhoto addTarget:self action:@selector(btnUploadPhotoTapped) forControlEvents:UIControlEventTouchUpInside];
                [viewAttachment addSubview:btnUploadPhoto];

        UIImageView *imageUploadPhoto = [[UIImageView alloc]init];
        imageUploadPhoto.image = [UIImage imageNamed:@"upload-picture-icon.png"];
        [btnUploadPhoto addSubview:imageUploadPhoto];
        
        UILabel *labelUploadPhoto = [[UILabel alloc]init];
        labelUploadPhoto.text = @"Upload Picture";
        labelUploadPhoto.textColor = [UIColor whiteColor];
        labelUploadPhoto.textAlignment = NSTextAlignmentCenter;
        [btnUploadPhoto addSubview:labelUploadPhoto];
//-------------
        
        btnCapturePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCapturePhoto addTarget:self action:@selector(btnCapturePhotoTapped) forControlEvents:UIControlEventTouchUpInside];
            [viewAttachment addSubview:btnCapturePhoto];
        
        UIImageView *imageCapturePhoto = [[UIImageView alloc]init];
        imageCapturePhoto.image = [UIImage imageNamed:@"capture-photo-icon"];
        [btnCapturePhoto addSubview:imageCapturePhoto];
        
        UILabel *labelCapturePhoto = [[UILabel alloc]init];
         labelCapturePhoto.text = @"Capture Photo";
        labelCapturePhoto.textColor = [UIColor whiteColor];
        labelCapturePhoto.textAlignment = NSTextAlignmentCenter;
       [btnCapturePhoto addSubview:labelCapturePhoto];
//-------------

        btnAddPost = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnAddPost addTarget:self action:@selector(btnAddPostTapped) forControlEvents:UIControlEventTouchUpInside];
            [viewAttachment addSubview:btnAddPost];
       
        UIImageView *imageAddPost = [[UIImageView alloc]init];
        imageAddPost.image = [UIImage imageNamed:@"add-post-icon"];
        [btnAddPost addSubview:imageAddPost];
        
        UILabel *labelAddPost = [[UILabel alloc]init];
        labelAddPost.text = @"Add Post";
        labelAddPost.textColor = [UIColor whiteColor];
        labelAddPost.textAlignment = NSTextAlignmentCenter;
        [btnAddPost addSubview:labelAddPost];
//-------------

        if(appDelegate.iPad)
        {
            int space = (DEVICE_WIDTH - 390)/4;

            viewAttachment.frame = CGRectMake(0, 70, DEVICE_WIDTH, 150);

            btnUploadPhoto.frame = CGRectMake(space, 10, 130, 130);
            imageUploadPhoto.frame = CGRectMake(15, 5, 100, 100);
            labelUploadPhoto.frame = CGRectMake(0, 100, 130, 30);
            labelUploadPhoto.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            btnCapturePhoto.frame = CGRectMake(space+btnUploadPhoto.frame.origin.x+130, 10, 130, 130);
            imageCapturePhoto.frame = CGRectMake(15, 5, 100, 100);
            labelCapturePhoto.frame = CGRectMake(0, 100, 130, 30);
            labelCapturePhoto.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            btnAddPost.frame = CGRectMake(space+btnCapturePhoto.frame.origin.x+130, 10, 130, 130);
            imageAddPost.frame = CGRectMake(15, 5, 100, 100);
            labelAddPost.frame = CGRectMake(0, 100, 130, 30);
            labelAddPost.font = [UIFont fontWithName:@"Helvetica" size:18];
            
        }
        else
        {
            int space = (DEVICE_WIDTH - 270)/4;

            viewAttachment.frame = CGRectMake(0, 64, DEVICE_WIDTH, 110);

            btnUploadPhoto.frame = CGRectMake(space, 10, 90, 90);
            imageUploadPhoto.frame = CGRectMake(15, 5, 60, 60);
            labelUploadPhoto.frame = CGRectMake(0, 60, 90, 30);
            labelUploadPhoto.font = [UIFont fontWithName:@"Helvetica" size:13];
            
            btnCapturePhoto.frame = CGRectMake(space+btnUploadPhoto.frame.origin.x+90, 10, 90, 90);
            imageCapturePhoto.frame = CGRectMake(15, 5, 60, 60);
            labelCapturePhoto.frame = CGRectMake(0, 60, 90, 30);
            labelCapturePhoto.font = [UIFont fontWithName:@"Helvetica" size:13];
            
            
            btnAddPost.frame = CGRectMake(space+btnCapturePhoto.frame.origin.x+90, 10, 90, 90);
            imageAddPost.frame = CGRectMake(15, 5, 60, 60);
            labelAddPost.frame = CGRectMake(0, 60, 90, 30);
            labelAddPost.font = [UIFont fontWithName:@"Helvetica" size:13];
            
        }
        
        viewAttachment.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            viewAttachment.alpha = 1;
            
        }completion:^(BOOL finished){
            
        }];

    }
    else
    {
        [self removeAttachmentView];
    }
    
}


-(void)removeAttachmentView
{
    btnAddAttachment.selected = NO;
    imageWallPost = nil; //TODO: cleae image data

    [UIView animateWithDuration:0.5 animations:^{
        
        viewAttachment.alpha = 0;
        
    }completion:^(BOOL finished){
        
        [viewAttachment removeFromSuperview];
        
    }];
}


-(void)btnUploadPhotoTapped
{
    [self removeAttachmentView];

    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if(appDelegate.iPad)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }];
    }
    else
    {
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
}

-(void)btnCapturePhotoTapped
{
    [self removeAttachmentView];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //[self presentViewController:imagePicker animated:YES completion:NULL];
        if(appDelegate.iPad)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:imagePicker animated:YES completion:NULL];
            }];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}


-(void)btnAddPostTapped
{
    [self removeAttachmentView];

    [self uploadWallPost];
    
    /*
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                          message:@"Post Added successfully"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [myAlertView show];
    */
}


#pragma mark --- ---- IMAGE PICKER DELEGATE METHOD ----- ---

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageWallPost = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    if(isCoverPhoto)
        [self uploadCoverPhoto];
    else
        [self uploadWallPost];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark --- ---- ----- ----- ---

-(void)uploadWallPost
{
    [self setWallPostView];
}

-(void)setWallPostView
{
    viewWallPost = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    viewWallPost.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewWallPost];
    
    textWallPost.text = @"";
    
    UIView *semiTransparentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    semiTransparentView.backgroundColor = [UIColor blackColor];
    semiTransparentView.alpha = 0.6;
    [viewWallPost addSubview:semiTransparentView];
    
    UIView *commentView = [[UIView alloc]init];
    commentView.backgroundColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1];
    commentView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    commentView.layer.cornerRadius = 6.0;
    commentView.layer.masksToBounds = YES;
    [viewWallPost addSubview:commentView];

    [commentView addSubview:textWallPost];
    [commentView addSubview:btnCancelWallPost];
    [commentView addSubview:btnDoneWallPost];

    if(appDelegate.iPad)
    {
        commentView.layer.borderWidth = 4.0;
        commentView.frame = CGRectMake((DEVICE_WIDTH-400)/2, 300, 400, 200);

        textWallPost.frame = CGRectMake(30, 40, commentView.frame.size.width-60, 40);
        
        int space = commentView.frame.size.width-240;
        
        btnCancelWallPost.frame = CGRectMake(space/3, 120, 120, 40);
        btnDoneWallPost.frame = CGRectMake(100+(space/3)+(space/3), 120, 120, 40);
    }
    else
    {
        commentView.layer.borderWidth = 2.0;
        commentView.frame = CGRectMake(25, 100, DEVICE_WIDTH-50, 145);
    
        textWallPost.frame = CGRectMake(10, 25, commentView.frame.size.width-20, 35);
        
        int space = commentView.frame.size.width-200;
        
        btnCancelWallPost.frame = CGRectMake(space/3, 85, 100, 35);
        btnDoneWallPost.frame = CGRectMake(100+(space/3)+(space/3), 85, 100, 35);
    }
    
}

-(IBAction)btnCancelWallPostTapped:(id)sender
{
    [viewWallPost removeFromSuperview];
    
}

-(IBAction)btnDoneWallPostTapped:(id)sender
{
    if(textWallPost.text.length !=0)
    {
        [self uploadWallPostOnServer];
        [viewWallPost removeFromSuperview];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter wall text." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
}


-(void)uploadWallPostOnServer
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        if(imageWallPost)
        {
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSData *_data = UIImageJPEGRepresentation (imageWallPost, 1);
            
            NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
            [imgDict setObject:_data forKey:@"uploadfile"];
            
            [loginManager uploadWallPostImages:imgDict];  //POST TEST

        }
        else
        {
            userManager = [[UserManager alloc]init];
            [userManager setUserManagerDelegate:self];
            
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
            
            [dataDict setObject:textWallPost.text forKey:@"message"];
            [dataDict setObject:@"" forKey:@"image_id"];
            [dataDict setObject:@"" forKey:@"video_id"];
            [dataDict setObject:@"" forKey:@"y_link"];
            [dataDict setObject:appDelegate.userDetails.userId forKey:@"user_id"];
            
            [userManager uploadWallPost:dataDict];

        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}


-(IBAction)btnUploadCoverPhotoTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Upload Cover Picture"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take Photo", @"Choose from Gallery",
                                  nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    

}

-(void)uploadCoverPhoto
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSData *_data = UIImageJPEGRepresentation (imageWallPost, 1);
        
        NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
        [imgDict setObject:_data forKey:@"uploadfile"];
        
        [loginManager uploadCoverImages:imgDict];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

#pragma mark --- ---- ----- ----- ---
#pragma mark ---- ----- ACTION SHEET DELEGATE ----  -----

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
            
        case 0:
            [self takePhotoFromCamera];
            break;
            
        case 1:
            [self choosePhotoFromGallery];
            break;
    }
    
}


-(void)takePhotoFromCamera
{
    isCoverPhoto = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //[self presentViewController:imagePicker animated:YES completion:NULL];
        if(appDelegate.iPad)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:imagePicker animated:YES completion:NULL];
            }];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

-(void)choosePhotoFromGallery
{
    isCoverPhoto = YES;

    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if(appDelegate.iPad)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }];
    }
    else
    {
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
}


#pragma mark --- ---- ----- ----- ---
#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//arrayUserDetails.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tablePosts)
    {
        if([arrayWallPostData count])
            return [arrayWallPostData count];
        else
            return 1;
    }
    else
        return [arrayCommentList count];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tablePosts)
    {
        if([arrayWallPostData count])
        {
            if(appDelegate.iPad)
            {
                if([[[arrayWallPostData objectAtIndex:indexPath.row] userPostImgBig] length] == 0)
                    return kCellHeightiPad - iPadOffset;
                else
                    return kCellHeightiPad;
                
            }
            else
            {
                if([[[arrayWallPostData objectAtIndex:indexPath.row] userPostImgBig] length] == 0)
                    return kCellHeight - iPhoneOffset;
                else
                    return kCellHeight;

            }

        }
        else
            return 50;

    }
    else
    {
        int _height = 0;
        
        _height = [self heightForComment:(int)indexPath.row];
        
        if(appDelegate.iPad)
            return _height + 30 + 35;
        else
            return _height + 30 + 30;

    }
    
}

-(int)heightForComment:(int)_index
{
    int _height;

    if(appDelegate.iPad)
    {
    _height = [appDelegate heightForString:[[arrayCommentList objectAtIndex:_index] userComment] withFont:iPadCommentFont labelWidht:tableCommentsList.frame.size.width-110];
    }
    else
    {
        _height = [appDelegate heightForString:[[arrayCommentList objectAtIndex:_index] userComment] withFont:iPhoneCommentFont labelWidht:tableCommentsList.frame.size.width-100];

    }
    
    return _height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tablePosts)
    {
        if([arrayWallPostData count])
        {
            static NSString *cellIdentifier = @"HomeCell";
            
            wallPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            NSArray *xib;
            if(appDelegate.iPad)
                xib = [[NSBundle mainBundle] loadNibNamed:@"wallPostsCell_iPad" owner:self options:nil];
            else
                xib = [[NSBundle mainBundle] loadNibNamed:@"wallPostsCell" owner:self options:nil];
            
            cell = [xib objectAtIndex:0];

            
            cell.imagePostProfile.layer.cornerRadius = cell.imagePostProfile.frame.size.width/2;
            cell.imagePostProfile.layer.masksToBounds = YES;
            cell.imagePostProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
            cell.imagePostProfile.layer.borderWidth = 1.5f;
            
            /*LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, cell.imagePostProfile.frame.size.width, cell.imagePostProfile.frame.size.height) ];
            [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
            [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [remote setImageWithURL:[NSURL URLWithString:usersDetailsObject.userProfileMedium] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
            remote.contentMode = UIViewContentModeScaleAspectFit;
            [cell.imagePostProfile addSubview:remote];
            */
            
            NSLog(@"-- Image :%@", [[arrayWallPostData objectAtIndex:indexPath.row] userPostImgBig]);
            NSLog(@"-- Desc :%@", [[arrayWallPostData objectAtIndex:indexPath.row] userPostDescription]);

            cell.imagePostProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
            [cell.imagePostProfile loadImageFromURL:usersDetailsObject.userProfileSmall];

            
            cell.labelPostTitle.text = [NSString stringWithFormat:@"%@ shared: %@",usersDetailsObject.userName, [[arrayWallPostData objectAtIndex:indexPath.row] userPostDescription]];
            
            
            cell.labelPostDateTime.text = [[arrayWallPostData objectAtIndex:indexPath.row] userPostedDate];
            
            cell.labelLikeComment.text = [NSString stringWithFormat:@"%@ likes %@ comments", [[arrayWallPostData objectAtIndex:indexPath.row] userPostTotalLikes], [[arrayWallPostData objectAtIndex:indexPath.row] userPostTotalComments]];
            
            /*remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, tablePosts.frame.size.width-20, cell.imagePost.frame.size.height) ];
            [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
            [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [remote setImageWithURL:[NSURL URLWithString:usersDetailsObject.userCoverMedium] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
            remote.contentMode = UIViewContentModeScaleAspectFit;
            [cell.imagePost addSubview:remote]; */
            

            cell.imagePost.image = [ImageManager imageNamed:@"profile-placeholder.png"];
            [cell.imagePost loadImageFromURL:[[arrayWallPostData objectAtIndex:indexPath.row] userPostImgBig]];
            //cell.imagePost.contentMode =  UIViewContentModeScaleAspectFit;
            cell.imagePost.contentMode =  UIViewContentModeScaleToFill;

            
            cell.imagePost.userInteractionEnabled = YES;
            cell.imagePost.tag = indexPath.row;
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullScreenImage:)];
            [cell.imagePost addGestureRecognizer:tapRecognizer];
            
            
            cell.btnLike.tag = indexPath.row;
            [cell.btnLike addTarget:self action:@selector(btnLikeTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[arrayLikeFlag objectAtIndex:indexPath.row] isEqualToString:@"1"])
                [cell.btnLike setImage:[UIImage imageNamed:@"like-image"] forState:UIControlStateNormal];
            else
                [cell.btnLike setImage:[UIImage imageNamed:@"unlike-image"] forState:UIControlStateNormal];
            
            
            cell.btnComment.tag = indexPath.row;
            [cell.btnComment addTarget:self action:@selector(btnCommentTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[[arrayWallPostData objectAtIndex:indexPath.row] userPostImgBig] length] == 0)
            {
                cell.imagePost.hidden = YES;
                
                CGRect newFrame = cell.labelLikeComment.frame;
                newFrame.origin.y -= appDelegate.iPad ? iPadOffset : iPhoneOffset;
                cell.labelLikeComment.frame = newFrame;
                
                newFrame = cell.btnComment.frame;
                newFrame.origin.y -= appDelegate.iPad ? iPadOffset : iPhoneOffset;
                cell.btnComment.frame = newFrame;

                newFrame = cell.btnLike.frame;
                newFrame.origin.y -= appDelegate.iPad ? iPadOffset : iPhoneOffset;
                cell.btnLike.frame = newFrame;

                newFrame = cell.imageBg.frame;
                newFrame.size.height -= appDelegate.iPad ? iPadOffset : iPhoneOffset;
                cell.imageBg.frame = newFrame;

            }
            
            cell.backgroundColor = [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;

        }
        else
        {
//            cell.imagePostProfile.hidden = YES;
//            cell.labelPostDateTime.hidden = YES;
//            cell.btnLike.hidden = YES;
//            cell.btnComment.hidden = YES;
//            cell.labelLikeComment.hidden = YES;
//            
//            cell.labelPostTitle.text = @"NO POST";

            static NSString *cellIdentifier = @"CommentCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UILabel *labelNoPost=[[UILabel alloc] init];
            labelNoPost.TextAlignment = NSTextAlignmentCenter;
            labelNoPost.numberOfLines = 0;
            labelNoPost.backgroundColor = [UIColor clearColor];
            labelNoPost.textColor = [UIColor whiteColor];
            labelNoPost.font = [UIFont fontWithName:@"Helvetica" size:appDelegate.iPad ? 16 : 14];
            labelNoPost.text = @"Sorry, there are no post added, Be first to add post.";
            [cell.contentView addSubview:labelNoPost];

            labelNoPost.frame = CGRectMake(20, 5, tablePosts.frame.size.width - 40, 40);

            cell.backgroundColor = [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;

        }
        
    }
    else
    {
        static NSString *cellIdentifier = @"CommentCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        AsyncImageView *imageUser = [[AsyncImageView alloc]init];
        imageUser.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageUser loadImageFromURL:[[arrayCommentList objectAtIndex:indexPath.row] userProfileSmall]];
        [cell.contentView addSubview:imageUser];

        UILabel *labelName=[[UILabel alloc] init];
        labelName.TextAlignment = NSTextAlignmentLeft;
        labelName.numberOfLines = 0;
        labelName.backgroundColor = [UIColor clearColor];
        labelName.textColor = [UIColor blackColor];
        labelName.text = [[arrayCommentList objectAtIndex:indexPath.row] userName];
        [cell.contentView addSubview:labelName];

        
        UILabel *labelComment=[[UILabel alloc] init];
        labelComment.TextAlignment = NSTextAlignmentLeft;
        labelComment.numberOfLines = 0;
        labelComment.backgroundColor = [UIColor clearColor];
        labelComment.textColor = [UIColor blackColor];
        labelComment.text = [[arrayCommentList objectAtIndex:indexPath.row] userComment];
        [cell.contentView addSubview:labelComment];
        
        UILabel *labelCommentDate =[[UILabel alloc] init];
        labelCommentDate.TextAlignment = NSTextAlignmentLeft;
        labelCommentDate.numberOfLines = 0;
        labelCommentDate.backgroundColor = [UIColor clearColor];
        labelCommentDate.textColor = [UIColor lightGrayColor];
        labelCommentDate.text = [[arrayCommentList objectAtIndex:indexPath.row] userCommentDate];
        [cell.contentView addSubview:labelCommentDate];

        UILabel *labelCommentSep=[[UILabel alloc] init];
        labelCommentSep.TextAlignment = NSTextAlignmentLeft;
        labelCommentSep.numberOfLines = 0;
        labelCommentSep.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:labelCommentSep];

        
        int _height = [self heightForComment:(int)indexPath.row];

        if(appDelegate.iPad)
        {
            imageUser.frame = CGRectMake(20, 5, 60, 60);
            
            labelName.frame = CGRectMake(90, 5, tableCommentsList.frame.size.width - 110, 20);
            labelName.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];

            labelComment.font = iPadCommentFont;
            labelComment.frame = CGRectMake(90, 30, tableCommentsList.frame.size.width - 110, _height+1);

            labelCommentDate.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            labelCommentDate.frame = CGRectMake(90, 30 + _height + 5, tableCommentsList.frame.size.width - 110, 30);
            labelCommentDate.textAlignment = NSTextAlignmentRight;

            labelCommentSep.frame = CGRectMake(0, _height+30-1 + 35, tableCommentsList.frame.size.width , 1);
            
        }
        else
        {
            imageUser.frame = CGRectMake(20, 5, 50, 50);
            
            labelName.frame = CGRectMake(80, 5, tableCommentsList.frame.size.width - 100, 20);
            labelName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];

            labelComment.font = iPhoneCommentFont;
            labelComment.frame = CGRectMake(80, 30, tableCommentsList.frame.size.width - 100, _height+1);

            labelCommentDate.font = [UIFont fontWithName:@"Helvetica" size:13];
            labelCommentDate.frame = CGRectMake(80, 30 + _height + 5, tableCommentsList.frame.size.width - 100, 20);
            labelCommentDate.textAlignment = NSTextAlignmentRight;
            
            labelCommentSep.frame = CGRectMake(0, _height+30-1 + 30, tableCommentsList.frame.size.width , 1);

        }
        
        imageUser.layer.cornerRadius = imageUser.frame.size.height/2;
        imageUser.layer.masksToBounds = YES;

        
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tablePosts)
    {
        selectedPostIndex = (int)indexPath.row;
        
        arrayCommentList = [[NSMutableArray alloc]init];
        
        arrayCommentList = [[arrayWallPostData objectAtIndex:indexPath.row] arrayCommentsList];
        [tableCommentsList reloadData];
        
        [self.view addSubview:viewCommentList];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        textComment.leftView = paddingView;
        textComment.leftViewMode = UITextFieldViewModeAlways;
        
        
        viewCommentList.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        viewCommentList.alpha = 0;
        
        [UIView animateWithDuration:0.3 animations:^()
         {
             viewCommentList.alpha = 1;
             
             viewCommentList.layer.borderColor = [[UIColor whiteColor] CGColor];
             viewCommentList.layer.borderWidth = 2.0;
             
         }completion:^(BOOL finish)
         {
         }];

    }
    else
    {
        
    }
    
}

#pragma mark -----------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tablePosts && [arrayWallPostData count]>indexPath.row)
        return YES;
    else if(tableView==tableCommentsList && [arrayCommentList count]>indexPath.row)
        return YES;
    else
        return NO;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableCommentsList)
    {
        NSLog(@"-- Delete Comment Id: %@",[[arrayCommentList objectAtIndex:indexPath.row]userCommentId]);
        
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc] init];
        [userManager setUserManagerDelegate:self];
        
        [userManager deleteCommentWithCommentId:[[arrayCommentList objectAtIndex:indexPath.row]userCommentId] loginUserId:appDelegate.userDetails.userId];

    }
    else
    {
        NSLog(@"-- Delete Post Id: %@",[[arrayWallPostData objectAtIndex:indexPath.row]userPostId]);
        
        selectedPostIndex = (int)indexPath.row;
        
        //[tableFavourites beginUpdates];
        //[tableFavourites endUpdates];
        
        userManager = [[UserManager alloc] init];
        [userManager setUserManagerDelegate:self];
        
        [userManager deletePostWithPostId:[[arrayWallPostData objectAtIndex:indexPath.row]userPostId] loginUserId:appDelegate.userDetails.userId];
        
        /*
         CustomAlertView *alert;
         if(delete)
         {
         [arrayWallPostData removeObjectAtIndex:indexPath.row];
         
         alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Remove from favourites." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
         
         }
         else
         {
         alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Error while removing from favourites." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
         
         }
         
         [alert show];
         */
        //[tablePosts reloadData];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-- didEndEditingRowAtIndexPath --");
   // [tablePosts reloadData];
}




#pragma mark -----------------

- (void)showFullScreenImage:(UITapGestureRecognizer*)sender
{
    UIView *view = sender.view;
    NSLog(@"Image Tag :%d", (int)view.tag);//By tag, you can find out where you had typed.
    
    
    fullImageView = [[UIView alloc] init];
    fullImageView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    fullImageView.backgroundColor = [UIColor blackColor];
    fullImageView.alpha = 0;
    [self.view addSubview:fullImageView];
    
    UIImageView *imageFull = [[UIImageView alloc]init];
    imageFull.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    [fullImageView addSubview:imageFull];
    
    LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageFull.frame.size.width, imageFull.frame.size.height) ];
    [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
    [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [remote setImageWithURL:[NSURL URLWithString:[[arrayWallPostData objectAtIndex:(int)view.tag] userPostImgBig]] placeholderImage:[UIImage imageNamed:@"profile-placeholder"] cropImage:NO];
    remote.contentMode = UIViewContentModeScaleAspectFit;
    [imageFull addSubview:remote];
    

    imageFull.userInteractionEnabled = YES;
    UITapGestureRecognizer *removeImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeImage:)];
    [imageFull addGestureRecognizer:removeImage];
    
    [UIView animateWithDuration:0.3 animations:^()
     {
         fullImageView.alpha = 1.0;
     }];
    
}

- (void)removeImage:(UITapGestureRecognizer*)sender
{
     [UIView animateWithDuration:0.3 animations:^()
      {
          fullImageView.alpha = 0.0;

      }completion:^(BOOL finish)
      {
          if(finish)
              [fullImageView removeFromSuperview];
      }];
}

-(void)btnLikeTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Index :%d", (int)[sender tag]);
#endif
    
    selectedIndex = (int)[sender tag];
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        if([[arrayLikeFlag objectAtIndex:selectedIndex] isEqualToString:@"0"])
            [dataDict setObject:@"like" forKey:@"action"];
        else
            [dataDict setObject:@"unlike" forKey:@"action"];

        [dataDict setObject:[[arrayWallPostData objectAtIndex:selectedIndex] userPostId] forKey:@"post_id"];
        
        [userManager postLikeUnlikeOnServer:dataDict];
        
        // http://aegis-infotech.com/connectedyet/web/connectedyet/web/api/walllikes/{id}
//    parameter: '{"action":"like","post_id":65}'(action shuld be 'like' or unlike)
        

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
    
}


-(void)btnCommentTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Index :%d", (int)[sender tag]);
#endif
    
    selectedPostIndex = (int)[sender tag];
    
    [self.view addSubview:viewComment];
    
    if(appDelegate.iPad)
        viewComment.frame = CGRectMake((DEVICE_WIDTH-500)/2, 300, 500, 210);
    else
        viewComment.frame = CGRectMake(20, 100, DEVICE_WIDTH-40, 160);

    textComment.text = @"";
    [textComment becomeFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^()
     {
         viewComment.alpha = 1;
         
         viewComment.layer.borderColor = [[UIColor whiteColor] CGColor];
         viewComment.layer.borderWidth = 2.0;
         
     }completion:^(BOOL finish)
     {
     }];
    
}

-(IBAction)btnCommentCancelTapped:(id)sender
{
    
    [UIView animateWithDuration:0.3 animations:^()
    {
        viewComment.alpha = 0;
        
    }completion:^(BOOL finish)
    {
         [viewComment removeFromSuperview];

    }];
    
}

-(IBAction)btnCommentDoneTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Comment :%@", textComment.text);
#endif
    
    if(textComment.text.length != 0)
    {
        [self addCommnetOnPost:[[arrayWallPostData objectAtIndex:selectedPostIndex] userPostId]];
        
        [UIView animateWithDuration:0.3 animations:^()
         {
             viewComment.alpha = 0;
             
         }completion:^(BOOL finish)
         {
             [viewComment removeFromSuperview];
             
         }];
    }
    else
    {
        
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter comment" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
    }
   
}

-(void)addCommnetOnPost:(NSString *)_postId
{
//parameter: {"comment":"Testczxc ;)","post_id":65}
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        [dataDict setObject:textComment.text forKey:@"comment"];
        [dataDict setObject:_postId forKey:@"post_id"];
        
        [userManager postCommentOnServer:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}


-(IBAction)btnCommentListRemoveTapped:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^()
     {
         viewCommentList.alpha = 0;
         
     }completion:^(BOOL finish)
     {
         [viewCommentList removeFromSuperview];
         
     }];
}

-(IBAction)btnAddComment:(id)sender
{
    //[self btnCommentListRemoveTapped:nil];
    
    UIButton *btn = (UIButton *)sender;
    btn.tag = selectedPostIndex;
    [self btnCommentTapped:btn];
    
}

#pragma mark --- --- --- ----
#pragma mark --- ---  DELEGATE RETURN --- ---

-(void)successfullyPostComment:(NSString *)_message commentArray:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
    //[[arrayWallPostData objectAtIndex:indexPath.row] arrayCommentsList]

    UsersData *temp = [arrayWallPostData objectAtIndex:selectedPostIndex];
    temp.userPostTotalComments = [NSString stringWithFormat:@"%d",[[[arrayWallPostData objectAtIndex:selectedPostIndex] userPostTotalComments] intValue] + 1];

    
    
    temp.arrayCommentsList = _dataArray;
    arrayCommentList = _dataArray;
    
    [arrayWallPostData replaceObjectAtIndex:selectedPostIndex withObject:temp];
    [tablePosts reloadData];

    if([viewCommentList superview])
        [tableCommentsList reloadData];
    //else
    
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    imageWallPost = nil;
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    imageWallPost = nil;
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successfullyLikeUnlikePost:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

//[[arrayWallPostData objectAtIndex:selectedIndex] userPostTotalLikes]
    UsersData *temp = [arrayWallPostData objectAtIndex:selectedIndex];
    
    if([[arrayLikeFlag objectAtIndex:selectedIndex] isEqualToString:@"0"])
    {
        [arrayLikeFlag replaceObjectAtIndex:selectedIndex withObject:@"1"];
        temp.userPostTotalLikes = [NSString stringWithFormat:@"%d",[[[arrayWallPostData objectAtIndex:selectedIndex] userPostTotalLikes] intValue] + 1];
    }
    else
    {
        [arrayLikeFlag replaceObjectAtIndex:selectedIndex withObject:@"0"];
        temp.userPostTotalLikes = [NSString stringWithFormat:@"%d",[[[arrayWallPostData objectAtIndex:selectedIndex] userPostTotalLikes] intValue] - 1];

    }

    [arrayWallPostData replaceObjectAtIndex:selectedIndex withObject:temp];
    [tablePosts reloadData];
    
}


-(void)successWithCommentLikeDetails:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];

}


-(void)successfullyDeletePost:(NSString *)_message
{
    [appDelegate stopSpinner];

    [arrayWallPostData removeObjectAtIndex:selectedPostIndex];
    [tablePosts reloadData];
    
}

-(void)successfullyDeleteComment:(NSString *)_message commentArray:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];

    UsersData *temp = [arrayWallPostData objectAtIndex:selectedPostIndex];
    temp.userPostTotalComments = [NSString stringWithFormat:@"%d",[[[arrayWallPostData objectAtIndex:selectedPostIndex] userPostTotalComments] intValue] - 1];
    
    temp.arrayCommentsList = _dataArray;
    arrayCommentList = _dataArray;

    [arrayWallPostData replaceObjectAtIndex:selectedPostIndex withObject:temp];
    [tableCommentsList reloadData];

    [tablePosts reloadData];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    //[self getWallPostCommentsAndLikeForPostId:[[arrayWallPostData objectAtIndex:selectedPostIndex] userPostId]];
}


-(void)successfullyUploadWallPictureWithId:(NSString *)_imageId
{
    imageWallPost = nil;
    
    [appDelegate startSpinner];
    userManager = [[UserManager alloc]init];
    [userManager setUserManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:textWallPost.text forKey:@"message"];
    [dataDict setObject:_imageId forKey:@"image_id"];
    [dataDict setObject:@"" forKey:@"video_id"];
    [dataDict setObject:@"" forKey:@"y_link"];
    [dataDict setObject:appDelegate.userDetails.userId forKey:@"user_id"];

    [userManager uploadWallPost:dataDict];
    
}


-(void)successWithUploadWallPost:(NSString *)_message postUserData:(UsersData *)_userData
{
    [appDelegate stopSpinner];
    
    [arrayWallPostData insertObject:_userData atIndex:0];
    [arrayLikeFlag insertObject:@"0" atIndex:0];
    [tablePosts reloadData];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

@end

