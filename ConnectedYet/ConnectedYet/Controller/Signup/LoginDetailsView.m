//
//  LoginDetailsView.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 27/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "LoginDetailsView.h"
#import "PrimaryLanguageView.h"
#import "Constant.h"
#import "CustomAlertView.h"


#define kCellHeightiPad 50
#define kCellHeightiPhone 44


@interface LoginDetailsView ()

@end

@implementation LoginDetailsView


-(void)initWithIsEditProfile:(BOOL)_isEditProfile
{
    isEditProfile = _isEditProfile;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

#if DEBUG
    NSLog(@"-- Selected Gender :%@",appDelegate.selectedGender);
    NSLog(@"-- Birht Date :%@", appDelegate.birthDate);    
    NSLog(@"-- Image :%@", appDelegate.profileImage);

#endif

    selectedCountryCode = @"";
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEmail.leftView = paddingView;
    textEmail.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textUsername.leftView = paddingView;
    textUsername.leftViewMode = UITextFieldViewModeAlways;

    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCountryCode.leftView = paddingView;
    textCountryCode.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCellPhone.leftView = paddingView;
    textCellPhone.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textPassword.leftView = paddingView;
    textPassword.leftViewMode = UITextFieldViewModeAlways;

    
    //----------
    
    NSDictionary *thirdAttributes = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:225.0/255.0 alpha:1]};
    
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:@"Note: Your information will be secure with us. We will not disclose your information with any medium."];
    
    [myString setAttributes:thirdAttributes range:NSMakeRange(0, 5)];
    labelDescription.attributedText = myString;
    
    //------------
    
    //[self getAllCountryDetails];
    [self setSelectLanguageView];

    if(isEditProfile)
    {
        labelTopHeader.text = @"Edit";
        [btnNext setTitle:@"Update" forState:UIControlStateNormal];
    
        textEmail.userInteractionEnabled = NO;
        textUsername.userInteractionEnabled = NO;
        textPassword.userInteractionEnabled = NO;
        
        textEmail.text = appDelegate.userDetails.userEmail;
        textUsername.text = appDelegate.userDetails.userName;

        textCellPhone.text = appDelegate.userDetails.userPhone;
        textCountryCode.text = appDelegate.userDetails.userCountryCode;

    }
    else
    {
        textEmail.text = appDelegate.tempObject.userEmail;
        textUsername.text = appDelegate.tempObject.userName;
        
        textCellPhone.text = appDelegate.tempObject.userPhone;
        textCountryCode.text = appDelegate.tempObject.userCountryCode;

    }
    
    if(DEVICE_HEIGHT == 480)
    {
        CGRect newFrame = imageDescBg.frame;
        newFrame.origin.y -= 15;
        imageDescBg.frame = newFrame;
        
        newFrame = labelDescription.frame;
        newFrame.origin.y -= 15;
        labelDescription.frame = newFrame;
        
        newFrame = btnNext.frame;
        newFrame.origin.y += 30;
        btnNext.frame = newFrame;

    }
}


-(void)getAllCountryDetails
{
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    [loginManager getAllCountryDetails];   //GET TEST

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    //appDelegate.tempObject = [[UsersData alloc]init];
    appDelegate.tempObject.userName = textUsername.text;
    appDelegate.tempObject.userEmail = textEmail.text;
    appDelegate.tempObject.userCountryCode = textCountryCode.text;
    appDelegate.tempObject.userPhone = textCellPhone.text;

    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnNextTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Email Address :%@",textEmail.text);
    NSLog(@"-- Country Code :%@",textCountryCode.text);
    NSLog(@"-- Cell Phone :%@",textCellPhone.text);
    NSLog(@"-- Password :%@",textPassword.text);
#endif
    
    if(textUsername.text.length !=0)
    {
    if(textEmail.text.length !=0)
    {
        if([self isValidEmail:textEmail.text])
        {
        //if(textCountryCode.text.length !=0)
        //{
           // if(textCellPhone.text.length !=0)
            //{
                if(isEditProfile)
                {
                    [self updateLoginDetails];
                }
                else
                {
                    if(textPassword.text.length !=0)
                        [self registerNewUser];
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                        
                    }
                }
            
            /*}
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter cell number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
                
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter country code" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }*/
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter email id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter user name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
}


-(void)registerNewUser
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        [dataDict setObject:textUsername.text forKey:@"username"];
        
        [dataDict setObject:textEmail.text forKey:@"email"];
        [dataDict setObject:textPassword.text forKey:@"password"];
        
        [dataDict setObject:appDelegate.selectedGender forKey:@"gender"];
        
        if(appDelegate.birthDate.length != 0)
            [dataDict setObject:appDelegate.birthDate forKey:@"date_of_birth"];
        else
            [dataDict setObject:@"" forKey:@"date_of_birth"];
        
        [dataDict setObject:textCellPhone.text forKey:@"phone"];
        [dataDict setObject:textCountryCode.text forKey:@"countrycode"];
        
        [dataDict setObject:@"" forKey:@"profilePicturePath"];
        
        [dataDict setObject:@"en" forKey:@"locale"];
        [dataDict setObject:@"email" forKey:@"optby"];
        
        appDelegate.tempObject.userName = textUsername.text;
        appDelegate.tempObject.userEmail = textEmail.text;
        appDelegate.tempObject.userGender = appDelegate.selectedGender;
        appDelegate.tempObject.userBirthDate = appDelegate.birthDate;
        appDelegate.tempObject.userPhone = textCellPhone.text;
        appDelegate.tempObject.userCountryCode = textCountryCode.text;
        
        [loginManager registerNewUser:dataDict];  //POST TEST
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}


-(void)updateLoginDetails
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        //[dataDict setObject:textUsername.text forKey:@"username"];
        //[dataDict setObject:textEmail.text forKey:@"email"];
        //[dataDict setObject:textPassword.text forKey:@"password"];
        
        [dataDict setObject:textCellPhone.text forKey:@"phone"];
        [dataDict setObject:textCountryCode.text forKey:@"countrycode"];
        
        [loginManager updateLoginDetails:dataDict];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}

#pragma mark -----  -----  -----  ----

-(BOOL)isValidEmail:(NSString *)emailString
{
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
    
    //if(textField == textCountryCode)
      //  [self btnSelectLanguageTapped:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [currentTextField resignFirstResponder];
    
}


#pragma mark -----   -----   -----   -----
#pragma mark –---   UITableViewDataSource  ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayCountry count];
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
    labelName.text = [[arrayCountry objectAtIndex:indexPath.row] countryName];
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textCountryCode.frame.size.width, 0) style:UITableViewStylePlain];
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
    btnSelectCountry.selected = NO;
    
    transparentView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self initialTableViewPosition];
        
    }completion:^(BOOL finished){
        
        languageBg.hidden = YES;
        
    }];
    
}

-(IBAction)btnSelectLanguageTapped:(id)sender
{
    [textEmail resignFirstResponder];
    
    if(btnSelectCountry.selected == NO)
    {
        btnSelectCountry.selected = YES;
        
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



#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textCountryCode.text = [[arrayCountry objectAtIndex:indexPath.row] countryName];
    selectedCountryCode = [[arrayCountry objectAtIndex:indexPath.row] countryCode];
    
    [self hideLanguageView];
    
}

#pragma mark -----  ----- ----- -----

-(void)uploadProfilePicture
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
     NSData *_data = UIImageJPEGRepresentation (appDelegate.profileImage, 1);
     
     NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
     [imgDict setObject:_data forKey:@"profilePicturePath"];

     [loginManager uploadProfilePicture:imgDict];
    

}


-(void)uploadVoiceNote
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
    [imgDict setObject:appDelegate.dataVoiceNote forKey:@"audio"];
    
    [loginManager uploadVoiceNote:imgDict];
    
}

#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithCountryDetails:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];

#if DEBUG
    NSLog(@"-- Country Details :%@", _dataArray);
#endif
    
    arrayCountry = _dataArray;
    appDelegate.arrayCountryData = _dataArray;
    [tablePrimaryLanguage reloadData];
    
}

-(void)successWithNewUserRegistration:(NSString *)_message
{
    [appDelegate stopSpinner];

    if(appDelegate.profileImage)
    {
        [self uploadProfilePicture];
    }
    else
    {
        NSLog(@"-- Voice Note :%@", appDelegate.dataVoiceNote);
        
        if(appDelegate.dataVoiceNote)
        {
            [self uploadVoiceNote];
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
            
            alert.rightBlock = ^()
            {
                PrimaryLanguageView *primary;
                
                if(appDelegate.iPad)
                    primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView_iPad" bundle:nil];
                else
                    primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView" bundle:nil];
                
                [self.navigationController pushViewController:primary animated:YES];
                
            };
        }
       
    }

}


-(void)successfullyUploadProfilePicture:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    if(appDelegate.dataVoiceNote)
    {
        [self uploadVoiceNote];
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
        alert.rightBlock = ^()
        {
            PrimaryLanguageView *primary;
            
            if(appDelegate.iPad)
                primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView_iPad" bundle:nil];
            else
                primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView" bundle:nil];
            
            [self.navigationController pushViewController:primary animated:YES];
            
        };
        
    }
    
}

-(void)successfullyUploadVoiceNote:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        PrimaryLanguageView *primary;
        
        if(appDelegate.iPad)
            primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView_iPad" bundle:nil];
        else
            primary = [[PrimaryLanguageView alloc]initWithNibName:@"PrimaryLanguageView" bundle:nil];
        
        [self.navigationController pushViewController:primary animated:YES];
        
    };
    
}


-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

}


-(void)successWitUpdateLoginDetails:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    appDelegate.tempObject = appDelegate.userDetails;
    appDelegate.tempObject.userPhone = textCellPhone.text;
    appDelegate.tempObject.userCountryCode = textCountryCode.text;
    [appDelegate saveCustomObject:appDelegate.tempObject];
    
    alert.rightBlock =^()
    {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
}


@end
