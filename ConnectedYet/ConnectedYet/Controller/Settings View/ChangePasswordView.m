//
//  ChangePasswordView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 18/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "ChangePasswordView.h"
#import "CustomAlertView.h"

@interface ChangePasswordView ()

@end

@implementation ChangePasswordView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textCurrentPass.leftView = paddingView;
    textCurrentPass.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textNewPass.leftView = paddingView;
    textNewPass.leftViewMode = UITextFieldViewModeAlways;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textConfirmPass.leftView = paddingView;
    textConfirmPass.leftViewMode = UITextFieldViewModeAlways;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark ----  ----  BUTTON CLICK METHOD ----  -----

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnChangePasswordTapped:(id)sender
{
    if(textCurrentPass.text.length != 0)
    {
        if(textNewPass.text.length != 0)
        {
            if(textConfirmPass.text.length != 0)
            {
                if([textNewPass.text isEqualToString:textConfirmPass.text])
                {
                    if([MYSBaseProxy isNetworkAvailable])
                    {
                        [self changePassword];
                    }
                    else
                    {
                        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                        [alert show];
                        
                    }
                    
                }
                else
                {
                    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"New password and confirm password should be same." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                    [alert show];
                }
            }
            else
            {
                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter confirm password." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
                [alert show];
            }
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter new password." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter current password." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

-(void)changePassword
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:textCurrentPass.text forKey:@"current_password"];
    [dataDict setObject:textNewPass.text forKey:@"new_password"];
    [dataDict setObject:textConfirmPass.text forKey:@"confirm_new_password"];

    [loginManager changePasswordForLoginUser:dataDict];


}


#pragma mark ----  ----  ----  ----
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

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}


-(void)successWithChangePassword:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock =^()
    {
        [self.navigationController popViewControllerAnimated:YES];

    };
    
}

@end
