//
//  MatrimonyMyMatch.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyMyMatch.h"
#import "Constant.h"

#import "CustomAlertView.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44


int static kHavingKids = 0;
int static kWantKids = 1;
int static kRelStatus = 2;
int static kOccupation = 3;

int static kSalary = 4;
int static kSmoke = 5;
int static kDrink = 6;


@interface MatrimonyMyMatch ()

@end

@implementation MatrimonyMyMatch

@synthesize matchDataObject;
@synthesize isCommingFromMatrimony;



- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(isCommingFromMatrimony == YES)
        labelHeaderTitle.text = @"Matrimony";
    else
        labelHeaderTitle.text = @"Partner Preferences";

    
    [self setSelectLanguageView];
   
    selectedHavingKidsId = @"";
    selectedWantKidsId = @"";
    selectedRelStatusId = @"";
    selectedOccupationId = @"";
    selectedSalaryRangeId = @"";
    selectedSmokeId = @"";
    selectedDrinkId = @"";
    
    
    arrayData = [[NSMutableArray alloc]init];
    
    arrayHavingKids = appDelegate.dropDownObject.arrayKids;
    arrayWantKids = appDelegate.dropDownObject.arrayWantMore;
    
    arrayRelationshipStatus = appDelegate.dropDownObject.arrayRelationshipStatus;
    arrayOccupation = appDelegate.dropDownObject.arrayOccupations;

    arraySalaryRange = appDelegate.dropDownObject.arraySalaryRange;
    arraySmoke = appDelegate.dropDownObject.arraySmoke;
    arrayDrink = appDelegate.dropDownObject.arrayDrink;

    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textRelStatus.leftView = paddingView;
    textRelStatus.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textOccupation.leftView = paddingView;
    textOccupation.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSalaryRange.leftView = paddingView;
    textSalaryRange.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSmoke.leftView = paddingView;
    textSmoke.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textDrink.leftView = paddingView;
    textDrink.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textWantsKids.leftView = paddingView;
    textWantsKids.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textHavingKids.leftView = paddingView;
    textHavingKids.leftViewMode = UITextFieldViewModeAlways;
    
    
    if(appDelegate.iPad)
    {
        
    }
    else
    {
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 750);
        
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


-(IBAction)btnMyMatchTapped:(id)sender
{
    //appDelegate.isYourMatch = YES;
    //[appDelegate navigateToHomeViewController];
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [self setMatrimonyFindYourMatch];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}

-(void)setMatrimonyFindYourMatch
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
    
    
    [dataDict setObject:matchDataObject.matchSeeking forKey:@"interestedin"];
    [dataDict setObject:matchDataObject.matchAgeFrom forKey:@"agefrom"];
    [dataDict setObject:matchDataObject.matchAgeTo forKey:@"ageto"];

    [dataDict setObject:matchDataObject.matchCountry forKey:@"country"];
    [dataDict setObject:matchDataObject.matchState forKey:@"state"];
    [dataDict setObject:matchDataObject.matchCity forKey:@"city"];

    
    [dataDict setObject:matchDataObject.matchHairColor forKey:@"hair_color"];
    [dataDict setObject:matchDataObject.matchEyeColor forKey:@"eye_color"];
    [dataDict setObject:matchDataObject.matchHeight forKey:@"height"];
    [dataDict setObject:matchDataObject.matchBodyType forKey:@"body_type"];


    [dataDict setObject:matchDataObject.matchEduLevel forKey:@"edu_level"];
    [dataDict setObject:matchDataObject.matchLanguageSpeakArray forKey:@"lang_speak"];
    //[dataDict setObject:matchDataObject.matchEthnicity forKey:@""];          ---- Ethnicity
    [dataDict setObject:matchDataObject.matchReligiousBelief forKey:@"religion"];


    if(selectedRelStatusId.length != 0)
        [dataDict setObject:selectedRelStatusId forKey:@"relation_status"];
    else
        [dataDict setObject:@"" forKey:@"relation_status"];

    //[dataDict setObject:@"" forKey:@""];                  ==  She have kids
    
    if(selectedWantKidsId.length != 0)
        [dataDict setObject:selectedWantKidsId forKey:@"wants_kids_partner"];
    else
        [dataDict setObject:@"" forKey:@"wants_kids_partner"];

    if(selectedOccupationId.length != 0)
        [dataDict setObject:selectedOccupationId forKey:@"occupation"];
   else
       [dataDict setObject:@"" forKey:@"occupation"];

    if(selectedSalaryRangeId.length != 0)
        [dataDict setObject:selectedSalaryRangeId forKey:@"salary"];
    else
       [dataDict setObject:@"" forKey:@"salary"];

    if(selectedSmokeId.length != 0)
        [dataDict setObject:selectedSmokeId forKey:@"smoke"];
    else
        [dataDict setObject:selectedSmokeId forKey:@"smoke"];

    if(selectedDrinkId.length != 0)
        [dataDict setObject:selectedDrinkId forKey:@"drink"];
    else
        [dataDict setObject:selectedDrinkId forKey:@"drink"];


    [dataDict setObject:@"" forKey:@"kids_liveaway"];
    [dataDict setObject:@"" forKey:@"kids_livein"];
    [dataDict setObject:@"" forKey:@"wants_kids_notsure"];
    [dataDict setObject:@"" forKey:@"wants_kids_no"];
    [dataDict setObject:@"" forKey:@"wants_kids_yes"];
    [dataDict setObject:@"" forKey:@"kids_no_preference"];
    [dataDict setObject:@"" forKey:@"wants_kids_someday"];
    [dataDict setObject:@"" forKey:@"kidsno"];
    [dataDict setObject:@"" forKey:@"wants_kids_no_preference"];

    
    [loginManager setMatrimonyMatch:dataDict];
    
}


//--------------

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
    
    
    tableSliderOptions = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, DEVICE_WIDTH, 0) style:UITableViewStylePlain];
    tableSliderOptions.delegate = self;
    tableSliderOptions.dataSource = self;
    tableSliderOptions.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    tableSliderOptions.separatorStyle = UITableViewCellSeparatorStyleNone;
    [languageBg addSubview:tableSliderOptions];
    
    languageBg.hidden = YES;
    
    
    [self initialTableViewPosition];
    
}




-(IBAction)btnContinueTapped:(id)sender
{
    MatrimonyMyMatch *myMatch;
    
    if(appDelegate.iPad)
        myMatch = [[MatrimonyMyMatch alloc]initWithNibName:@"MatrimonyMyMatch_iPad" bundle:nil];
    else
        myMatch = [[MatrimonyMyMatch alloc]initWithNibName:@"MatrimonyMyMatch" bundle:nil];
    
    myMatch.isCommingFromMatrimony = isCommingFromMatrimony;
    [self.navigationController pushViewController:myMatch animated:YES];
    
    
}


-(void)initialTableViewPosition
{
    transparentView.alpha = 0;
    
    if(appDelegate.iPad)
    {
        languageBg.frame = CGRectMake(DEVICE_WIDTH, 71, DEVICE_WIDTH, DEVICE_HEIGHT-72);
        
        transparentView.frame = CGRectMake(0, 0, DEVICE_WIDTH - 300, languageBg.frame.size.height);
        
        tableSliderOptions.frame = CGRectMake(DEVICE_WIDTH - 300, 0, 300, languageBg.frame.size.height);
    }
    else
    {
        languageBg.frame = CGRectMake(DEVICE_WIDTH, 65, DEVICE_WIDTH, DEVICE_HEIGHT-65);
        
        transparentView.frame = CGRectMake(0, 0, DEVICE_WIDTH - 200, languageBg.frame.size.height);
        
        tableSliderOptions.frame = CGRectMake(DEVICE_WIDTH-200, 0, 200, languageBg.frame.size.height);
    }
    
}

-(void)showSliderOptionView
{
    [tableSliderOptions reloadData];
    languageBg.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        if(appDelegate.iPad)
            languageBg.frame = CGRectMake(0, 71, DEVICE_WIDTH, DEVICE_HEIGHT-72);
        else
            languageBg.frame = CGRectMake(0, 65, DEVICE_WIDTH, DEVICE_HEIGHT-65);
        
    }completion:^(BOOL finished){
        
        transparentView.alpha = 1;
        
    }];
    
}


-(void)hideLanguageView
{
    
    //btnSelectDate.selected = NO;
    
    transparentView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self initialTableViewPosition];
        
    }completion:^(BOOL finished){
        
        languageBg.hidden = YES;
        
    }];
    
}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(textField == textHavingKids)
    {
        selectedType = kHavingKids;
        arrayData = arrayHavingKids;
        [self showSliderOptionView];
    }
    else if(textField == textWantsKids)
    {
        selectedType = kWantKids;
        arrayData = arrayWantKids;
        [self showSliderOptionView];
        
    }
    else if(textField == textOccupation)
    {
        selectedType = kOccupation;
        arrayData = arrayOccupation;
        [self showSliderOptionView];
        
    }
    else if(textField == textRelStatus)
    {
        selectedType = kRelStatus;
        arrayData = arrayRelationshipStatus;
        [self showSliderOptionView];
        
    }
    else if(textField == textSalaryRange)
    {
        selectedType = kSalary;
        arrayData = arraySalaryRange;
        [self showSliderOptionView];
        
    }
    else if(textField == textSmoke)
    {
        selectedType = kSmoke;
        arrayData = arraySmoke;
        [self showSliderOptionView];
        
    }
    else if(textField == textDrink)
    {
        selectedType = kDrink;
        arrayData = arrayDrink;
        [self showSliderOptionView];
        
    }
    
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

#pragma mark – UITableViewDataSource

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
    labelName.text = [[arrayData objectAtIndex:indexPath.row] name];
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
    
    if(selectedType == kHavingKids)
    {
        selectedHavingKidsId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kWantKids)
    {
        selectedWantKidsId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kRelStatus)
    {
        selectedRelStatusId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kOccupation)
    {
        selectedOccupationId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kSalary)
    {
        selectedSalaryRangeId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kSmoke)
    {
        selectedSmokeId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kDrink)
    {
        selectedDrinkId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    
    [self hideLanguageView];
    
}

#pragma mark -----   -----   -----   ----
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

-(void)successWithMatrimonyMatch:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

    alert.rightBlock = ^()
    {
        //appDelegate.isYourMatch = YES;
        [appDelegate navigateToMatchViewController];

    };
}


@end
