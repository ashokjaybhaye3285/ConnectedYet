//
//  MatrimonyStatusView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MatrimonyStatusView.h"

#import "Constant.h"

@interface MatrimonyStatusView ()

@end

@implementation MatrimonyStatusView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(appDelegate.iPad)
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1000);
    else
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 900);
    
    textAboutYoueself.placeholder = @"About Yourself";
    textAboutYoueself.layer.cornerRadius = 6.0;


    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEducationLevel.leftView = paddingView;
    textEducationLevel.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textEducationField.leftView = paddingView;
    textEducationField.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textWorkingWith.leftView = paddingView;
    textWorkingWith.leftViewMode = UITextFieldViewModeAlways;
  
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textWorkingAs.leftView = paddingView;
    textWorkingAs.leftViewMode = UITextFieldViewModeAlways;
  
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textAnnualIncome.leftView = paddingView;
    textAnnualIncome.leftViewMode = UITextFieldViewModeAlways;
  
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textFamilyStatus.leftView = paddingView;
    textFamilyStatus.leftViewMode = UITextFieldViewModeAlways;
  
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textFamilyType.leftView = paddingView;
    textFamilyType.leftViewMode = UITextFieldViewModeAlways;
    
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
    [appDelegate saveCustomObject:appDelegate.tempObject];

    [appDelegate navigateToHomeViewController];

}


@end
