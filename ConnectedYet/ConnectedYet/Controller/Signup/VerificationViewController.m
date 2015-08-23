//
//  VerificationViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 27/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "VerificationViewController.h"
#import "InterestViewController.h"

#import "CustomAlertView.h"

@interface VerificationViewController ()

@end

@implementation VerificationViewController

@synthesize otpType;

-(id)init
{
    if ([super init])
    {
        
        //type = _type;
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textOTP.leftView = paddingView;
    textOTP.leftViewMode = UITextFieldViewModeAlways;

    
    labelVerification.text = [NSString stringWithFormat:@"We have sent you OTP to your %@. \nPlease add it in below to verify your account.",otpType];
    
    
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
    [textOTP resignFirstResponder];
    
    if(textOTP.text.length !=0)
    {
        if([MYSBaseProxy isNetworkAvailable])
        {
            [appDelegate startSpinner];
            
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
            
            [dataDict setObject:textOTP.text forKey:@"opt"];
            
            [loginManager verifyYourOTP:dataDict];
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
            
        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"enter_otp", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    /*
    InterestViewController *interest;
    
    if(appDelegate.iPad)
        interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController_iPad" bundle:nil];
    else
        interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];

    [self.navigationController pushViewController:interest animated:YES];
    */
}


#pragma mark -- -- -- --
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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

#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}


-(void)successWithOTP:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

    alert.rightBlock = ^()
    {
        InterestViewController *interest;
        
        if(appDelegate.iPad)
            interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController_iPad" bundle:nil];
        else
            interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];
        
        [self.navigationController pushViewController:interest animated:YES];

    };
    
}

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

@end
