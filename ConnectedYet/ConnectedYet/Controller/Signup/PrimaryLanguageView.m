//
//  PrimaryLanguageView.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 27/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "PrimaryLanguageView.h"
#import "InviteContactsView.h"

#import "Constant.h"
#import "CustomAlertView.h"


#define kCellHeightiPad 50
#define kCellHeightiPhone 44

@interface PrimaryLanguageView ()

@end

@implementation PrimaryLanguageView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textLanguage.leftView = paddingView;
    textLanguage.leftViewMode = UITextFieldViewModeAlways;
    
    arrayLanguages = [[NSMutableArray alloc]init];
       
    [self setSelectLanguageView];
    
    
    NSDictionary *thirdAttributes = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:225.0/255.0 alpha:1]};
    
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:@"Note: Your information will be secure with us. We will not disclose your information with any medium."];
    
    [myString setAttributes:thirdAttributes range:NSMakeRange(0, 5)];
    labelDescription.attributedText = myString;
    
    [self getPrimaryLanguages];
    
}

-(void)getPrimaryLanguages
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc] init];
    [loginManager setLoginManagerDelegate:self];
    
    [loginManager getAllLanguages];
    
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textLanguage.frame.size.width, 0) style:UITableViewStylePlain];
    tablePrimaryLanguage.delegate = self;
    tablePrimaryLanguage.dataSource = self;
    tablePrimaryLanguage.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    tablePrimaryLanguage.separatorStyle = UITableViewCellSeparatorStyleNone;
        [languageBg addSubview:tablePrimaryLanguage];
    
    languageBg.hidden = YES;
    
    
    [self initialTableViewPosition];
    
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

    btnSelectDate.selected = NO;
    
    transparentView.alpha = 0;

    [UIView animateWithDuration:0.3 animations:^{
        
        [self initialTableViewPosition];
        
    }completion:^(BOOL finished){
        
        languageBg.hidden = YES;
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnSelectLanguageTapped:(id)sender
{
    if(btnSelectDate.selected == NO)
    {
        btnSelectDate.selected = YES;

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


-(IBAction)btnNextTapped:(id)sender
{
    if(textLanguage.text.length != 0)
    {
        appDelegate.tempObject.userLanguage = textLanguage.text;
        
        InviteContactsView *invite;
        
        if(appDelegate.iPad)
            invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView_iPad" bundle:nil];
        else
            invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView" bundle:nil];
        
        invite.isForEdit = NO;
        [self.navigationController pushViewController:invite animated:YES];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please select primary language" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
    }
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self btnSelectLanguageTapped:nil];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
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
    labelName.text = [[arrayLanguages objectAtIndex:indexPath.row] languageName];
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
    return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textLanguage.text = [[arrayLanguages objectAtIndex:indexPath.row] languageName];
    selectedLanguageCode = [[arrayLanguages objectAtIndex:indexPath.row] languageCode];
    
    [self hideLanguageView];

}


#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}


-(void)successWithLanguageDetails:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];
#if DEBUG
    NSLog(@"-- Languages :%@",_dataArray);
#endif
    
    arrayLanguages = _dataArray;
    
    [tablePrimaryLanguage reloadData];
    
}

@end
