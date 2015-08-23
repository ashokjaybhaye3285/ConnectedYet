//
//  EncountersViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 30/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "EncountersViewController.h"
#import "ChatViewController.h"
#import "Constant.h"
#import "UserDetailsView.h"

#import "LoadremoteImages.h"
#import "CustomAlertView.h"

#define kNameiPhoneFont [UIFont fontWithName:@"Helvetica-BOLD" size:18]
#define kNameiPadFont [UIFont fontWithName:@"Helvetica-BOLD" size:20]


@interface EncountersViewController ()

@end

@implementation EncountersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    arrayProfileImages = [[NSMutableArray alloc]init];
    
    if(!appDelegate.iPad)
    {
        imageChat.frame = CGRectMake(0, 8, btnChat.frame.size.width, 30);
        [btnChat addSubview:imageChat];
    }
   
    //[self setProfileImageView];
    //[self setBigImageView];
    
    [self getEncounterDetailsWithEncounterId:appDelegate.userDetails.userId];
    
}

-(void)getEncounterDetailsWithEncounterId:(NSString *)_encounterId
{
    ///http://aegis-infotech.com/connectedyet/web/api/encounters/{loginuserid}/lists/{currentencounterid}
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        [userManager getEncounterDetailsWihEncounterId:_encounterId];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setProfileImageView
{
    int xPos = 0;
    int yPos = 0;
    
    int btnWidth;
    int btnHeight;
    int space;
    
    btnWidth = DEVICE_WIDTH;
    btnHeight =DEVICE_HEIGHT - 64;
    space = 0;

    for(id subview in scrollProfilePicture.subviews)
        [subview removeFromSuperview];
    
    for(int i =0; i<[arrayProfileImages count]; i++)
    {
#if DEBUG
        NSLog(@"-- URL :%@",[[arrayProfileImages objectAtIndex:i] userProfileBig]);
#endif
        
        /*AsyncImageView *imageView = [[AsyncImageView alloc]init];
        imageView.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        imageView.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageView loadImageFromURL:[[arrayProfileImages objectAtIndex:i] userProfileBig]];
        [scrollProfilePicture addSubview:imageView];
        */
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);

        LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height) ];
        [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
        [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [remote setImageWithURL:[NSURL URLWithString:[[arrayProfileImages objectAtIndex:i] userProfileBig]] placeholderImage:[UIImage imageNamed:@"profile-placeholder.png"] cropImage:YES];//profile-placeholder
        remote.contentMode = UIViewContentModeScaleAspectFit;
        [imageView addSubview:remote];
        [scrollProfilePicture addSubview:imageView];
        
        
        xPos+=scrollBigImages.frame.size.width;
        
        xPos+= btnWidth + space;
        
    }
    
    scrollProfilePicture.contentSize = CGSizeMake([arrayProfileImages count]*(btnWidth), scrollProfilePicture.frame.size.height);
    
    if([arrayProfileImages count] == 1)
    {
        btnNext.hidden = YES;
        btnPrevious.hidden = YES;
        
    }
    
}


-(void)setBigImageView
{
    int xPos = 0;
    int yPos = 0;
    
    for(int i =0; i<[arrayProfileImages count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(xPos, yPos, scrollBigImages.frame.size.width, scrollBigImages.frame.size.height);
        
        imageView.image = [UIImage imageNamed:@"product"];
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [scrollBigImages addSubview:imageView];
        
        xPos+=scrollBigImages.frame.size.width;
        
    }
    
    scrollBigImages.contentSize = CGSizeMake(scrollBigImages.frame.size.width*[arrayProfileImages count], scrollBigImages.frame.size.height);
    
}


-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    
    if (sideMenuController) {
        
        [sideMenuController openMenu];
        
    }
    

}


-(void)btnProfilePictureTapped:(id)sender
{
    
}

-(IBAction)btnChatTapped:(id)sender
{

    UsersData *targetUser=[UsersData new];
    
    targetUser.userId = usersDataObeject.userId;
    targetUser.userName = usersDataObeject.userName;
    targetUser.userProfileSmall = usersDataObeject.userProfileSmall;

    ChatViewController *chat;
    if(appDelegate.iPad)
        chat = [[ChatViewController alloc]initWithNibName:@"ChatViewController_iPad" bundle:nil];
    else
        chat = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    
    [chat setTargetUser:targetUser];

    [self.navigationController pushViewController:chat animated:YES];

}

-(IBAction)btnAddToContactTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        [dataDict setValue:usersDataObeject.userId forKey:@"friend_id"];
        [dataDict setValue:@"add" forKey:@"status"];
        
        [userManager addNewContact:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}


-(IBAction)btnNextTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Image Count :%d", (int)[arrayProfileImages count]);
#endif
    
    ++currentIndex;
    
    btnNext.hidden = NO;
    btnPrevious.hidden = NO;

    if(currentIndex <[arrayProfileImages count])
    {
        [scrollProfilePicture setContentOffset:CGPointMake(currentIndex*DEVICE_WIDTH, 0) animated:YES];
      
        NSLog(@"-- currentIndex :%d", currentIndex);

        if(currentIndex == ([arrayProfileImages count]-1))
            btnNext.hidden = YES;
        
    }

    
}


-(IBAction)btnPreviousTapped:(id)sender
{
    --currentIndex;
    NSLog(@"-- currentIndex :%d", currentIndex);

    btnNext.hidden = NO;
    btnPrevious.hidden = NO;

    if(currentIndex >= 0 )
    {
        [scrollProfilePicture setContentOffset:CGPointMake(currentIndex*DEVICE_WIDTH, 0) animated:YES];
        
        if(currentIndex == 0)
            btnPrevious.hidden = YES;

    }
   
}


-(IBAction)btnDeleteTapped:(id)sender
{

    [self getEncounterDetailsWithEncounterId:usersDataObeject.userId];
    
}


-(IBAction)btnViewTapped:(id)sender
{
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = usersDataObeject;
    [self.navigationController pushViewController:details animated:YES];

}


-(IBAction)btnFavouriteTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        [dataDict setValue:usersDataObeject.userId forKey:@"friend_id"];
        [dataDict setValue:@"favourite" forKey:@"status"];
        
        [userManager addNewContact:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

#pragma mark ----  -----  -----

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollProfilePicture.frame);
    NSUInteger page = floor((scrollProfilePicture.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    currentIndex = (int)page;
    
    if(currentIndex == 0)
    {
        btnPrevious.hidden = YES;
        btnNext.hidden = NO;
    }
    else if(currentIndex == ([arrayProfileImages count]-1))
    {
        btnNext.hidden = YES;
        btnPrevious.hidden = NO;
    }
    else
    {
        btnNext.hidden = NO;
        btnPrevious.hidden = NO;

    }


}


#pragma mark ----  -----  -----
#pragma mark ----  DELEGATE RETURN METHOD  -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle: NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle: NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithEncounterDetails:(UsersData *)_usersDataObject
{
    [appDelegate stopSpinner];

    usersDataObeject = _usersDataObject;
    arrayProfileImages = _usersDataObject.arrayUserGalleryPhoto;
    
    if([arrayProfileImages count])
        [self setProfileImageView];
    
    
    labelName.text = usersDataObeject.userName;
    labelName.font = appDelegate.iPad ? kNameiPhoneFont : kNameiPadFont;
    
    labelAddress.text = [NSString stringWithFormat:@"%@, %@, %@", usersDataObeject.userAge, [appDelegate getGender:usersDataObeject.userGender], usersDataObeject.userCity];

    CGRect newFrame = labelAddress.frame;
    newFrame.origin.x = labelName.frame.origin.x + [appDelegate widthOfString:usersDataObeject.userName withFont:appDelegate.iPad ? kNameiPhoneFont : kNameiPadFont] + 10;
    labelAddress.frame = newFrame;
    
}

-(void)successWithAddContactRequest:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    [self btnDeleteTapped:nil];
    
    //CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle: NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    //[alert show];
    
}


@end
