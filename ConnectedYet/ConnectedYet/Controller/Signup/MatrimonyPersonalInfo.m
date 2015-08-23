//
//  MatrimonyPersonalInfo.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyPersonalInfo.h"
#import "Constant.h"

#import "MatrimonyAboutYourself.h"
#import "CustomAlertView.h"


#define kCellHeightiPad 50
#define kCellHeightiPhone 44


@interface MatrimonyPersonalInfo ()

@end

@implementation MatrimonyPersonalInfo

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(appDelegate.iPad)
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 650);
    else
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 530);

    database = [[DatabaseConnection alloc] init];
    appDelegate.arrayCountryData = [database getAllCountries];
    
    
    [self getDropDownValues];
    [self setSelectLanguageView];

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textFirstName.leftView = paddingView;
    textFirstName.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textLastName.leftView = paddingView;
    textLastName.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCast.leftView = paddingView;
    textCast.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textReligion.leftView = paddingView;
    textReligion.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textMotherTongue.leftView = paddingView;
    textMotherTongue.leftViewMode = UITextFieldViewModeAlways;
    
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textStateLivingIn.leftView = paddingView;
    textStateLivingIn.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCityLiving.leftView = paddingView;
    textCityLiving.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCountry.leftView = paddingView;
    textCountry.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textMaritalStatus.leftView = paddingView;
    textMaritalStatus.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHeight.leftView = paddingView;
    textHeight.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textBodyType.leftView = paddingView;
    textBodyType.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSkinTone.leftView = paddingView;
    textSkinTone.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textDiet.leftView = paddingView;
    textDiet.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSmoke.leftView = paddingView;
    textSmoke.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textDrink.leftView = paddingView;
    textDrink.leftViewMode = UITextFieldViewModeAlways;
    
    
}


-(void)getDropDownValues
{
    //[appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    [loginManager getDropDownValuesDetails];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnNextTapped:(id)sender
{
    textFirstName.text = [textFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    textLastName.text = [textLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    textCountry.text = [textCountry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        if(textFirstName.text.length != 0)
        {
            if(textLastName.text.length != 0)
            {
                if(textCountry.text.length != 0)
                {
                    [self setMatrimonyPersonalInformation];

                }
                else
                {
                    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"select_country", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                    [alert show];
                }

            }
            else
            {
                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"last_name", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                [alert show];
            }

        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"first_name", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
    /*
    MatrimonyAboutYourself *matrimonyAbout;
    
    if(appDelegate.iPad)
        matrimonyAbout = [[MatrimonyAboutYourself alloc]initWithNibName:@"MatrimonyAboutYourself_iPad" bundle:nil];
    else
        matrimonyAbout = [[MatrimonyAboutYourself alloc]initWithNibName:@"MatrimonyAboutYourself" bundle:nil];

    [self.navigationController pushViewController:matrimonyAbout animated:YES];
    */
}


-(void)setMatrimonyPersonalInformation
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
    
    [dataDict setObject:textFirstName.text forKey:@"firstname"];
    [dataDict setObject:textLastName.text forKey:@"lastname"];

    if(selectedCountryCode.length != 0)
        [dataDict setObject:selectedCountryCode forKey:@"country"];
    else
        [dataDict setObject:@"" forKey:@"country"];

    [dataDict setObject:textStateLivingIn.text forKey:@"state"];
    [dataDict setObject:textCityLiving.text forKey:@"city"];

    [loginManager setMatrimonyPersonalInformation:dataDict];
   
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(appDelegate.iPad)
    {
        if(textField == textCountry)
        {
            [textFirstName resignFirstResponder];
            [textLastName resignFirstResponder];

            [self showLanguageView];
            return NO;
        }
    }
    else
    {
        NSLog(@"--- Text Field %f", textField.frame.origin.y);
        
        if(textField == textLastName)
            [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
        else if(textField == textCountry)
        {
            [textFirstName resignFirstResponder];
            [textLastName resignFirstResponder];

            [self showLanguageView];
            //[scrollView setContentOffset:CGPointMake(0, 130) animated:YES];
            [textCurrentField resignFirstResponder];
            return NO;
        }
        else if(textField == textStateLivingIn)
            [scrollView setContentOffset:CGPointMake(0, 215) animated:YES];
        else if(textField == textCityLiving)
            [scrollView setContentOffset:CGPointMake(0, 300) animated:YES];
        else
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

        

    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textCurrentField resignFirstResponder];
    
}

#pragma mark -----   -----   -----   -----

-(void)showLanguageView
{
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textCountry.frame.size.width, 0) style:UITableViewStylePlain];
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
    transparentView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self initialTableViewPosition];
        
    }completion:^(BOOL finished){
        
        languageBg.hidden = YES;
        
    }];
    
}

#pragma mark –---   UITableViewDataSource  ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.arrayCountryData count];
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
    labelName.text = [[appDelegate.arrayCountryData objectAtIndex:indexPath.row] countryName];
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
    textCountry.text = [[appDelegate.arrayCountryData objectAtIndex:indexPath.row] countryName];
    selectedCountryCode = [[appDelegate.arrayCountryData objectAtIndex:indexPath.row] countryCode];
    
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

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithMatrimonyPersonalInfo:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

    alert.rightBlock = ^()
    {
        MatrimonyAboutYourself *matrimonyAbout;
        
        if(appDelegate.iPad)
            matrimonyAbout = [[MatrimonyAboutYourself alloc]initWithNibName:@"MatrimonyAboutYourself_iPad" bundle:nil];
        else
            matrimonyAbout = [[MatrimonyAboutYourself alloc]initWithNibName:@"MatrimonyAboutYourself" bundle:nil];
        
        [self.navigationController pushViewController:matrimonyAbout animated:YES];

    };
    
}

-(void)successWithDropDownData:(DropdownData *)_dropDownData
{
    [appDelegate stopSpinner];
    
    appDelegate.dropDownObject = _dropDownData;
    
}

@end
