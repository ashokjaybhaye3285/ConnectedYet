//
//  UsersCommonView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "UsersCommonView.h"
#import "UserDetailsView.h"
#import "Constant.h"

#import "UsersCommonCell.h"
#import "CustomAlertView.h"

#import "LoadremoteImages.h"

#define kCellHeight 90
#define kCellHeightiPad 110

#define _favourite @"Favourite"
#define _likeMe @"Liked Me"
#define _myContact @"My Contact"
#define _contactRequest @"Contact Request"
#define _myMatch @"My Match"

#define _mySearch @"Search Result"
#define _blockedUser @"Blocked Users"
#define _unlikeUser @"Unlike Users"

@interface UsersCommonView ()

@end

@implementation UsersCommonView

@synthesize strHeaderTitle;
@synthesize arrayUserDetails;


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
 
    labelTopHeader.text = strHeaderTitle;
    
    if([strHeaderTitle isEqualToString:_contactRequest] || [strHeaderTitle isEqualToString:_myMatch] || [strHeaderTitle isEqualToString:_mySearch] || [strHeaderTitle isEqualToString:_blockedUser]|| [strHeaderTitle isEqualToString:_unlikeUser])
        btnGridView.hidden = YES;
    else
        btnGridView.hidden = NO;
    
    if([strHeaderTitle isEqualToString:_mySearch])
    {
        NSLog(@"-- Search Users :%@", arrayUserDetails);
        [tableUsers reloadData];

    }
    else
    {
        if([strHeaderTitle isEqualToString:_myMatch])
            [self getMyMatchListDetails];
        else
        {
            [self getUsersListDetails];
            
            __weak UsersCommonView *weakSelf = self;
            tableUsers.pullToRefreshView.arrowColor = [UIColor whiteColor];
            [tableUsers addPullToRefreshWithActionHandler:^{
                
                [weakSelf getUsersListDetails];
                
            }];
        }
    }
    
}


-(void)getMyMatchListDetails
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        [userManager getMyMatchListDetails];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
}

-(void)getUsersListDetails
{
    //('unblocked','blocked','liked','unfavourite','unlike','favourite',’add’,reject,’confirm’,’unfriend’)
    //(all,f,m,online,global,visitors,favourite,liked,blocked,pending,mycontact)

    if([MYSBaseProxy isNetworkAvailable])
    {
        labelRecordNotFound.hidden = YES;

        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        if([strHeaderTitle isEqualToString:_favourite])
            [userManager getAllUsersDetails:@"favourite"];
        else if([strHeaderTitle isEqualToString:_likeMe])
            [userManager getAllUsersDetails:@"liked"];
        else if([strHeaderTitle isEqualToString:_myContact])
            [userManager getAllUsersDetails:@"mycontact"];
        else  if([strHeaderTitle isEqualToString:_contactRequest])
            [userManager getAllUsersDetails:@"pending"];
        else  if([strHeaderTitle isEqualToString:_blockedUser])
            [userManager getAllUsersDetails:@"blocked"];
        else  if([strHeaderTitle isEqualToString:_unlikeUser])
            [userManager getAllUsersDetails:@"unlike"];
        else
            [userManager getAllUsersDetails:@"all"];

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

#pragma mark –--  Button Click Methods ----

-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    
    if (sideMenuController) {
        
        [sideMenuController openMenu];
        
    }
    

}

#pragma mark –--  -----  ----

#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayUserDetails count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelegate.iPad)
        return kCellHeightiPad;
    else
        return kCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HomeCell";
    
    UsersCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *xib;
    
    if(appDelegate.iPad)
        xib = [[NSBundle mainBundle] loadNibNamed:@"UsersCommonCell_iPad" owner:self options:nil];
    else
        xib = [[NSBundle mainBundle] loadNibNamed:@"UsersCommonCell" owner:self options:nil];
    
    cell = [xib objectAtIndex:0];
    
    UsersData *usersDataObject = [arrayUserDetails objectAtIndex:indexPath.row];
    
    //if([labelTopHeader.text isEqualToString:@"Favourite"]) TODO: Hide Star
      //  cell.imageFavourite.hidden = NO;
    //else
        cell.imageFavourite.hidden = YES;

   
    cell.imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [cell.imageProfile loadImageFromURL:usersDataObject.userProfileMedium];

    
    if(indexPath.row%2 == 0)
        cell.imageStatus.image = [UIImage imageNamed:@"status-offline"];
    else if(indexPath.row%3 == 0)
        cell.imageStatus.image = [UIImage imageNamed:@"status-online"];
    else
        cell.imageStatus.image = [UIImage imageNamed:@"status-away"];
    
    cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.size.height/2;
    cell.imageProfile.layer.masksToBounds = YES;
    cell.imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    cell.imageProfile.layer.borderWidth = 2.5;
    
    cell.labelName.text = [NSString stringWithFormat:@"%@, %@",usersDataObject.userName, usersDataObject.userAge];
    //cell.labelAge.text = @"21, Female";
    cell.labelAddress.text = [NSString stringWithFormat:@"%@, %@, %@",usersDataObject.userCity, usersDataObject.userState, usersDataObject.userDistance];
    //cell.labelDistance.text = @"10 km";
    
    if([usersDataObject.userGender isEqualToString:@"m"])
        cell.imageSex.image = [UIImage imageNamed:@"male-sex"];
    else
        cell.imageSex.image = [UIImage imageNamed:@"female-sex"];

    if([strHeaderTitle isEqualToString:_myMatch])
    {
        cell.labelMyMatch.hidden = NO;
        cell.labelMyMatch.text = [NSString stringWithFormat:@"%@ Match", usersDataObject.userMatch];
        
        if(!appDelegate.iPad)
        {
            CGRect newFrame = cell.labelName.frame;
            newFrame.origin.y = newFrame.origin.y -6;
            cell.labelName.frame = newFrame;
            
            newFrame = cell.labelAddress.frame;
            newFrame.origin.y = newFrame.origin.y -6;
            cell.labelAddress.frame = newFrame;
            
        }

    }
    else
    {
        cell.labelMyMatch.hidden = YES;
    }
    
    if([strHeaderTitle isEqualToString:_contactRequest])
    {
        cell.btnAccept.hidden = NO;
        cell.btnReject.hidden = NO;

        cell.btnAccept.tag = indexPath.row;
        [cell.btnAccept addTarget:self action:@selector(btnAcceptTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnReject.tag = indexPath.row;
        [cell.btnReject addTarget:self action:@selector(btnRejectTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if(!appDelegate.iPad)
        {
            CGRect newFrame = cell.labelName.frame;
            newFrame.origin.y = newFrame.origin.y -16;
            cell.labelName.frame = newFrame;
            
            newFrame = cell.labelAddress.frame;
            newFrame.origin.y = newFrame.origin.y -16;
            cell.labelAddress.frame = newFrame;

        }
       
    }
    else
    {
        cell.btnAccept.hidden = YES;
        cell.btnReject.hidden = YES;

    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
    
}

-(IBAction)btnGridViewTapped:(id)sender
{
    
    if(btnGridView.selected ==NO)
    {
        btnGridView.selected = YES;
        
        [btnGridView setImage:[UIImage imageNamed:@"list-icon"] forState:UIControlStateNormal];
        
        if(![scrollGridView superview])
        {
            scrollGridView = [[UIScrollView alloc]init];
            scrollGridView.frame = tableUsers.frame;
            [self.view addSubview:scrollGridView];
            
            [self setGridView];
            
        }
        
        scrollGridView.alpha = 0;
        
        [UIView animateWithDuration:0.6 animations:^{
            
            tableUsers.alpha = 0;
            scrollGridView.alpha = 1;
            
        }completion:^(BOOL finished){
            
        }];
    }
    else
    {
        btnGridView.selected = NO;
        [btnGridView setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.6 animations:^{
            
            tableUsers.alpha = 1;
            scrollGridView.alpha = 0;
            
        }completion:^(BOOL finished){
            
        }];
        
    }
    
}


-(void)setGridView
{
    int xPos = 0;
    int yPos = 0;
    
    int space;
    int btnWidth;
    int btnHeight;
    
    if(appDelegate.iPad)
    {
        btnWidth = (DEVICE_WIDTH-100)/4;
        btnHeight = btnWidth + 50;
        space = 20;
        xPos = space;
        
    }
    else
    {
        btnWidth = (DEVICE_WIDTH-50)/4;
        btnHeight = btnWidth + 40;
        space = 10;
        xPos = space;
    }
    
    for(int i =0; i<[arrayUserDetails count]; i++)
    {
        UsersData *usersDataObject = [[UsersData alloc] init];
        usersDataObject = [arrayUserDetails objectAtIndex:i];
        
        UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUser.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        btnUser.tag = i;
        [btnUser addTarget:self action:@selector(btnUserTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollGridView addSubview:btnUser];
        
        AsyncImageView *imageUser = [[AsyncImageView alloc]init];
        imageUser.frame = CGRectMake(0, 0, btnWidth, btnWidth);
        imageUser.layer.cornerRadius = btnWidth/2;
        imageUser.layer.masksToBounds = btnWidth/2;
        imageUser.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
        imageUser.layer.borderWidth = 2.5;
        
        imageUser.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageUser loadImageFromURL:usersDataObject.userProfileMedium];
        
        [btnUser addSubview:imageUser];
        
        /*LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageUser.frame.size.width, imageUser.frame.size.height) ];
        //[remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
        //[remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [remote setImageWithURL:[NSURL URLWithString:usersDataObject.userProfileMedium] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
        remote.contentMode = UIViewContentModeScaleAspectFit;
        [imageUser addSubview:remote];
        */
        
        
        UIImageView *imageStatus = [[UIImageView alloc]init];
        if(i%2==0)
            imageStatus.image = [UIImage imageNamed:@"status-offline"];
        else if(i%3==0)
            imageStatus.image = [UIImage imageNamed:@"status-online"];
        else
            imageStatus.image = [UIImage imageNamed:@"status-away"];
        
        [btnUser addSubview:imageStatus];
        
        UIImageView *imageSex = [[UIImageView alloc]init];
        
        if([usersDataObject.userGender isEqualToString:@"m"])
            imageSex.image = [UIImage imageNamed:@"male-sex"];
        else
            imageSex.image = [UIImage imageNamed:@"female-sex"];

        [btnUser addSubview:imageSex];
        
        UILabel *labelName = [[UILabel alloc]init];
        labelName.text = [NSString stringWithFormat:@"%@", usersDataObject.userName];
        labelName.textAlignment = NSTextAlignmentCenter;
        labelName.textColor = [UIColor whiteColor];
        labelName.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelName];
        
        UILabel *labelDistance = [[UILabel alloc]init];
        
        labelDistance.text = [NSString stringWithFormat:@"%@, %@", usersDataObject.userAge, usersDataObject.userDistance];
        labelDistance.textAlignment = NSTextAlignmentCenter;
        labelDistance.textColor = [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:255.0/255.0 alpha:1];
        labelDistance.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelDistance];
        
        if(appDelegate.iPad)
        {
            imageStatus.frame = CGRectMake(btnWidth-35, 15, 20, 20);
            imageSex.frame = CGRectMake(btnWidth-35, btnHeight-25-50, 25, 25);
            
            labelName.frame = CGRectMake(5, btnHeight-50, btnWidth-10, 30);
            labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:16];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:14];
            
        }
        else
        {
            imageStatus.frame = CGRectMake(btnWidth-20, 0, 10, 10);
            imageSex.frame = CGRectMake(btnWidth-20, btnHeight-15-40, 15, 15);
            
            labelName.frame = CGRectMake(5, btnHeight-40, btnWidth-10, 20);
            labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:12];
            
        }
        
        xPos+= btnWidth + space;
        
        if ((i+1)%4==0)
        {
            xPos = space;
            yPos+= btnHeight +space;
        }
    }
    
    scrollGridView.contentSize = CGSizeMake(scrollGridView.frame.size.width, yPos);
    
}

-(void)btnUserTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Tag :%d", (int)[sender tag]);
#endif
    
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)btnAcceptTapped:(id)sender
{
#if DEBUG
    NSLog(@"---  Accept ---");
#endif
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        UsersData *usersDataObject = [arrayUserDetails objectAtIndex:[sender tag]];
        
        [dataDict setObject:usersDataObject.userId forKey:@"friend_id"];
        [dataDict setObject:@"confirm" forKey:@"status"]; //reject

        [userManager setFriendRequestStatus:dataDict];
        
    
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}


-(void)btnRejectTapped:(id)sender
{
#if DEBUG
    NSLog(@"---  Reject ---");
#endif
    
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


-(void)successWithUserListDetails:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"-- User List :%@",_dataArray);
#endif
 
    [tableUsers.pullToRefreshView stopAnimating];  //TODO: Stop pull to refresh

    arrayUserDetails = [[NSMutableArray alloc]init];

    arrayUserDetails = _dataArray;
    
    if([arrayUserDetails count])
    {
        labelRecordNotFound.hidden = YES;
        [tableUsers reloadData];
        
    }
    else
    {
        labelRecordNotFound.hidden = NO;
    }
    
}

-(void)successWithFriendRequestStatus:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

    [self getUsersListDetails];
    
}


-(void)successWithMyMatchList:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"-- My Match User List :%@",_dataArray);
#endif
    
    arrayUserDetails = [[NSMutableArray alloc]init];
    
    arrayUserDetails = _dataArray;
    
    if([arrayUserDetails count])
    {
        labelRecordNotFound.hidden = YES;
        [tableUsers reloadData];
        
    }
    else
    {
        labelRecordNotFound.hidden = NO;
    }
    
}

@end
