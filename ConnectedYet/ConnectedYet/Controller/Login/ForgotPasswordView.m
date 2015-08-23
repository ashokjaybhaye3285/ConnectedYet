//
//  ForgotPasswordView.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 28/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "ForgotPasswordView.h"
#import "CustomAlertView.h"

@interface ForgotPasswordView ()

@end

@implementation ForgotPasswordView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textEmailAdd.leftView = paddingView;
    textEmailAdd.leftViewMode = UITextFieldViewModeAlways;
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnSendPasswordTap:(id)sender
{
    if(textEmailAdd.text.length != 0)
    {
        if([MYSBaseProxy isNetworkAvailable])
        {
            [appDelegate startSpinner];
            
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
            
            [dataDict setObject:textEmailAdd.text forKey:@"username"];
            
            [loginManager getPasswordForLoginUser:dataDict];
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
            [alert show];
            
        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please enter email id." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

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

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successWithResetForgotPassword:(NSString *)_message
{
    [appDelegate stopSpinner];
    
#if DEBUG
    NSLog(@"-- Reset Password :%@", appDelegate.userDetails.userId);
#endif
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock =^()
    {
        [self.navigationController popViewControllerAnimated:YES];

    };
    
}

@end
