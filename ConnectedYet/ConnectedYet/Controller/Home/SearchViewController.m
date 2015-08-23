//
//  SearchViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 13/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "SearchViewController.h"
#import "InviteContactsView.h"

#import "Constant.h"
#import "CustomAlertView.h"

#import "UsersCommonView.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44

int static kGender = 0;
int static kAgeFrom = 1;
int static kAgeTo = 2;
int static kCountry = 3;


@interface SearchViewController ()

@end

@implementation SearchViewController

-(void)setArrayData
{
    [arrayGender addObject:@"Male"];
    [arrayGender addObject:@"Female"];

    for (int i = 18; i < 80; i++)
    {
        [arrayAge addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    arrayGender = [[NSMutableArray alloc]init];
    arrayAge = [[NSMutableArray alloc]init];
    arrayCountry = [[NSMutableArray alloc] init];
    
    database = [[DatabaseConnection alloc]init];
    arrayCountry = [database getAllCountries];
    
    [self setArrayData];
    
    selectedLocatioType = @"nearby";
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textAgeFrom.leftView = paddingView;
    textAgeFrom.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textAgeTo.leftView = paddingView;
    textAgeTo.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textGender.leftView = paddingView;
    textGender.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textCountryCity.leftView = paddingView;
    textCountryCity.leftViewMode = UITextFieldViewModeAlways;

    
    [self setSelectLanguageView];

}

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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textGender.frame.size.width, 0) style:UITableViewStylePlain];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCountryCityTextfield
{
    textCountryCity.text = @"";
    textCountryCity.hidden = NO;

    if(appDelegate.iPad)
    {
        viewInvite.frame = CGRectMake(0, 500, viewInvite.frame.size.width, viewInvite.frame.size.height);
        
        //scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 500);
        
        //CGRect newframe = btnSearch.frame;
        //newframe.origin.y = 440;
        //btnSearch.frame = newframe;

    }
    else
    {
        viewInvite.frame = CGRectMake(0, 280 + 40, viewInvite.frame.size.width, viewInvite.frame.size.height);
        
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 500);
        
        CGRect newframe = btnSearch.frame;
        newframe.origin.y = 440;
        btnSearch.frame = newframe;

    }
    
}

-(IBAction)btnPeopleNearTapped:(id)sender
{
    selectedLocatioType = @"nearby";
    textCountryCity.text = @"";
    
    [btnPeopleNear setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
    [btnCountry setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
    [btnCity setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];

}

-(IBAction)btnCountryTapped:(id)sender
{
    selectedLocatioType = @"country";

    [self showCountryCityTextfield];
    
    selectedType = kCountry;
    arrayData = arrayCountry;
    [self showLanguageView];

    [btnPeopleNear setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
    [btnCountry setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
    [btnCity setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];

    
}
-(IBAction)btnCityTapped:(id)sender
{
    selectedLocatioType = @"city";

    [self showCountryCityTextfield];

    [btnPeopleNear setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
    [btnCountry setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
    [btnCity setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];

}

-(IBAction)btnInviteContactsTapped:(id)sender
{
    InviteContactsView *invite;
    
    if(appDelegate.iPad)
        invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView_iPad" bundle:nil];
    else
        invite = [[InviteContactsView alloc]initWithNibName:@"InviteContactsView" bundle:nil];
    
    invite.isForEdit = YES;
    [self.navigationController pushViewController:invite animated:YES];

}

-(IBAction)btnSearchTapped:(id)sender
{
    ageFrom = [textAgeFrom.text intValue];
    ageTo = [textAgeTo.text intValue];
    
    if(ageFrom < ageTo)
    {
        if([MYSBaseProxy isNetworkAvailable])
        {
            [appDelegate startSpinner];
            
            userManager = [[UserManager alloc]init];
            [userManager setUserManagerDelegate:self];
            
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
            
            [dataDict setObject:[textGender.text isEqualToString:@"Male"] ? @"m" : @"f" forKey:@"gender"];
            [dataDict setObject:textCountryCity.text forKey:@"location"];

            [dataDict setObject:selectedLocatioType forKey:@"location_type"];

            [dataDict setObject:textAgeFrom.text forKey:@"agefrom"];
            [dataDict setObject:textAgeTo.text forKey:@"ageto"];

            [dataDict setObject:@"18.5203" forKey:@"latitude"];
            [dataDict setObject:@"73.8567" forKey:@"longitude"];

            
            [userManager searchUsers:dataDict];
            
        //URL: http://aegis-infotech.com/connectedyet/web/api/userssearches/{id}
        //location_type should be city or country or nearby
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
            
        }


    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Selected age To is not less than age From" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    
}

-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    
    if (sideMenuController) {
        
        [sideMenuController openMenu];
        
    }
    
}


#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    textCurrentField = textField;
    
    if(textField == textGender)
    {
        selectedType = kGender;
        arrayData = arrayGender;
        [self showLanguageView];
        
    }
    else if(textField == textAgeFrom)
    {
        selectedType = kAgeFrom;
        arrayData = arrayAge;
        [self showLanguageView];
        
    }
    else if(textField == textAgeTo)
    {
        selectedType = kAgeTo;
        arrayData = arrayAge;
        [self showLanguageView];
        
    }
    else if(textField == textCountryCity)
    {
        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        return YES;

    }
    
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

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
    
    if(selectedType == kGender)
        labelName.text = [arrayData objectAtIndex:indexPath.row];
    else if(selectedType == kAgeFrom)
        labelName.text = [arrayData objectAtIndex:indexPath.row];
    else if(selectedType == kAgeTo)
        labelName.text = [arrayData objectAtIndex:indexPath.row];
    else if(selectedType == kCountry)
        labelName.text = [[arrayData objectAtIndex:indexPath.row] countryName];

    
    
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
    if(selectedType == kGender)
    {
        textGender.text = [arrayData objectAtIndex:indexPath.row];
    }
    else if(selectedType == kAgeFrom)
    {
        textAgeFrom.text = [NSString stringWithFormat:@"%@", [arrayData objectAtIndex:indexPath.row]];
    }
    else if(selectedType == kAgeTo)
    {
        textAgeTo.text = [arrayData objectAtIndex:indexPath.row];
    }
    else if(selectedType == kCountry)
    {
        textCountryCity.text = [[arrayData objectAtIndex:indexPath.row] countryName];
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


-(void)successWithSearchUsers:(NSMutableArray *)_dataArray
{
    [appDelegate stopSpinner];

    if([_dataArray count])
    {
        UsersCommonView *searchList;
        
        if(appDelegate.iPad)
            searchList = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
        else
            searchList = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
        
        searchList.strHeaderTitle = @"Search Result";
        searchList.arrayUserDetails = _dataArray;
        
        [appDelegate.nvc pushViewController:searchList animated:NO];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Record not found" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];

    }

}




@end
