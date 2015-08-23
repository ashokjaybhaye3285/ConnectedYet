//
//  DatingStatusView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "DatingStatusView.h"
#import "Constant.h"
#import "CustomAlertView.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44

int static kRelStatus = 0;
int static kBodyType = 1;
int static kHeight = 2;
int static kLangSpeak = 3;


@interface DatingStatusView ()

@end

@implementation DatingStatusView

-(void)isForEdit:(BOOL)_isEdit
{
    isEdit = _isEdit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 730);
    
    textAboutYourself.placeholder = @"About Yourself";
    textAboutYourself.layer.cornerRadius = 6.0;
    
    [self setSelectLanguageView];
    
    if(isEdit)
    {
        labelTopHeader.text = @"Edit Profile";
        [btnNext setTitle:@"Update" forState:UIControlStateNormal];
        
        selectedInterest = appDelegate.userDetails.userInterest;
        selectedRelStatusId = appDelegate.userDetails.userRelStatus;
        selectedBodytype = appDelegate.userDetails.userBodyType;
        selectedHeightId = appDelegate.userDetails.userHeight;
        selectedLangSpeakId = @"";

    }
    else
    {
        selectedInterest = @"m";
        selectedRelStatusId = @"";
        selectedBodytype = @"";
        selectedHeightId = @"";
        selectedLangSpeakId = @"";
 
    }
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textRelationshipStatus.leftView = paddingView;
    textRelationshipStatus.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSexualPreference.leftView = paddingView;
    textSexualPreference.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHeight.leftView = paddingView;
    textHeight.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textBodyType.leftView = paddingView;
    textBodyType.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textLanguageSpeak.leftView = paddingView;
    textLanguageSpeak.leftViewMode = UITextFieldViewModeAlways;
    
    [self getDropDownValues];
    
}


-(void)getDropDownValues
{
    [appDelegate startSpinner];
    
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


-(IBAction)btnLoginTapped:(id)sender
{
    //[appDelegate navigateToHomeViewController];

    if([MYSBaseProxy isNetworkAvailable])
    {
        [self setDatingInfo];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

-(void)setDatingInfo
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    if(selectedHeightId.length != 0)
        [dataDict setValue:selectedHeightId forKey:@"height"];
    else
        [dataDict setValue:@"" forKey:@"height"];

    if(selectedBodytype.length != 0)
        [dataDict setValue:selectedBodytype forKey:@"body_type"];
    else
        [dataDict setValue:@"" forKey:@"body_type"];

    if(textAboutYourself.text.length != 0)
        [dataDict setValue:textAboutYourself.text forKey:@"biography"];
    else
        [dataDict setValue:@"" forKey:@"biography"];

    
    if(selectedLangSpeakId.length != 0)
        [dataDict setValue:[[NSMutableArray alloc] initWithObjects:selectedLangSpeakId, nil] forKey:@"lang_speak"];
    else
        [dataDict setValue:@"" forKey:@"lang_speak"];

    if(selectedRelStatusId.length != 0)
        [dataDict setValue:selectedRelStatusId forKey:@"relation_status"];
    else
        [dataDict setValue:@"" forKey:@"relation_status"];
    
    [dataDict setValue:selectedInterest forKey:@"interestedin"];

    
    [loginManager setDatingInfo:dataDict];
   

}


-(IBAction)btnGenderTapped:(id)sender
{
    if([sender tag]==0)
    {
        selectedInterest = @"m";
        
        [btnMale setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
        [btnFemale setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
        
    }
    else
    {

        selectedInterest = @"f";

        [btnMale setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
        [btnFemale setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(textField == textRelationshipStatus)
    {
        selectedType = kRelStatus;
        arrayData = arrayRelStaus;
        [self showLanguageView];
        
    }
    else if(textField == textBodyType)
    {
        selectedType = kBodyType;
        arrayData = arrayBodyType;
        [self showLanguageView];
        
    }
    else if(textField == textHeight)
    {
        selectedType = kHeight;
        arrayData = arrayHeight;
        [self showLanguageView];
        
    }
    else if(textField == textLanguageSpeak)
    {
        selectedType = kLangSpeak;
        arrayData = arrayLanguageSpeak;
        [self showLanguageView];
        
    }
    
    if(appDelegate.iPad)
    {
        
    }
    else
    {
        
    }
    
    return NO;
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
    [textAboutYourself resignFirstResponder];
    
}

#pragma mark -----   -----   -----   -----

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [scrollView setContentOffset:CGPointMake(0, 380) animated:YES];
    return YES;
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
    
    [tablePrimaryLanguage reloadData];
    
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textRelationshipStatus.frame.size.width, 0) style:UITableViewStylePlain];
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
    [textCurrentField resignFirstResponder];
    
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
    return [arrayData count];
    
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
    [cell.contentView addSubview:labelName];
    
    labelName.text = [NSString stringWithFormat:@"%@",[[arrayData objectAtIndex:indexPath.row] name]];
    
    
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
    if(selectedType == kRelStatus)
    {
        textRelationshipStatus.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedRelStatusId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kBodyType)
    {
        textBodyType.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedBodytype = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kHeight)
    {
        textHeight.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedHeightId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kLangSpeak)
    {
        textLanguageSpeak.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedLangSpeakId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    
    [self hideLanguageView];
    
}


#pragma mark -----  ----- ----- -----
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


-(void)successWithDropDownData:(DropdownData *)_dropDownData
{
    [appDelegate stopSpinner];
    
    appDelegate.dropDownObject = _dropDownData;
    
    arrayRelStaus = appDelegate.dropDownObject.arrayRelationshipStatus;
    arrayBodyType = appDelegate.dropDownObject.arrayBodyType;
    arrayHeight = appDelegate.dropDownObject.arrayHeight;
    arrayLanguageSpeak = appDelegate.dropDownObject.arrayLanguageSpeak;

}

-(void)successWithUpdateDattingInfo:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        if(isEdit)
            [self.navigationController popViewControllerAnimated:YES];
        else
        {
            [appDelegate saveCustomObject:appDelegate.tempObject];
            [appDelegate navigateToHomeViewController];
        }

    };
    
}

@end
