



#import "InterestViewController.h"
#import "HomeViewController.h"

//#import "StatusViewController.h"
#import "MatrimonyPersonalInfo.h"
#import "DatingStatusView.h"

#import "CustomAlertView.h"

@interface InterestViewController ()

@end

@implementation InterestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    selectedInterest = -1;
    
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnInterestedInTapped:(id)sender
{
    labelNoWorries.hidden = NO;
    labelNoWorries.layer.cornerRadius = 4.0;
    labelNoWorries.layer.masksToBounds = 25;

    selectedInterest = (int)[sender tag];
    
    if([sender tag] == 0)
    {
        [btnNext setTitle:@"Login" forState:UIControlStateNormal];
        
        NSLog(@"-- Chatting --");
        if(appDelegate.iPad)
        {
            [btnChatting setImage:[UIImage imageNamed:@"ipad-chatting-icon-hover"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"ipad-dating-icon"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"ipad-matrimony-icon"] forState:UIControlStateNormal];
        }
        else
        {
            [btnChatting setImage:[UIImage imageNamed:@"chatting-icon-hover"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"dating-icon"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"matrimony-icon"] forState:UIControlStateNormal];
        }
        
        
        
    }
    else if([sender tag] == 1)
    {
        NSLog(@"-- Dating --");
     
        [btnNext setTitle:@"Next" forState:UIControlStateNormal];

        if(appDelegate.iPad)
        {
            [btnChatting setImage:[UIImage imageNamed:@"ipad-chatting-icon"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"ipad-dating-icon-hover"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"ipad-matrimony-icon"] forState:UIControlStateNormal];
        }
        else
        {
            [btnChatting setImage:[UIImage imageNamed:@"chatting-icon"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"dating-icon-hover"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"matrimony-icon"] forState:UIControlStateNormal];
        }

    }
    else
    {
        NSLog(@"-- Matrimony --");
        
        [btnNext setTitle:@"Next" forState:UIControlStateNormal];

        if(appDelegate.iPad)
        {
            [btnChatting setImage:[UIImage imageNamed:@"ipad-chatting-icon"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"ipad-dating-icon"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"ipad-matrimony-icon-hover"] forState:UIControlStateNormal];
        }
        else
        {
            [btnChatting setImage:[UIImage imageNamed:@"chatting-icon"] forState:UIControlStateNormal];
            [btnDating setImage:[UIImage imageNamed:@"dating-icon"] forState:UIControlStateNormal];
            [btnMatrimony setImage:[UIImage imageNamed:@"matrimony-icon-hover"] forState:UIControlStateNormal];
        }
        
    }
    
    
}


-(IBAction)btnNextTapped:(id)sender
{
    
    if(selectedInterest != -1)
    {
        [self updateSelectInterest];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please select your interest." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }

    //HomeViewController *home = [[HomeViewController alloc]init];
    //[self.navigationController pushViewController:home animated:YES];
    
}

-(void)updateSelectInterest
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSMutableDictionary *dataDict =[[NSMutableDictionary alloc]init];
        
        NSString *strInt = @"";
        
        if(selectedInterest == 0)
            strInt = @"chatting";
        else if(selectedInterest == 1)
            strInt = @"datting";
        else
            if(selectedInterest == 2)
            strInt = @"matrimony";
        
        [dataDict setObject:strInt forKey:@"interest"];
        
        [loginManager addInterestAgainstUser:dataDict];

        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
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

-(void)successfullyAddInterest:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        if(selectedInterest == 0) //chatting
        {
            [UIView animateWithDuration:0.5f animations:^{
                
                appDelegate.tempObject.userInterest = @"chatting";
                
                [appDelegate saveCustomObject:appDelegate.tempObject];
                
                [appDelegate navigateToHomeViewController];
                
            } completion:^(BOOL finished) {
            }];

        }
        else if(selectedInterest == 1) //datting
        {
            appDelegate.tempObject.userInterest = @"datting";

            DatingStatusView *dating;
            
            if(appDelegate.iPad)
                dating = [[DatingStatusView alloc]initWithNibName:@"DatingStatusView_iPad" bundle:nil];
            else
                dating = [[DatingStatusView alloc]initWithNibName:@"DatingStatusView" bundle:nil];
            
            [dating isForEdit:NO];
            [self.navigationController pushViewController:dating animated:YES];
            
        }
        else // matrimony
        {
            appDelegate.tempObject.userInterest = @"matrimony";

            MatrimonyPersonalInfo *matrimony;
            
            if(appDelegate.iPad)
                matrimony = [[MatrimonyPersonalInfo alloc]initWithNibName:@"MatrimonyPersonalInfo_iPad" bundle:nil];
            else
                matrimony = [[MatrimonyPersonalInfo alloc]initWithNibName:@"MatrimonyPersonalInfo" bundle:nil];
            
            [self.navigationController pushViewController:matrimony animated:YES];
            
        }

    };
    
}

@end
