//
//  SettingsViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constant.h"
#import "PrimaryLanguageView.h"
#import "ChangePasswordView.h"
#import "UsersCommonView.h"

#import "CustomAlertView.h"

@interface SettingsViewController ()
{
CometChat *cometChat;
}

@end
#define kCellHeightiPad 50
#define kCellHeightiPhone 44
@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arrayLanguages = [[NSMutableArray alloc]init];
   cometChat = [[CometChat alloc] init];
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
    [arrayLanguages addObject:@"Afrikaans"];
    [arrayLanguages addObject:@"Albanian"];
    [arrayLanguages addObject:@"Arabic"];
    [arrayLanguages addObject:@"Belarusian"];
    [arrayLanguages addObject:@"Bulgarian"];
    [arrayLanguages addObject:@"Catalan"];
    [arrayLanguages addObject:@"Chinese_Simpl"];
    [arrayLanguages addObject:@"Chinese_Trad"];
    [arrayLanguages addObject:@"Croatian"];
    [arrayLanguages addObject:@"Czech"];
    [arrayLanguages addObject:@"Danish"];
    [arrayLanguages addObject:@"Dutch"];
    [arrayLanguages addObject:@"English"];
    [arrayLanguages addObject:@"Estonian"];
    [arrayLanguages addObject:@"Filipino"];
    [arrayLanguages addObject:@"Finnish"];
    [arrayLanguages addObject:@"French"];
    [arrayLanguages addObject:@"Galician"];
    [arrayLanguages addObject:@"German"];
    [arrayLanguages addObject:@"Greek"];
    [arrayLanguages addObject:@"Haitian_Creole"];
    [arrayLanguages addObject:@"Hebrew"];
    [arrayLanguages addObject:@"Hindi"];
    [arrayLanguages addObject:@"Hungarian"];
    [arrayLanguages addObject:@"Icelandic"];
    [arrayLanguages addObject:@"Indonesian"];
    [arrayLanguages addObject:@"Irish"];
    [arrayLanguages addObject:@"Italian"];
    [arrayLanguages addObject:@"Japanese"];
    [arrayLanguages addObject:@"Korean"];
    [arrayLanguages addObject:@"Latvian"];
    [arrayLanguages addObject:@"Lithuanian"];
    [arrayLanguages addObject:@"Macedonian"];
    [arrayLanguages addObject:@"Malay"];
    [arrayLanguages addObject:@"Maltese"];
    [arrayLanguages addObject:@"Norwegian"];
    [arrayLanguages addObject:@"Persian"];
    [arrayLanguages addObject:@"Polish"];
    [arrayLanguages addObject:@"Portuguese"];
    [arrayLanguages addObject:@"Romanian"];
    [arrayLanguages addObject:@"Russian"];
    [arrayLanguages addObject:@"Serbian"];
    [arrayLanguages addObject:@"Slovak"];
    [arrayLanguages addObject:@"Slovenian"];
    [arrayLanguages addObject:@"Spanish"];
    [arrayLanguages addObject:@"Swahili"];
    [arrayLanguages addObject:@"Swedish"];
    [arrayLanguages addObject:@"Thai"];
    [arrayLanguages addObject:@"Turkish"];
    [arrayLanguages addObject:@"Ukrainian"];
    [arrayLanguages addObject:@"Vietnamese"];
    [arrayLanguages addObject:@"Welsh"];
    [arrayLanguages addObject:@"Yiddish"];

  
    [self setSelectLanguageView];

    
}

-(void)getPrimaryLanguages
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc] init];
    [loginManager setLoginManagerDelegate:self];
    
    [loginManager getAllLanguages];
    
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



-(IBAction)btnLanguageTapped:(id)sender
{
//    PrimaryLanguageView *priLan;
//    
//    if(appDelegate.iPad)
//        priLan = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView_iPad" bundle:nil];
//    else
//        priLan = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView" bundle:nil];
//    
////    priLan.strHeaderTitle = @"Unlike Users";
//    
//    [self.navigationController pushViewController:priLan animated:YES];
    
    if(btnSelectlanguage.selected == NO)
    {
        btnSelectlanguage.selected = YES;
        
        languageBg.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if(appDelegate.iPad)
                languageBg.frame = CGRectMake(0, 71, DEVICE_WIDTH, DEVICE_HEIGHT-72);
            else
                languageBg.frame = CGRectMake(0, 65, DEVICE_WIDTH, DEVICE_HEIGHT-65);
            
        }completion:^(BOOL finished){
            
            transparentView.alpha = 1;
            
        }];
        
    }
    else
    {
        [self hideLanguageView];
        
    }
    
}

-(void)setSelectLanguageView

{
    languageBg = [[UIView alloc]init];
    languageBg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:languageBg];
    
    
    transparentView = [[UIView alloc]init];
    transparentView.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:0.2];
    [languageBg addSubview:transparentView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideLanguageView)];
    tapGesture.numberOfTapsRequired = 1;
    [transparentView addGestureRecognizer:tapGesture];
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, 200, 0) style:UITableViewStylePlain];
    tablePrimaryLanguage.delegate = self;
    tablePrimaryLanguage.dataSource = self;
    tablePrimaryLanguage.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    tablePrimaryLanguage.separatorStyle = UITableViewCellSeparatorStyleNone;
    [languageBg addSubview:tablePrimaryLanguage];
    
    languageBg.hidden = YES;
    
    
    [self initialTableViewPosition];
    [tablePrimaryLanguage reloadData];

}




#pragma mark -----   -----   -----   -----
#pragma mark –---   UITableViewDataSource  ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayLanguages count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelegate.iPad)
        return kCellHeightiPad;
    else
        return kCellHeightiPhone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    
    UILabel *labelName=[[UILabel alloc] init];
    labelName.TextAlignment = NSTextAlignmentLeft;
    labelName.backgroundColor = [UIColor clearColor];
    labelName.textColor = [UIColor whiteColor]; //[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1];
    labelName.text = [arrayLanguages objectAtIndex:indexPath.row];
    [cell.contentView addSubview:labelName];
    
    
    UIImageView *imageSeperator = [[UIImageView alloc]init];
    imageSeperator.image = [UIImage imageNamed:@"divider-line.png"];
    [cell.contentView addSubview:imageSeperator];
    
    if(appDelegate.iPad)
    {
        labelName.frame = CGRectMake(20, 0, tableView.frame.size.width-30, kCellHeightiPad);
        labelName.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        
        imageSeperator.frame = CGRectMake(10, kCellHeightiPad-1, tableView.frame.size.width-20 , 1);
    }
    else
    {
        labelName.frame = CGRectMake(15, 0, tableView.frame.size.width-25, kCellHeightiPhone);
        labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        
        imageSeperator.frame = CGRectMake(5, kCellHeightiPhone-1, tableView.frame.size.width-10 , 1);
    }
    
    cell.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    if([[arrayLanguages objectAtIndex:indexPath.row]isEqualToString:[defaults valueForKey:@"ChatLanguage"]])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    textLanguage.text = [[arrayLanguages objectAtIndex:indexPath.row] languageName];
    NSInteger myInt = indexPath.row+1;
    
    //Set Translation language & enable translation of messages
     [cometChat setTranslationLanguage:myInt success:^(NSDictionary *response) {
     NSLog(@"SDK log : Set Translation Response %@",response);
//         [btnSelectlanguage setTitle:[NSString stringWithFormat:@"Change Chatting Language %@",[response valueForKey:@"Selected language"] ] forState:UIControlStateNormal];
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         
         [defaults setObject:[response valueForKey:@"Selected language"] forKey:@"ChatLanguage"];
         
         
     
     } failure:^(NSError *error) {
     
     NSLog(@"SDK log : Set Translation Error %@",error);
     }];
    
    
    [self hideLanguageView];
    
}


#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----



-(void)successWithLanguageDetails:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
#if DEBUG
    NSLog(@"-- Languages :%@",_dataArray);
#endif
    
    arrayLanguages = _dataArray;
    
    [tablePrimaryLanguage reloadData];
    
}

-(void)initialTableViewPosition
{
    transparentView.alpha = 0;
    
    if(appDelegate.iPad)
    {
        languageBg.frame = CGRectMake(DEVICE_WIDTH, 71, DEVICE_WIDTH, DEVICE_HEIGHT-72);
        
        transparentView.frame = CGRectMake(0, 0, DEVICE_WIDTH - 300, languageBg.frame.size.height);
        
        tablePrimaryLanguage.frame = CGRectMake(DEVICE_WIDTH - 300, 0, 300, languageBg.frame.size.height);
    }
    else
    {
        languageBg.frame = CGRectMake(DEVICE_WIDTH, 65, DEVICE_WIDTH, DEVICE_HEIGHT-65);
        
        transparentView.frame = CGRectMake(0, 0, DEVICE_WIDTH - 200, languageBg.frame.size.height);
        
        tablePrimaryLanguage.frame = CGRectMake(DEVICE_WIDTH-200, 0, 200, languageBg.frame.size.height);
    }
    
}

-(void)hideLanguageView
{
    
    btnSelectlanguage.selected = NO;
    
    transparentView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self initialTableViewPosition];
        
    }completion:^(BOOL finished){
        
        languageBg.hidden = YES;
        
    }];
    
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
