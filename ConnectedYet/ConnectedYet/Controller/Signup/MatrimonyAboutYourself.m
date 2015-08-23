//
//  MatrimonyAboutYourself.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 11/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyAboutYourself.h"
#import "MatrimonyAboutLifestyle.h"
#import "Constant.h"

#import "CustomAlertView.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44

int static kHairColor = 0;
int static kEyeColor = 1;

int static kBodyType = 2;
int static kHeight = 3;
int static kSign = 4;

int static kRelationshipStatus = 5;
int static kOccupation = 6;
int static kSalaryRange = 7;

int static kWantKids = 8;
int static kHaveKids = 9;
int static kHowManyKids = 10;


@interface MatrimonyAboutYourself ()

@end

@implementation MatrimonyAboutYourself

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSLog(@"-- App delegate :%@", appDelegate.dropDownObject);

    [self setSelectLanguageView];
    
    arrayEyesColor = appDelegate.dropDownObject.arrayEyecolor;
    arrayHairColor = appDelegate.dropDownObject.arrayHaircolor;
    arrayBodyType = appDelegate.dropDownObject.arrayBodyType;
    arrayHeight = appDelegate.dropDownObject.arrayHeight;
    arraySign = appDelegate.dropDownObject.arraySign;
    arrayRelationshipstatus = appDelegate.dropDownObject.arrayRelationshipStatus;
    arrayOccupation = appDelegate.dropDownObject.arrayOccupations;
    arraySalaryRange = appDelegate.dropDownObject.arraySalaryRange;

    arrayHowManyKids = appDelegate.dropDownObject.arrayHowMany;
    arrayHaveKids = appDelegate.dropDownObject.arrayKids;
    arrayWantKids = appDelegate.dropDownObject.arrayWantMore;

    selectedHairColorId = @"";
    selectedEyeColorId = @"";
    selectedBodyTypeId = @"";
    selectedHeightId = @"";
    selectedSignId = @"";
    selectedRelationshipId = @"";
    selectedOccupationId = @"";
    selectedSalaryId = @"";
    selectedHowManyKidId = @"";
    selectedWantMoreId = @"";
    selectedHaveKidsId = @"";
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHairColor.leftView = paddingView;
    textHairColor.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEyeColor.leftView = paddingView;
    textEyeColor.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textBodyType.leftView = paddingView;
    textBodyType.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHeight.leftView = paddingView;
    textHeight.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSign.leftView = paddingView;
    textSign.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textRelStatus.leftView = paddingView;
    textRelStatus.leftViewMode = UITextFieldViewModeAlways;
        
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textOccupation.leftView = paddingView;
    textOccupation.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSalaryRange.leftView = paddingView;
    textSalaryRange.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHaveKids.leftView = paddingView;
    textHaveKids.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHowManyKids.leftView = paddingView;
    textHowManyKids.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textWantKids.leftView = paddingView;
    textWantKids.leftViewMode = UITextFieldViewModeAlways;

    
    if(appDelegate.iPad)
    {
        
    }
    else
    {
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1050);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnContinueTapped:(id)sender
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [self setMatrimonyAboutYourselfs];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    /*
    MatrimonyAboutLifestyle *matrimonyLifestyle;
    
    if(appDelegate.iPad)
        matrimonyLifestyle = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle_iPad" bundle:nil];
    else
        matrimonyLifestyle = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle" bundle:nil];
    
    [self.navigationController pushViewController:matrimonyLifestyle animated:YES];
    */
}


-(void)setMatrimonyAboutYourselfs
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
    
    if(selectedHairColorId.length != 0)
        [dataDict setObject:selectedHairColorId forKey:@"hair_color"];
    else
        [dataDict setObject:@"" forKey:@"hair_color"];

    if(selectedEyeColorId.length != 0)
        [dataDict setObject:selectedEyeColorId forKey:@"eye_color"];
    else
        [dataDict setObject:@"" forKey:@"eye_color"];

    if(selectedBodyTypeId.length != 0)
        [dataDict setObject:selectedBodyTypeId forKey:@"body_type"];
    else
        [dataDict setObject:@"" forKey:@"body_type"];

    if(selectedHeightId.length != 0)
        [dataDict setObject:selectedHeightId forKey:@"height"];
    else
        [dataDict setObject:@"" forKey:@"height"];

    if(selectedSignId.length != 0)
        [dataDict setObject:selectedSignId forKey:@"sign"];
    else
        [dataDict setObject:@"" forKey:@"sign"];

    if(selectedRelationshipId.length != 0)
        [dataDict setObject:selectedRelationshipId forKey:@"relation_status"];
    else
        [dataDict setObject:@"" forKey:@"relation_status"];
    
    if(selectedOccupationId.length != 0)
        [dataDict setObject:selectedOccupationId forKey:@"occupation"];
    else
        [dataDict setObject:@"" forKey:@"occupation"];

    if(selectedSalaryId.length != 0)
        [dataDict setObject:selectedSalaryId forKey:@"salary"];
    else
        [dataDict setObject:@"" forKey:@"salary"];

    if(selectedHowManyKidId.length != 0)
        [dataDict setObject:selectedHowManyKidId forKey:@"ishowmany"];
    else
        [dataDict setObject:@"" forKey:@"ishowmany"];

    if(selectedWantMoreId.length != 0)
        [dataDict setObject:selectedWantMoreId forKey:@"whatmore"];
    else
        [dataDict setObject:selectedWantMoreId forKey:@"whatmore"];

    if(selectedHaveKidsId.length != 0)
        [dataDict setObject:selectedHaveKidsId forKey:@"kids"];
    else
        [dataDict setObject:@"" forKey:@"kids"];


    [loginManager setMatrimonyAboutYourself:dataDict];
    
    
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(textField == textHairColor)
    {
        selectedType = kHairColor;
        arrayData = arrayHairColor;
        [self showLanguageView];

    }
    else if(textField == textEyeColor)
    {
        selectedType = kEyeColor;
        arrayData = arrayEyesColor;
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
    else if(textField == textSign)
    {
        selectedType = kSign;
        arrayData = arraySign;
        [self showLanguageView];
        
    }
    else if(textField == textRelStatus)
    {
        selectedType = kRelationshipStatus;
        arrayData = arrayRelationshipstatus;
        [self showLanguageView];
        
    }
    else if(textField == textOccupation)
    {
        selectedType = kOccupation;
        arrayData = arrayOccupation;
        [self showLanguageView];
        
    }
    else if(textField == textSalaryRange)
    {
        selectedType = kSalaryRange;
        arrayData = arraySalaryRange;
        [self showLanguageView];
        
    }
    else if(textField == textHaveKids)
    {
        selectedType = kHaveKids;
        arrayData = arrayHaveKids;
        [self showLanguageView];
        
    }
    else if(textField == textWantKids)
    {
        selectedType = kWantKids;
        arrayData = arrayWantKids;
        [self showLanguageView];
        
    }
    else if(textField == textHowManyKids)
    {
        selectedType = kHowManyKids;
        arrayData = arrayHowManyKids;
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textEyeColor.frame.size.width, 0) style:UITableViewStylePlain];
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
    if(selectedType == kHairColor)
    {
        textHairColor.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedHairColorId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kEyeColor)
    {
        textEyeColor.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedEyeColorId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kBodyType)
    {
        textBodyType.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedBodyTypeId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kHeight)
    {
        textHeight.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedHeightId = [NSString stringWithFormat:@"%@",[[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kSign)
    {
        textSign.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedSignId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kRelationshipStatus)
    {
        textRelStatus.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedRelationshipId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kOccupation)
    {
        textOccupation.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedOccupationId = [NSString stringWithFormat:@"%@",[[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kSalaryRange)
    {
        textSalaryRange.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedSalaryId = [NSString stringWithFormat:@"%@",[[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kHaveKids)
    {
        textHaveKids.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedHaveKidsId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    else if(selectedType == kHowManyKids)
    {
        textHowManyKids.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        selectedHowManyKidId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kWantKids)
    {
        textWantKids.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedWantMoreId = [[arrayData objectAtIndex:indexPath.row] Id];
    }
    
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

-(void)successWithMatrimonyAboutYourselfs:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        MatrimonyAboutLifestyle *matrimonyLifestyle;
        
        if(appDelegate.iPad)
            matrimonyLifestyle = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle_iPad" bundle:nil];
        else
            matrimonyLifestyle = [[MatrimonyAboutLifestyle alloc]initWithNibName:@"MatrimonyAboutLifestyle" bundle:nil];
        
        [self.navigationController pushViewController:matrimonyLifestyle animated:YES];

    };
    
}



@end
