//
//  PhotosViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "PhotosViewController.h"
#import "CustomAlertView.h"
#import "LoadremoteImages.h"

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface PhotosViewController ()

@end

@implementation PhotosViewController

@synthesize isForEdit;


-(void)initWithUsersDetails:(UsersData *)_usersDetails galleryUserId:(NSString *)_galleryUserId
{
    usersDetailsObject = _usersDetails;
    galleryUserId = _galleryUserId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    arrayPhotos = [[NSMutableArray alloc]init];
    
    arrayPhotos = usersDetailsObject.arrayUserGalleryPhoto;
    [self setDeleteFlags:arrayPhotos];

    if(isForEdit)
        btnDelete.hidden = NO;
    else
        btnDelete.hidden = YES;

    //[self setImageGallery];
    [self getGalleryImages];
    
}

-(void)setDeleteFlags:(NSMutableArray *)_dataArray
{
    arrayDeleteGalleryFlag = [[NSMutableArray alloc] init];
    
    for(int i =0; i< [_dataArray count]; i++)
        [arrayDeleteGalleryFlag addObject:@"0"];
    
}

-(void)getGalleryImages
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        [userManager getGalleryImagesForUserId:galleryUserId withLoginUserId:appDelegate.userDetails.userId];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

-(IBAction)btnDeleteTapped:(id)sender
{
    NSLog(@"-- Delete Flag :%@", arrayDeleteGalleryFlag);
    
    arrayDeleteImagesId = [[NSMutableArray alloc]init];

    for(int i =0; i<[arrayDeleteGalleryFlag count]; i++)
    {
        if([[arrayDeleteGalleryFlag objectAtIndex:i] isEqualToString:@"1"])
            [arrayDeleteImagesId addObject:[[arrayPhotos objectAtIndex:i] userProfileId]];
    }
    
    if([arrayDeleteImagesId count])
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Are you sure want to delete image ?" leftButtonTitle:@"YES" rightButtonTitle:@"NO" showsImage:NO];
        [alert show];
        
        alert.rightBlock =^{
            
            [self setDeleteFlags:arrayPhotos];
            [self setImageGallery];
            
        };
        
        alert.leftBlock =^{
            
            NSLog(@"-- Delete Flag ID :%@", arrayDeleteImagesId);

            [self deleteGalleryImages];

        };


    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please select image for delete" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
    }
    
}

-(void)deleteGalleryImages
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];

        [dataDict setObject:arrayDeleteImagesId forKey:@"gallery_ids"];
        
        [userManager deleteGalleryImagesForUserId:appDelegate.userDetails.userId withImageId:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}


-(void)setImageGallery
{
    int xPos;
    int space;
    int yPos = 0;
    
    int btnWidth;
    int btnHeight;
    
    for(id subview in scrollImages.subviews)
        [subview removeFromSuperview];

    if(isForEdit)
    {
        countPhotos = (int)[arrayPhotos count] + 1;
        btnSettings.hidden = NO;
        
        labelNoImages.hidden = YES;
    }
    else
    {
        countPhotos = (int)[arrayPhotos count];
        btnSettings.hidden = YES;
        
        if(countPhotos)
            labelNoImages.hidden = YES;
        else
            labelNoImages.hidden = NO;

    }

    if(appDelegate.iPad)
    {
        xPos = 20;
        space = xPos;
        btnWidth = (DEVICE_WIDTH-80)/3;
        btnHeight = btnWidth;
        
    }
    else
    {
        xPos = 10;
        space = xPos;
        btnWidth = (DEVICE_WIDTH-40)/3;
        btnHeight = btnWidth;

    }
    
    for(int i =0; i<countPhotos; i++)
    {
        UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUser.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        btnUser.tag = i;
       
        //btnUser.backgroundColor = [UIColor redColor];
        
        if(i < [arrayPhotos count])
        {
            NSLog(@"-- Profile Url :%@", [[arrayPhotos objectAtIndex:i] userProfileSmall]);
            
            [btnUser addTarget:self action:@selector(btnImageTapped:) forControlEvents:UIControlEventTouchUpInside];
            /*
            LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, btnUser.frame.size.width, btnUser.frame.size.height) ];
            [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
            [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [remote setImageWithURL:[NSURL URLWithString:[[arrayPhotos objectAtIndex:i] userProfileSmall]] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
            remote.contentMode = UIViewContentModeScaleAspectFit;
            */
            
            AsyncImageView *imageGalleryPhoto = [[AsyncImageView alloc]init];
            imageGalleryPhoto.frame = CGRectMake(0, 0, btnUser.frame.size.width, btnUser.frame.size.height);
            
            imageGalleryPhoto.image = [ImageManager imageNamed:@"profile-placeholder.png"];
            [imageGalleryPhoto loadImageFromURL:[[arrayPhotos objectAtIndex:i] userProfileSmall]];
            
            [btnUser addSubview:imageGalleryPhoto];
            
            
            if(isForEdit)
            {
                
                UIButton *btnDeleteGallery = [UIButton buttonWithType:UIButtonTypeCustom];
                btnDeleteGallery.frame = CGRectMake(btnUser.frame.size.width-27, 2, 25, 25);
                btnDeleteGallery.tag = i;
                btnDeleteGallery.titleLabel.textAlignment = NSTextAlignmentRight;
                btnDeleteGallery.backgroundColor = [UIColor clearColor];
                [btnDeleteGallery addTarget:self action:@selector(btnSetDeleteGalleryFlag:) forControlEvents:UIControlEventTouchUpInside];
                [btnUser addSubview:btnDeleteGallery];
                
                if([[arrayDeleteGalleryFlag objectAtIndex:i] isEqualToString:@"0"])
                    [btnDeleteGallery setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
                else
                    [btnDeleteGallery setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];

            }
            
        }
        else
        {
            [btnUser addTarget:self action:@selector(btnAddImageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [btnUser setBackgroundImage:[UIImage imageNamed:@"add_button"] forState:UIControlStateNormal];
            btnUser.contentMode = UIViewContentModeScaleAspectFit;
            
        }
        
        [scrollImages addSubview:btnUser];
        

        xPos+= btnWidth + space;
        
        if ((i+1)%3==0)
        {
            xPos = space;
            yPos+= btnHeight +space;
        }
    }
    
    scrollImages.contentSize = CGSizeMake(scrollImages.frame.size.width, yPos+btnHeight+space);

}


-(void)btnSetDeleteGalleryFlag:(id)sender
{
    if([[arrayDeleteGalleryFlag objectAtIndex:[sender tag]] isEqualToString:@"0"])
        [arrayDeleteGalleryFlag replaceObjectAtIndex:[sender tag] withObject:@"1"];
    else
        [arrayDeleteGalleryFlag replaceObjectAtIndex:[sender tag] withObject:@"0"];
    
    [self setImageGallery];
    
}


/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    NSLog(@"--- Touch Location XX :%f",touchLocation.x);
    NSLog(@"--- Touch Location YY :%f",touchLocation.y);
    
}
*/
#pragma mark --- ---- BUTTON CLICK METHOD ----- ---

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)btnImageTapped:(id)sender
{
    
    imageFullScreen = [[AsyncImageView alloc]init];
    imageFullScreen.backgroundColor = [UIColor blackColor];
    imageFullScreen.userInteractionEnabled = YES;
    imageFullScreen.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageFullScreen];
 
    imageFullScreen.alpha = 0;
    
    //imageFullScreen.frame = CGRectMake(DEVICE_WIDTH/2, (DEVICE_HEIGHT-64)/2, 0, 0);
    //imageFullScreen.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    imageFullScreen.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);

    /*
    LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageFullScreen.frame.size.width, imageFullScreen.frame.size.height) ];
    [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
    [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [remote setImageWithURL:[NSURL URLWithString:[[arrayPhotos objectAtIndex:[sender tag]] userProfileMedium]] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
    remote.contentMode = UIViewContentModeScaleAspectFit;
    [imageFullScreen addSubview:remote];
    */
    
    imageFullScreen.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [imageFullScreen loadImageFromURL:[[arrayPhotos objectAtIndex:[sender tag]] userProfileBig]];
    imageFullScreen.contentMode = UIViewContentModeScaleAspectFit;

    [UIView animateWithDuration:0.3 animations:^{

     //imageFullScreen.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);

        imageFullScreen.alpha = 1;

    }completion:^(BOOL finished){
        
    }];
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
    tapGR.numberOfTapsRequired = 1; // Limit to double-taps
    [imageFullScreen addGestureRecognizer:tapGR];
}


-(void)btnAddImageTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Add Picture"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take Photo", @"Choose from Gallery",
                                  nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];

    
//    alertProfilePic = [[UIAlertView alloc] initWithTitle:nil
//                                                 message:nil
//                                                delegate:self
//                                       cancelButtonTitle:@"Capture Photo"
//                                       otherButtonTitles: @"Add Existing Photo", @"Cancel", nil];
//    
//    [alertProfilePic show];
    

}


-(IBAction)btnSettingsTapped:(id)sender
{
    UIAlertView *alertSettings = [[UIAlertView alloc] initWithTitle:@"Settings Action"
            message:nil
            delegate:nil
            cancelButtonTitle:@"OK"
            otherButtonTitles: nil];
    
    [alertSettings show];

}



#pragma mark --- ---- ----- ----- ---


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapOnImage:(UITapGestureRecognizer *)tapGuesture
{
    [UIView animateWithDuration:0.3 animations:^{
        
        imageFullScreen.alpha = 0;
        //imageFullScreen.frame = CGRectMake(DEVICE_WIDTH/2, (DEVICE_HEIGHT-64)/2, 0, 0);
        
    }completion:^(BOOL finished){
        
        [imageFullScreen removeFromSuperview];

    }];
    
}

#pragma mark --- ---- ALERT VIEW DELEGATE METHOD ----- ---

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(alertView == alertProfilePic)
    {
        if(buttonIndex == 0)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:NULL];
                
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
        else if(buttonIndex == 1)
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
        else
        {
            [alertView removeFromSuperview];
        }
        
    }
    
}

#pragma mark --- ---- IMAGE PICKER DELEGATE METHOD ----- ---

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageGallery = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self uploadGalleryImages];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if(appDelegate.iPad)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:picker animated:YES completion:NULL];
        }];
    }
    else
    {
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}


-(void)uploadGalleryImages
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSData *_data = UIImageJPEGRepresentation (imageGallery, 1);
    
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
    [imgDict setObject:_data forKey:@"uploadfile"];

    [loginManager uploadGalleryImages:imgDict];  //POST TEST

}

#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

/*
-(void)successfullyUploadProfilePicture:(NSString *)_message
{
    [appDelegate stopSpinner];
    [self getGalleryImages];
    
}*/

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithGalleryImages:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];

    arrayPhotos = _dataArray;
    [self setDeleteFlags:arrayPhotos];
    [self setImageGallery];
    
}

-(void)successfullyUploadGalleryPicture:(NSString *)_message galleryImages:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

    arrayPhotos = _dataArray;
    [self setDeleteFlags:arrayPhotos];
    [self setImageGallery];

}

-(void)successWithDeleteGalleryImages:(NSString *)_message withGalleryImages:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    arrayPhotos = _dataArray;
    [self setDeleteFlags:arrayPhotos];
    [self setImageGallery];
    
}

@end
