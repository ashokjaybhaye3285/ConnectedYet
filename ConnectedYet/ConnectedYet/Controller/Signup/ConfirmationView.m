



#import "ConfirmationView.h"
#import "VerificationViewController.h"

@interface ConfirmationView ()

@end

@implementation ConfirmationView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnEmailTapped:(id)sender
{
    VerificationViewController *verify;
    
    if(appDelegate.iPad)
        verify = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController_iPad" bundle:nil];
    else
        verify = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];
    
    verify.otpType = @"Email";
    
    [self.navigationController pushViewController:verify animated:YES];
    
}

-(IBAction)btnPhoneTapped:(id)sender
{
    VerificationViewController *verify;
    
    if(appDelegate.iPad)
        verify = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController_iPad" bundle:nil];
    else
        verify = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];

    verify.otpType = @"Phone";
    
    [self.navigationController pushViewController:verify animated:YES];
    
}

@end
