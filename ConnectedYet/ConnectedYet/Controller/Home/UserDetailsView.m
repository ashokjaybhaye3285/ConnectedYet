//
//  UserDetailsView.m
//  ConnectedYet
//
//  Created by IMAC05 on 11/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "UserDetailsView.h"
#import "SearchViewController.h"

#import "ProfileViewController.h"
#import "WallViewController.h"
#import "PhotosViewController.h"
#import "ChatViewController.h"
#import "AddToContactView.h"

#import "CustomAlertView.h"


#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface UserDetailsView ()

@end

@implementation UserDetailsView

@synthesize userDetails;

-(id)init
{
    if ([super init])
    {
        //userDetails = _userDetails;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSString *_name;
    
    _name = [NSString stringWithFormat:@"%@ %@", userDetails.userFirstName, userDetails.userLastName];
   
    if([_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
        _name = [NSString stringWithFormat:@"%@", userDetails.userName];
    
    if([_name isEqualToString:@"(null) (null)"])
        _name = [NSString stringWithFormat:@"%@", userDetails.userName];

    labelTopHeader.text = _name;
    
    
    imageUser.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [imageUser loadImageFromURL:userDetails.userProfileMedium];
    imageUser.contentMode = UIViewContentModeScaleToFill;

    labelWelcomeMessage.text = [NSString stringWithFormat:@"Hi, I am %@", userDetails.userName];
    
    NSString *str = @"";
    if(userDetails.userCity.length != 0)
        str = [NSString stringWithFormat:@"%@, %@, %@, %@", userDetails.userAge, [appDelegate getGender:userDetails.userGender], userDetails.userCity, userDetails.userDistance];
    else
        str = [NSString stringWithFormat:@"%@, %@, %@", userDetails.userAge, [appDelegate getGender:userDetails.userGender], userDetails.userDistance];

    labelAgeSexAddDist.text = str;
    
    if(userDetails.userLastLogin.length !=0)
        labelOnlineTime.text = [NSString stringWithFormat:@"Online %@ hour ago", userDetails.userLastLogin];
    else
        labelOnlineTime.text = @"";
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabOnUserImage:)];
    tapGR.numberOfTapsRequired = 1;
    [imageUser addGestureRecognizer:tapGR];
    
    isImageClick = NO;
    bottomUserDetailsView.hidden = NO;
    
    
    [self getUserDetails];
   
}

-(void)getUserDetails
{
    [appDelegate startSpinner];
    
    userManager = [[UserManager alloc]init];
    [userManager setUserManagerDelegate:self];
    
    [userManager getUserDetails:userDetails.userId];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if(appDelegate.iPad)
    {
        
    }
    else
    {

        imageProfile.frame = CGRectMake(0, 4, btnProfile.frame.size.width, 26);
        [btnProfile addSubview:imageProfile];

        imageWall.frame = CGRectMake(0, 4, btnWall.frame.size.width, 26);
        [btnWall addSubview:imageWall];

        imagePhotos.frame = CGRectMake(0, 4, btnPhotos.frame.size.width, 26);
        [btnPhotos addSubview:imagePhotos];

        imageChats.frame = CGRectMake(0, 4, btnChats.frame.size.width, 26);
        [btnChats addSubview:imageChats];

        imageAddToContacts.frame = CGRectMake(0, 4, btnAddToContacts.frame.size.width, 26);
        [btnAddToContacts addSubview:imageAddToContacts];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabOnUserImage:(UITapGestureRecognizer *)tabGuesture
{
    if(isImageClick)
    {
        isImageClick = NO;
      
        bottomUserDetailsView.hidden = NO;
        bottomUserDetailsView.alpha = 0;
        //bottomUserDetailsView.frame = CGRectMake(0, DEVICE_HEIGHT-50, DEVICE_WIDTH, 0);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            //bottomUserDetailsView.frame = CGRectMake(0, DEVICE_HEIGHT-140, DEVICE_WIDTH, 90);
            bottomUserDetailsView.alpha = 1;

        }completion:^(BOOL finished){
            
            
        }];
    }
    else
    {
        isImageClick = YES;
        bottomUserDetailsView.alpha = 1;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            //bottomUserDetailsView.frame = CGRectMake(0, DEVICE_HEIGHT-50, DEVICE_WIDTH, 0);
            bottomUserDetailsView.alpha = 0;

        }completion:^(BOOL finished){
            
            bottomUserDetailsView.hidden = YES;

        }];
    }
}

-(IBAction)btnMenuTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
     
}

-(IBAction)btnSearchTapped:(id)sender
{
    SearchViewController *search;
    
    if(appDelegate.iPad)
        search = [[SearchViewController alloc]initWithNibName:@"SearchViewController_iPad" bundle:nil];
    else
        search = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];

    [self.navigationController pushViewController:search animated:YES];
    
}



-(IBAction)btnProfileTapped:(id)sender
{
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

    //wall.isForEdit = NO;
    [self.navigationController pushViewController:wall animated:YES];
    
}

-(IBAction)btnPhotosTapped:(id)sender
{
    PhotosViewController *photos;
    
    if(appDelegate.iPad)
        photos = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController_iPad" bundle:nil];
    else
        photos = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController" bundle:nil];
    [photos initWithUsersDetails:userDetailsObject galleryUserId:userDetails.userId];

    photos.isForEdit = NO;
    [self.navigationController pushViewController:photos animated:YES];
    
}

-(IBAction)btnChatsTapped:(id)sender
{
    
    UsersData *targetUser=[UsersData new];
    targetUser.userId=userDetails.userId;
    targetUser.userName=userDetails.userName;
    targetUser.userProfileSmall=userDetails.userProfileSmall;

    ChatViewController *chat;
    if(appDelegate.iPad)
        chat = [[ChatViewController alloc]initWithNibName:@"ChatViewController_iPad" bundle:nil];
    else
        chat = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    
    [chat setTargetUser:targetUser];

    [self.navigationController pushViewController:chat animated:YES];
    
}

-(IBAction)btnAddToContactsTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        [dataDict setValue:userDetails.userId forKey:@"friend_id"];
        [dataDict setValue:@"add" forKey:@"status"];

        [userManager addNewContact:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
  /*
   http://aegis-infotech.com/connectedyet/web/api/requests/{id}
   Method:POST
   parameter: {"friend_id": 139,"status":"liked"}'
   */
    
}


-(IBAction)btnVoiceNoteTappe:(id)sender
{
    /*
     NSURL *urlVoiceNote = [NSURL URLWithString:userDetailsObject.userAudio];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlVoiceNote error:nil];
    [player setDelegate:self];
    [player prepareToPlay];
    
    [player play];
    */
    
    NSString* resourcePath = userDetailsObject.userAudio; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    player = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    player.numberOfLoops = 0;
    [player setDelegate:self];
    player.volume = 1.0f;
    [player prepareToPlay];
    
    if (player == nil)
        NSLog(@"%@", [error description]);
    else
        [player play];
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
    
    if(_usersDataObject.userBiography.length !=0)
        labelWelcomeMessage.text = [NSString stringWithFormat:@"Hi, I am %@, %@", userDetailsObject.userName, userDetailsObject.userBiography];

    if(userDetailsObject.userAudio.length != 0)
        btnVoiceNote.hidden = NO;
    else
        btnVoiceNote.hidden = YES;
}

-(void)successWithAddContactRequest:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

@end
