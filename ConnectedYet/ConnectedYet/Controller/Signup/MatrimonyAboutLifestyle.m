//
//  MatrimonyAboutLifestyle.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyAboutLifestyle.h"
#import "AboutYourValues.h"
#import "Constant.h"

#import "CustomAlertView.h"

#define kCellHeightiPad 50
#define kCellHeightiPhone 44

int static kSmoke = 0;
int static kDrink = 1;

int static kExercise = 2;
int static kEduLevel = 3;


@interface MatrimonyAboutLifestyle ()

@end

@implementation MatrimonyAboutLifestyle

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self setSelectLanguageView];
    
    selectedSmokeId = @"";
    selectedDrinkId = @"";
    selectedExerciseId = @"";
    selectedEducationLevelId = @"";
    
    arraySmoke = appDelegate.dropDownObject.arraySmoke;
    arrayDrink = appDelegate.dropDownObject.arrayDrink;

    arrayExercise = appDelegate.dropDownObject.arrayExcersize;
    arrayEducationLevel = appDelegate.dropDownObject.arrayEductionLevel;

    arraySportExercise = appDelegate.dropDownObject.arraySportExercise;
    arrayLanguageSpeak = appDelegate.dropDownObject.arrayLanguageSpeak;
    arrayEthnicity = appDelegate.dropDownObject.arrayEthnicity;
  
    
    arraySelectedSportExercise = [[NSMutableArray alloc] init];
    for(int i=0; i<[arraySportExercise count]; i++)
        [arraySelectedSportExercise addObject:@"0"];
    
    arraySelectedLangSpeak = [[NSMutableArray alloc] init];
    for(int i=0; i<[arrayLanguageSpeak count]; i++)
        [arraySelectedLangSpeak addObject:@"0"];

    arraySelectedEthnicity = [[NSMutableArray alloc] init];
    for(int i=0; i<[arrayEthnicity count]; i++)
        [arraySelectedEthnicity addObject:@"0"];

    
    [self setSportExerciseOption];
    [self setLanguageSpeak];
    [self setEthnicityOptions];
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textSmoke.leftView = paddingView;
    textSmoke.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textDrink.leftView = paddingView;
    textDrink.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textExercise.leftView = paddingView;
    textExercise.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEduLevel.leftView = paddingView;
    textEduLevel.leftViewMode = UITextFieldViewModeAlways;


    if(appDelegate.iPad)
    {
        
    }
    else
    {
//        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 970);
        
    }
}


-(void)setSportExerciseOption
{
    int xPos;
    int labelWidth = 0;
    
    if(appDelegate.iPad)
    {
        yPos = 250;
        xPos = 60;
        
        labelWidth = (DEVICE_WIDTH-150)/4;
        
    }
    else
    {
        yPos = 335;
        xPos = 20;

    }
    
    for(int i = 0; i<[arraySportExercise count]; i++)
    {
        btnSportExercise = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSportExercise.tag = i + 100;
        [btnSportExercise setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnSportExercise addTarget:self action:@selector(btnSportsExerciseTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnSportExercise];

        
        UILabel *labelSportName = [[UILabel alloc]init];
        labelSportName.text = [[arraySportExercise objectAtIndex:i] name];
        labelSportName.backgroundColor = [UIColor clearColor];
        labelSportName.textColor = [UIColor whiteColor];
        [scrollView addSubview:labelSportName];
        
        
        if(appDelegate.iPad)
        {
            btnSportExercise.frame = CGRectMake(xPos, yPos, 30, 30);
            
            xPos+=40;
            
            labelSportName.frame = CGRectMake(xPos, yPos, labelWidth-40, 30);
            labelSportName.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            xPos+= labelWidth - 30;
            
            if((i+1)%4 == 0)
            {
                xPos = 60;
                yPos+= 40;
            }
            
        }
        else
        {
            btnSportExercise.frame = CGRectMake(xPos, yPos, 24, 24);
            
            xPos+=30;
            
            labelSportName.frame = CGRectMake(xPos, yPos, DEVICE_WIDTH/2 -55, 24);
            labelSportName.font = [UIFont fontWithName:@"Helvetica" size:16];
            
            xPos = DEVICE_WIDTH/2 + 5;
            
            if((i+1)%2 == 0)
            {
                xPos = 20;
                yPos+= 35;
            }
            
        }
        
    }
    
    if(appDelegate.iPad)
    {
        if([arraySportExercise count]%4 == 0)
            yPos+= 20;
        else
            yPos+= 40 + 20;

    }
    else
    {
        if([arraySportExercise count]%2 == 0)
            yPos+= 10;
        else
            yPos+= 35 + 10;

    }
   

    CGRect frame = imageBackgroundDevider1.frame;
    frame.origin.y= yPos;
    imageBackgroundDevider1.frame= frame;

    yPos+= appDelegate.iPad ? 20 : 11;
    
    frame = labelAboutBg.frame;
    frame.origin.y= yPos;
    labelAboutBg.frame= frame;

    yPos+= appDelegate.iPad ? 50 : 40;
    
    frame = imageBackgroundDevider2.frame;
    frame.origin.y= yPos;
    imageBackgroundDevider2.frame= frame;

    yPos+= appDelegate.iPad ? 20 : 11;


    frame = labelEduLevel.frame;
    frame.origin.y= yPos;
    labelEduLevel.frame= frame;

    yPos+= appDelegate.iPad ? 45 : 35;

    frame = textEduLevel.frame;
    frame.origin.y= yPos;
    textEduLevel.frame= frame;
    
    yPos+= appDelegate.iPad ? 55 : 45;
    
    frame = labelLangSpeak.frame;
    frame.origin.y= yPos;
    labelLangSpeak.frame= frame;
    
    yPos+= appDelegate.iPad ? 50 : 40;
    
}

-(void)setLanguageSpeak
{
    int xPos;
    int labelWidth = 0;
    
    if(appDelegate.iPad)
    {
        xPos = 60;
        labelWidth = (DEVICE_WIDTH-150)/4;
    }
    else
    {
        xPos = 20;
        
    }

    
    for(int i = 0; i<[arrayLanguageSpeak count]; i++)
    {
        btnLangSpeak = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLangSpeak.tag = i + 200;
        [btnLangSpeak setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnLangSpeak addTarget:self action:@selector(btnLangSpeakTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnLangSpeak];
        
        
        UILabel *labelLanguage = [[UILabel alloc]init];
        labelLanguage.text = [[arrayLanguageSpeak objectAtIndex:i] name];
        labelLanguage.backgroundColor = [UIColor clearColor];
        labelLanguage.textColor = [UIColor whiteColor];
        [scrollView addSubview:labelLanguage];
        

        if(appDelegate.iPad)
        {
            btnLangSpeak.frame = CGRectMake(xPos, yPos, 30, 30);
            
            xPos+=40;
            
            labelLanguage.frame = CGRectMake(xPos, yPos, labelWidth-40, 30);
            labelLanguage.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            xPos+= labelWidth - 30;
            
            if((i+1)%4 == 0)
            {
                xPos = 60;
                yPos+= 40;
            }
            
        }
        else
        {
            btnLangSpeak.frame = CGRectMake(xPos, yPos, 24, 24);
            
            xPos+=30;
            
            labelLanguage.frame = CGRectMake(xPos, yPos, DEVICE_WIDTH/2 -55, 24);
            labelLanguage.font = [UIFont fontWithName:@"Helvetica" size:16];
            
            xPos = DEVICE_WIDTH/2 + 5;
            
            if((i+1)%2 == 0)
            {
                xPos = 20;
                yPos+= 35;
            }
            
        }
    }
    
    if(appDelegate.iPad)
    {
        if([arrayLanguageSpeak count]%4 == 0)
            yPos+= 20;
        else
            yPos+= 40 + 20;
        
    }
    else
    {
        if([arrayLanguageSpeak count]%2 == 0)
            yPos+= 10;
        else
            yPos+= 35 + 10;
        
    }
    
    
    CGRect frame = labelEthnicity.frame;
    frame.origin.y= yPos;
    labelEthnicity.frame= frame;
   
    yPos+= appDelegate.iPad ? 50 : 40;
    
}


-(void)setEthnicityOptions
{
    int xPos;
    int labelWidth = 0;
    
    if(appDelegate.iPad)
    {
        xPos = 60;
        labelWidth = (DEVICE_WIDTH-150)/4;
    }
    else
    {
        xPos = 20;
        
    }
    
    
    for(int i = 0; i<[arrayEthnicity count]; i++)
    {
        btnEthnicity = [UIButton buttonWithType:UIButtonTypeCustom];
        btnEthnicity.tag = i+300;
        [btnEthnicity setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnEthnicity addTarget:self action:@selector(btnEthnicityTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnEthnicity];
        
        
        UILabel *labelEthnicityName = [[UILabel alloc]init];
        labelEthnicityName.text = [[arrayEthnicity objectAtIndex:i] name];
        labelEthnicityName.backgroundColor = [UIColor clearColor];
        labelEthnicityName.textColor = [UIColor whiteColor];
        [scrollView addSubview:labelEthnicityName];
        
        
        if(appDelegate.iPad)
        {
            btnEthnicity.frame = CGRectMake(xPos, yPos, 30, 30);
            
            xPos+=40;
            
            labelEthnicityName.frame = CGRectMake(xPos, yPos, labelWidth-40, 30);
            labelEthnicityName.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            xPos+= labelWidth - 30;
            
            if((i+1)%4 == 0)
            {
                xPos = 60;
                yPos+= 40;
            }
            
        }
        else
        {
            btnEthnicity.frame = CGRectMake(xPos, yPos, 24, 24);
            
            xPos+=30;
            
            labelEthnicityName.frame = CGRectMake(xPos, yPos, DEVICE_WIDTH/2 -55, 24);
            labelEthnicityName.font = [UIFont fontWithName:@"Helvetica" size:16];
            
            xPos = DEVICE_WIDTH/2 + 5;
            
            if((i+1)%2 == 0)
            {
                xPos = 20;
                yPos+= 35;
            }
            
        }
        
    }
    
    if(appDelegate.iPad)
    {
        if([arrayEthnicity count]%4 == 0)
            yPos+= 20;
        else
            yPos+= 40 + 20;
        
    }
    else
    {
        if([arrayEthnicity count]%2 == 0)
            yPos+= 10;
        else
            yPos+= 35 + 10;
        
    }
    
    
    CGRect frame = btnContinue.frame;
    frame.origin.y= yPos;
    btnContinue.frame= frame;
    
    yPos+= 80;
    
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);
    
}

-(void)btnSportsExerciseTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Sport Exercise Tag :%d", (int)[sender tag]);
#endif
    
    for(id subview in scrollView.subviews)
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            NSLog(@"---  Tag :%d", (int)[subview tag]);
            if([sender tag] == [subview tag])
            {
                int _index = [sender tag]%100;
                if([[arraySelectedSportExercise objectAtIndex:_index] isEqualToString:@"0"])
                {
                    [arraySelectedSportExercise replaceObjectAtIndex:_index withObject:@"1"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
                }
                else
                {
                    [arraySelectedSportExercise replaceObjectAtIndex:_index withObject:@"0"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
                }
                
            }
        }
    }
}


-(void)btnLangSpeakTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Language Tag :%d", (int)[sender tag]);
#endif
    
    for(id subview in scrollView.subviews)
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            NSLog(@"---  Tag :%d", (int)[subview tag]);
            if([sender tag] == [subview tag])
            {
                int _index = [sender tag]%200;
                if([[arraySelectedLangSpeak objectAtIndex:_index] isEqualToString:@"0"])
                {
                    [arraySelectedLangSpeak replaceObjectAtIndex:_index withObject:@"1"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
                }
                else
                {
                    [arraySelectedLangSpeak replaceObjectAtIndex:_index withObject:@"0"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
                }
                
            }
        }
    }
}


-(void)btnEthnicityTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Ethnicity Tag :%d", (int)[sender tag]);
#endif
    
    for(id subview in scrollView.subviews)
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            NSLog(@"---  Tag :%d", (int)[subview tag]);
            if([sender tag] == [subview tag])
            {
                int _index = [sender tag]%300;
                if([[arraySelectedEthnicity objectAtIndex:_index] isEqualToString:@"0"])
                {
                    [arraySelectedEthnicity replaceObjectAtIndex:_index withObject:@"1"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
                }
                else
                {
                    [arraySelectedEthnicity replaceObjectAtIndex:_index withObject:@"0"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
                }
                
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- ----- ----- -----

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnContinueTapped:(id)sender
{
    
    if([MYSBaseProxy isNetworkAvailable])
    {
        [self setMatrimonyAboutLifeStyle];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
    /*
    AboutYourValues *matrimonyValues;
    
    if(appDelegate.iPad)
        matrimonyValues = [[AboutYourValues alloc]initWithNibName:@"AboutYourValues_iPad" bundle:nil];
    else
        matrimonyValues = [[AboutYourValues alloc]initWithNibName:@"AboutYourValues" bundle:nil];
    
    [self.navigationController pushViewController:matrimonyValues animated:YES];
    */
    
}

-(void)setMatrimonyAboutLifeStyle
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
    
    if(selectedSmokeId.length != 0)
        [dataDict setObject:selectedSmokeId forKey:@"smoke"];
    else
        [dataDict setObject:@"" forKey:@"smoke"];
    
    if(selectedDrinkId.length != 0)
        [dataDict setObject:selectedDrinkId forKey:@"drink"];
    else
        [dataDict setObject:@"" forKey:@"drink"];

    if(selectedExerciseId.length != 0)
        [dataDict setObject:selectedExerciseId forKey:@"excersize"];
    else
        [dataDict setObject:@"" forKey:@"excersize"];

    if(selectedEducationLevelId.length != 0)
        [dataDict setObject:selectedEducationLevelId forKey:@"edu_level"];
    else
        [dataDict setObject:@"" forKey:@"edu_level"];

//-----
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for(int i=0; i<[arraySelectedSportExercise count]; i++)
    {
        if([[arraySelectedSportExercise objectAtIndex:i] isEqualToString:@"1"])
            [data addObject:[[arraySportExercise objectAtIndex:i] Id]];
        
    }
    
        [dataDict setObject:data forKey:@"excersize_sport"];

    [data removeAllObjects];
    for(int i=0; i<[arraySelectedLangSpeak count]; i++)
    {
        if([[arraySelectedLangSpeak objectAtIndex:i] isEqualToString:@"1"])
            [data addObject:[[arrayLanguageSpeak objectAtIndex:i] Id]];
        
    }
    
    [dataDict setObject:data forKey:@"lang_speak"];

   
    
    [data removeAllObjects];
    for(int i=0; i<[arraySelectedEthnicity count]; i++)
    {
        if([[arraySelectedEthnicity objectAtIndex:i] isEqualToString:@"1"])
            [data addObject:[[arrayEthnicity objectAtIndex:i] Id]];
        
    }
    
    [dataDict setObject:data forKey:@"ethnicity"];

    
    [loginManager setMatrimonyAboutLifeStyle:dataDict];

}

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(textField == textSmoke)
    {
        selectedType = kSmoke;
        arrayData = arraySmoke;
        [self showLanguageView];
        
    }
    else if(textField == textDrink)
    {
        selectedType = kDrink;
        arrayData = arrayDrink;
        [self showLanguageView];
        
    }
    else if(textField == textExercise)
    {
        selectedType = kExercise;
        arrayData = arrayExercise;
        [self showLanguageView];
        
    }
    else if(textField == textEduLevel)
    {
        selectedType = kEduLevel;
        arrayData = arrayEducationLevel;
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textSmoke.frame.size.width, 0) style:UITableViewStylePlain];
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
    if(selectedType == kSmoke)
    {
        textSmoke.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedSmokeId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kDrink)
    {
        textDrink.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedDrinkId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kExercise)
    {
        textExercise.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedExerciseId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
    }
    else if(selectedType == kEduLevel)
    {
        textEduLevel.text = [[arrayData objectAtIndex:indexPath.row] name];
        selectedEducationLevelId = [NSString stringWithFormat:@"%@", [[arrayData objectAtIndex:indexPath.row] Id]];
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

-(void)successWithMatrimonyAboutLifestyle:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        AboutYourValues *matrimonyValues;
        
        if(appDelegate.iPad)
            matrimonyValues = [[AboutYourValues alloc]initWithNibName:@"AboutYourValues_iPad" bundle:nil];
        else
            matrimonyValues = [[AboutYourValues alloc]initWithNibName:@"AboutYourValues" bundle:nil];
        
        [self.navigationController pushViewController:matrimonyValues animated:YES];

    };
    
}


@end
