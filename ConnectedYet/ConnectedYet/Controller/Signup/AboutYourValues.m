//
//  AboutYourValues.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "AboutYourValues.h"
#import "MatrimonyMatchView.h"
#import "Constant.h"

#import "CustomAlertView.h"


#define kCellHeightiPad 50
#define kCellHeightiPhone 44


@interface AboutYourValues ()

@end

@implementation AboutYourValues

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   
    textAboutYourself.placeholder = @"About yourself";
    
    textAboutYourself.layer.cornerRadius = 6.0;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textReligiousBefiefs.leftView = paddingView;
    textReligiousBefiefs.leftViewMode = UITextFieldViewModeAlways;
    
    arrayReligiousBelief = appDelegate.dropDownObject.arrayReligion;
    
    arrayMovies = appDelegate.dropDownObject.arrayMovies;
    
    arraySelectedMovies = [[NSMutableArray alloc] init];
    for(int i=0; i<[arrayMovies count]; i++)
        [arraySelectedMovies addObject:@"0"];

    [self setSelectLanguageView];

    [self setMoviesOptions];
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 520);

    
}


-(void)setMoviesOptions
{
    int xPos;
    int labelWidth = 0;
    
    if(appDelegate.iPad)
    {
        yPos = 155;
        xPos = 60;
        
        labelWidth = (DEVICE_WIDTH-150)/4;
        
    }
    else
    {
        yPos = 130;
        xPos = 20;
        
    }
    
    for(int i = 0; i<[arrayMovies count]; i++)
    {
        btnMovies= [UIButton buttonWithType:UIButtonTypeCustom];
        btnMovies.tag = i + 100;
        [btnMovies setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        [btnMovies addTarget:self action:@selector(btnMoviesTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnMovies];
        
        
        UILabel *labelMovies = [[UILabel alloc]init];
        labelMovies.text = [[arrayMovies objectAtIndex:i] name];
        labelMovies.backgroundColor = [UIColor clearColor];
        labelMovies.textColor = [UIColor whiteColor];
        labelMovies.font = [UIFont fontWithName:@"Helvetica" size:16];
        [scrollView addSubview:labelMovies];
        
        if(appDelegate.iPad)
        {
            btnMovies.frame = CGRectMake(xPos, yPos, 30, 30);
            
            xPos+=40;
            
            labelMovies.frame = CGRectMake(xPos, yPos, labelWidth-40, 30);
            labelMovies.font = [UIFont fontWithName:@"Helvetica" size:18];
            
            xPos+= labelWidth - 30;
            
            if((i+1)%4 == 0)
            {
                xPos = 60;
                yPos+= 40;
            }
            
        }
        else
        {
            btnMovies.frame = CGRectMake(xPos, yPos, 24, 24);
            
            xPos+=30;
            
            labelMovies.frame = CGRectMake(xPos, yPos, DEVICE_WIDTH/2 -55, 24);
            labelMovies.font = [UIFont fontWithName:@"Helvetica" size:16];
            
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
        if([arrayMovies count]%4 == 0)
            yPos+= 20;
        else
            yPos+= 40 + 20;
        
    }
    else
    {
        if([arrayMovies count]%2 == 0)
            yPos+= 10;
        else
            yPos+= 35 + 10;
        
    }
    
    CGRect frame = labelAboutYourself.frame;
    frame.origin.y= yPos;
    labelAboutYourself.frame= frame;
    
    yPos+= appDelegate.iPad ? 50 : 40;
    
    frame = textAboutYourself.frame;
    frame.origin.y= yPos;
    textAboutYourself.frame= frame;
    
    yPos+= appDelegate.iPad ? 160 : 150;
    
    frame = btnContinue.frame;
    frame.origin.y= yPos;
    btnContinue.frame= frame;

    yPos+= appDelegate.iPad ? 90 : 80;

    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);

}


-(void)btnMoviesTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Movies Tag :%d", (int)[sender tag]);
#endif
    
    for(id subview in scrollView.subviews)
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            NSLog(@"---  Tag :%d", (int)[subview tag]);
            if([sender tag] == [subview tag])
            {
                int _index = [sender tag]%100;
                if([[arraySelectedMovies objectAtIndex:_index] isEqualToString:@"0"])
                {
                    [arraySelectedMovies replaceObjectAtIndex:_index withObject:@"1"];
                    [subview setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
                }
                else
                {
                    [arraySelectedMovies replaceObjectAtIndex:_index withObject:@"0"];
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


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)btnContinueTapped:(id)sender
{
    [textAboutYourself resignFirstResponder];
    
    textAboutYourself.text = [textAboutYourself.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
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
    MatrimonyMatchView *matrimonyMatch;
    
    if(appDelegate.iPad)
        matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView_iPad" bundle:nil];
    else
        matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView" bundle:nil];
    
    matrimonyMatch.isCommingFromMatrimony = YES;
    [self.navigationController pushViewController:matrimonyMatch animated:YES];
    */
}

-(void)setMatrimonyAboutLifeStyle
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
    
    if(selectedReligiousBeliefId.length != 0)
    [dataDict setObject:selectedReligiousBeliefId forKey:@"religion"];
    else
        [dataDict setObject:@"" forKey:@"religion"];
    
    if(textAboutYourself.text.length != 0)
        [dataDict setObject:textAboutYourself.text forKey:@"biography"];
    else
    [dataDict setObject:@"" forKey:@"biography"];

    NSMutableArray *data = [[NSMutableArray alloc] init];
    for(int i=0; i<[arraySelectedMovies count]; i++)
    {
        if([[arraySelectedMovies objectAtIndex:i] isEqualToString:@"1"])
            [data addObject:[[arrayMovies objectAtIndex:i] Id]];
        
    }
    
    [dataDict setObject:data forKey:@"movies"];

    [loginManager setMatrimonyAboutValues:dataDict];
    
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
    
    
    tablePrimaryLanguage = [[UITableView alloc]initWithFrame:CGRectMake(20, 205, textReligiousBefiefs.frame.size.width, 0) style:UITableViewStylePlain];
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
    return [arrayReligiousBelief count];
    
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
    
    labelName.text = [NSString stringWithFormat:@"%@",[[arrayReligiousBelief objectAtIndex:indexPath.row] name]];
    
    
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
    //if(selectedType == kSmoke)
    {
        textReligiousBefiefs.text = [[arrayReligiousBelief objectAtIndex:indexPath.row] name];
        selectedReligiousBeliefId = [NSString stringWithFormat:@"%@", [[arrayReligiousBelief objectAtIndex:indexPath.row] Id]];
    }
    
    [self hideLanguageView];
    
}


#pragma mark -----  ----- ----- -----

#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textCurrentField = textField;
    
    if(textField == textReligiousBefiefs)
    {
        //selectedType = kSmoke;
        //arrayData = arraySmoke;
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

#pragma mark -----   -----   -----   ----

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(!appDelegate.iPad)
        [scrollView setContentOffset:CGPointMake(0, 230) animated:YES];
    
    return YES;
    
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

-(void)successWithMatrimonyAboutValues:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        MatrimonyMatchView *matrimonyMatch;
        
        if(appDelegate.iPad)
            matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView_iPad" bundle:nil];
        else
            matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView" bundle:nil];
        
        matrimonyMatch.isCommingFromMatrimony = YES;
        [self.navigationController pushViewController:matrimonyMatch animated:YES];

    };
    
}



@end
