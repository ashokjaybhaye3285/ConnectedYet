//
//  MyProfileView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 14/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MyProfileView.h"

#import "EmailSignUpView.h"
#import "WallViewController.h"
#import "PhotosViewController.h"

#import "LoadremoteImages.h"
#import "CustomAlertView.h"

#import "ProfileViewController.h"

@interface MyProfileView ()

@end

@implementation MyProfileView

@synthesize isForEdit;

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
#if DEBUG
    NSLog(@"-- URL :%@", appDelegate.userDetails.userProfileBig);
#endif
   
    [self getUserDetails];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    /*
     LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageProfile.frame.size.width, imageProfile.frame.size.height) ];
     [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
     [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
     [remote setImageWithURL:[NSURL URLWithString:appDelegate.userDetails.userProfileMedium] placeholderImage:[UIImage imageNamed:@""]]; //profile-placeholder
     remote.contentMode = UIViewContentModeScaleAspectFit;
     [imageProfile addSubview:remote];
     
     */
    
    imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [imageProfile loadImageFromURL:appDelegate.userDetails.userProfileBig];

    if(appDelegate.iPad)
    {
    }
    else
    {
        imageInfo.frame = CGRectMake(0, 2, btnInfo.frame.size.width, 26);
        [btnInfo addSubview:imageInfo];
        
        imageWall.frame = CGRectMake(0, 2, btnWall.frame.size.width, 26);
        [btnWall addSubview:imageWall];
        
        imagePhotos.frame = CGRectMake(0, 2, btnPhotos.frame.size.width, 26);
        [btnPhotos addSubview:imagePhotos];
        
    }

}

-(void)getUserDetails
{
    [appDelegate startSpinner];
    
    userManager = [[UserManager alloc]init];
    [userManager setUserManagerDelegate:self];
    
    [userManager getUserDetails:appDelegate.userDetails.userId];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }

}



-(IBAction)btnSettingTapped:(id)sender
{
    
}


-(IBAction)btnInfoTapped:(id)sender
{
    /*
    EmailSignUpView *persinalDetails;
    
    if(appDelegate.iPad)
        persinalDetails = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView_iPad" bundle:nil];
    else
        persinalDetails = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView" bundle:nil];

    [persinalDetails isCommingForEditProfile:YES];
    [self.navigationController pushViewController:persinalDetails animated:YES];
    */
    
    ProfileViewController *profile;
    
    if(appDelegate.iPad)
        profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController_iPad" bundle:nil];
    else
        profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [profile initWithUsersDetails:userDetailsObject];
    
    [self.navigationController pushViewController:profile animated:YES];

}


-(IBAction)btnWallTapped:(id)sender
{
    WallViewController *wall;
    
    if(appDelegate.iPad)
        wall = [[WallViewController alloc]initWithNibName:@"WallViewController_iPad" bundle:nil];
    else
        wall = [[WallViewController alloc]initWithNibName:@"WallViewController" bundle:nil];
    [wall initWithUsersDetails:userDetailsObject];

    wall.isEditable = YES;
    [self.navigationController pushViewController:wall animated:YES];

}


-(IBAction)btnPhotosTapped:(id)sender
{
    PhotosViewController *photos;
    
    if(appDelegate.iPad)
        photos = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController_iPad" bundle:nil];
    else
        photos = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController" bundle:nil];
    [photos initWithUsersDetails:userDetailsObject galleryUserId:appDelegate.userDetails.userId];

    photos.isForEdit = YES;
    [self.navigationController pushViewController:photos animated:YES];

}

#pragma mark -----  ----- ----- -----

-(IBAction)btnVoiceNoteTappe:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* resourcePath = userDetailsObject.userAudio; //your url
        NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
        NSError *error;

        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Playing voice note..." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"Stop", nil) showsImage:NO];
        [alert show];
        
        [alert removeFromSuperview];

        
        alert.rightBlock = ^()
        {
            [player stop];
        };
        
        
        player = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
        player.numberOfLoops = 0;
        [player setDelegate:self];
        player.volume = 1.0f;
        [player prepareToPlay];
        
        if (player == nil)
            NSLog(@"%@", [error description]);
        else
            [player play];
        
    });
    //MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:resourcePath]];
    //[self presentMoviePlayerViewControllerAnimated:controller];
    
    
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Voice note finish" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithUserDetails:(UsersData *)_usersDataObject
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"-- Users Details :%@", _usersDataObject);
#endif
    
    userDetailsObject = _usersDataObject;
    
    if(userDetailsObject.userAudio.length != 0)
        btnVoiceNote.hidden = NO;
    else
        btnVoiceNote.hidden = YES;

}


@end
