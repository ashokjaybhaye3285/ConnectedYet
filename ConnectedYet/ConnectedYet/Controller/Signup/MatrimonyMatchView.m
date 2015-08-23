//
//  MatrimonyMatchView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyMatchView.h"
#import "MatrimonyMyMatch.h"
#import "Constant.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44

int static kSeeking = 0;
int static kAgeFrom = 1;
int static kAgeTo = 2;

int static kCountry = 3;
int static kHairColor = 4;
int static kEyeColor = 5;

int static kHeight = 6;
int static kBodyType = 7;

int static kEduLevel = 8;
int static kLanguageSpeak = 9;

int static kEthnicity = 10;
int static kReligiouRelief = 11;


@interface MatrimonyMatchView ()

@end

@implementation MatrimonyMatchView

@synthesize isCommingFromMatrimony;


-(void)isForEdit:(BOOL)_isEdit
{
    isEdit = _isEdit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(isCommingFromMatrimony == YES)
    {
        labelHeaderTitle.text = @"Matrimony";
        [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    }
    else
    {
        labelHeaderTitle.text = @"Partner Preferences";
        [btnBack setImage:[UIImage imageNamed:@"slider-icon.png"] forState:UIControlStateNormal];

    }
    /*
    appDelegate.arrayCountryData = [[NSMutableArray alloc] init];
    CountryData *data = [[CountryData alloc] init];
    data.countryCode = @"IN";
    data.countryName = @"India";
    [appDelegate.arrayCountryData addObject:data];
     */
    
    [self setSelectLanguageView];
    
    selectedLanguageId = @"";
    selectedEthnicityId = @"";
    selectedAgeFromId = @"";
    selectedAgeToId = @"";
    selectedCountryId = @"";
    selectedHailColorId = @"";
    selectedEyeColorId = @"";
    selectedHeightId = @"";
    selectedBodyTypeId = @"";
    selectedEduLevelId = @"";
    selectedSeekingId = @"";
    selectedReligiousReliefId = @"";
    
    arrayData = [[NSMutableArray alloc]init];
    
    arrayLanguage = appDelegate.dropDownObject.arrayLanguageSpeak;
    arrayEthnicity = appDelegate.dropDownObject.arrayEthnicity;
    
    arraySeeking = appDelegate.dropDownObject.arraySexualPreferences;
    arrayAgeFrom = appDelegate.dropDownObject.arrayAgeFrom;
    arrayAgeTo = appDelegate.dropDownObject.arrayAgeTo;

    arrayEyeColor = appDelegate.dropDownObject.arrayEyecolor;
    arrayHairColor = appDelegate.dropDownObject.arrayHaircolor;

    arrayCountry = appDelegate.arrayCountryData;
    arrayHeight = appDelegate.dropDownObject.arrayHeight;
    arrayBodyType = appDelegate.dropDownObject.arrayBodyType;

    arrayEduLevel = appDelegate.dropDownObject.arrayEductionLevel;
    arrayLanguage = appDelegate.dropDownObject.arrayLanguageSpeak;
    arrayEthnicity = appDelegate.dropDownObject.arrayEthnicity;
    arrayReligiousRelief = appDelegate.dropDownObject.arrayReligion;

    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSeeking.leftView = paddingView;
    textSeeking.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textAgrFrom.leftView = paddingView;
    textAgrFrom.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textAgeTo.leftView = paddingView;
    textAgeTo.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCountry.leftView = paddingView;
    textCountry.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textState.leftView = paddingView;
    textState.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCity.leftView = paddingView;
    textCity.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
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
    textEduLevel.leftView = paddingView;
    textEduLevel.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textReligiousBelief.leftView = paddingView;
    textReligiousBelief.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textLanguage.leftView = paddingView;
    textLanguage.leftViewMode = UITextFieldViewModeAlways;
    
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEthnicity.leftView = paddingView;
    textEthnicity.leftViewMode = UITextFieldViewModeAlways;
    
    
    if(appDelegate.iPad)
    {
        
    }
    else
    {
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1400);
        
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
    
    
    tableSliderOptions = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, DEVICE_WIDTH, 0) style:UITableViewStylePlain];
    tableSliderOptions.delegate = self;
    tableSliderOptions.dataSource = self;
    tableSliderOptions.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    tableSliderOptions.separatorStyle = UITableViewCellSeparatorStyleNone;
    [languageBg addSubview:tableSliderOptions];
    
    languageBg.hidden = YES;
    
    
    [self initialTableViewPosition];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    if(isCommingFromMatrimony == YES)
        [self.navigationController popViewControllerAnimated:YES];
    else
    {
        MVYSideMenuController *sideMenuController = [self sideMenuController];
        
        if (sideMenuController) {
            
            [sideMenuController openMenu];
            
        }
        
    }
    
}


-(IBAction)btnContinueTapped:(id)sender
{
    textState.text = [textState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    textCity.text = [textCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    matchDataObject = [[MatchData alloc]init];
    
    if(selectedSeekingId.length != 0)
       matchDataObject.matchSeeking = selectedSeekingId;
    else
       matchDataObject.matchSeeking = @"";

    if(selectedAgeFromId.length != 0)
        matchDataObject.matchAgeFrom = selectedAgeFromId;
    else
        matchDataObject.matchAgeFrom = @"";

    if(selectedAgeToId.length != 0)
        matchDataObject.matchAgeTo = selectedAgeToId;
    else
        matchDataObject.matchAgeTo = @"";

    if(selectedCountryId.length != 0)
        matchDataObject.matchCountry = selectedCountryId;
    else
        matchDataObject.matchCountry = @"";

    if(textState.text.length != 0)
        matchDataObject.matchState = textState.text;
    else
        matchDataObject.matchState = @"";

    if(textCity.text.length != 0)
        matchDataObject.matchCity = textCity.text;
    else
        matchDataObject.matchCity = @"";

    if(selectedHailColorId.length != 0)
        matchDataObject.matchHairColor = selectedHailColorId;
    else
        matchDataObject.matchHairColor = @"";

    if(selectedEyeColorId.length != 0)
        matchDataObject.matchEyeColor = selectedEyeColorId;
    else
        matchDataObject.matchEyeColor = @"";

    if(selectedHeightId.length != 0)
        matchDataObject.matchHeight = selectedHeightId;
    else
        matchDataObject.matchHeight = @"";

    if(selectedBodyTypeId.length != 0)
        matchDataObject.matchBodyType = selectedBodyTypeId;
    else
        matchDataObject.matchBodyType = @"";

    if(selectedEduLevelId.length != 0)
        matchDataObject.matchEduLevel = selectedEduLevelId;
    else
        matchDataObject.matchEduLevel = @"";

    if(selectedLanguageId.length != 0)
    {
        matchDataObject.matchLanguageSpeakArray = [[NSMutableArray alloc] initWithObjects:selectedLanguageId, nil];
    }
    else
        matchDataObject.matchLanguageSpeakArray = [[NSMutableArray alloc] initWithObjects:@"", nil];

    if(selectedEthnicityId.length != 0)
        matchDataObject.matchEthnicity = selectedEthnicityId;
    else
        matchDataObject.matchEthnicity = @"";

    if(selectedReligiousReliefId.length != 0)
        matchDataObject.matchReligiousBelief = selectedReligiousReliefId;
    else
        matchDataObject.matchReligiousBelief = @"";

    
    MatrimonyMyMatch *myMatch;
    
    if(appDelegate.iPad)
        myMatch = [[MatrimonyMyMatch alloc]initWithNibName:@"MatrimonyMyMatch_iPad" bundle:nil];
    else
        myMatch = [[MatrimonyMyMatch alloc]initWithNibName:@"MatrimonyMyMatch" bundle:nil];
    myMatch.matchDataObject = matchDataObject;
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
    
    if(textField == textSeeking)
    {
        selectedType = kSeeking;
        arrayData = arraySeeking;
        [self showSliderOptionView];
        
        return NO;
    }
    
    if(textField == textAgrFrom)
    {
        selectedType = kAgeFrom;
        arrayData = arrayAgeFrom;
        [self showSliderOptionView];
        return NO;
    }
    
    if(textField == textAgeTo)
    {
        selectedType = kAgeTo;
        arrayData = arrayAgeTo;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textCountry)
    {
        selectedType = kCountry;
        arrayData = appDelegate.arrayCountryData;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textHairColor)
    {
        selectedType = kHairColor;
        arrayData = arrayHairColor;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textEyeColor)
    {
        selectedType = kEyeColor;
        arrayData = arrayEyeColor;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textHeight)
    {
        selectedType = kHeight;
        arrayData = arrayHeight;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textBodyType)
    {
        selectedType = kBodyType;
        arrayData = arrayBodyType;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textEduLevel)
    {
        selectedType = kEduLevel;
        arrayData = arrayEduLevel;
        [self showSliderOptionView];
        return NO;
    }
    if(textField == textLanguage)
    {
        selectedType = kLanguageSpeak;
        arrayData = arrayLanguage;
        [self showSliderOptionView];
        return NO;
    }
    else if(textField == textEthnicity)
    {
        selectedType = kEthnicity;
        arrayData = arrayEthnicity;
        [self showSliderOptionView];
        return NO;
        
    }
    if(textField == textReligiousBelief)
    {
        selectedType = kLanguageSpeak;
        arrayData = arrayReligiousRelief;
        [self showSliderOptionView];
        return NO;
    }
    
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
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textCurrentField resignFirstResponder];

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
    [cell.contentView addSubview:labelName];
    
    if(selectedType == kCountry)
        labelName.text = [[arrayData objectAtIndex:indexPath.row] countryName];
    else
        labelName.text = [[arrayData objectAtIndex:indexPath.row] name];

    
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
    if(selectedType == kSeeking)
    {
        selectedSeekingId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];

    }
    else if(selectedType == kAgeFrom)
    {
        selectedAgeFromId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];

    }
    else if(selectedType == kAgeTo)
    {
        selectedAgeToId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];

    }
    else if(selectedType == kCountry)
    {
        selectedCountryId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] countryCode]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] countryName]];

    }
    else if(selectedType == kHeight)
    {
        selectedHeightId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kBodyType)
    {
        selectedBodyTypeId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kEduLevel)
    {
        selectedEduLevelId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kLanguageSpeak)
    {
        selectedLanguageId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kEthnicity)
    {
        selectedEthnicityId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kReligiouRelief)
    {
        selectedReligiousReliefId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kEyeColor)
    {
        selectedEyeColorId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    else if(selectedType == kHairColor)
    {
        selectedHailColorId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
        textCurrentField.text = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] name]];
        
    }
    
    [self hideLanguageView];
    
}

@end
