//
//  SettingsViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constant.h"

#import "ChangePasswordView.h"
#import "UsersCommonView.h"

#import "CustomAlertView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //scrollView.backgroundColor = [UIColor redColor];
    
    if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 2;
        [self btnChangeInterestTapped:btn];
    }
    else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1;
        [self btnChangeInterestTapped:btn];

    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 0;
        [self btnChangeInterestTapped:btn];

    }
        

    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 770);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark ----  ----  BUTTON CLICK METHOD ----  -----

-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }

}


-(IBAction)btnChangePasswordTapped:(id)sender
{
    ChangePasswordView *changePass;
    
    if(appDelegate.iPad)
        changePass = [[ChangePasswordView alloc]initWithNibName:@"ChangePasswordView_iPad" bundle:nil];
    else
        changePass = [[ChangePasswordView alloc]initWithNibName:@"ChangePasswordView" bundle:nil];
    
    [self.navigationController pushViewController:changePass animated:YES];

}


-(IBAction)btnChangeInterestTapped:(id)sender
{
    if([sender tag] == 0)
    {
        [btnChatting setImage:[UIImage imageNamed:@"radio-btn-selected.png"] forState:UIControlStateNormal];
        [btnDating setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnMatrimony setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        
        selectedInterest = @"chatting";
        
    }
    else if([sender tag] == 1)
    {
        [btnChatting setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnDating setImage:[UIImage imageNamed:@"radio-btn-selected.png"] forState:UIControlStateNormal];
        [btnMatrimony setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];

        selectedInterest = @"datting";

    }
    else
    {
        [btnChatting setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnDating setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnMatrimony setImage:[UIImage imageNamed:@"radio-btn-selected.png"] forState:UIControlStateNormal];
     
        selectedInterest = @"matrimony";

    }
    
}

-(IBAction)btnBlockedUserTapped:(id)sender
{
    UsersCommonView *blockedUser;
    
    if(appDelegate.iPad)
        blockedUser = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
    else
        blockedUser = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
    
    blockedUser.strHeaderTitle = @"Blocked Users";

    [self.navigationController pushViewController:blockedUser animated:YES];
    
}

-(IBAction)btnUnlikeUsersTapped:(id)sender
{
    UsersCommonView *unlikeUsers;
    
    if(appDelegate.iPad)
        unlikeUsers = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
    else
        unlikeUsers = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
    
    unlikeUsers.strHeaderTitle = @"Unlike Users";
    
    [self.navigationController pushViewController:unlikeUsers animated:YES];
    
}


-(IBAction)btnChangeInterest:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        if([appDelegate.userDetails.userInterest isEqualToString:selectedInterest])
        {
            NSString *strMessage = [NSString stringWithFormat:@"Already your interest is %@.", selectedInterest];
                                    
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:strMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
        }
        else
        {
            [appDelegate startSpinner];
            
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
            [dataDict setObject:selectedInterest forKey:@"interest"];
            
            [loginManager addInterestAgainstUser:dataDict];
        }
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}

#pragma mark ----  ----  ----  -----

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

-(void)successfullyAddInterest:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    appDelegate.userDetails.userInterest = selectedInterest;
    [appDelegate saveCustomObject:appDelegate.userDetails];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    

}

@end
