//
//  HelpViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "HelpViewController.h"
#import "Constant.h"

#import "LoginViewController.h"
#import "SignUpViewController.h"


@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    arrayHelpData = [[NSMutableArray alloc]init];
    
    if(appDelegate.iPad)
    {
        [arrayHelpData addObject:@"help_ipad1"];
        [arrayHelpData addObject:@"help_ipad2"];
        [arrayHelpData addObject:@"help_ipad3"];

    }
    else
    {
        [arrayHelpData addObject:@"help1"];
        [arrayHelpData addObject:@"help2"];
        [arrayHelpData addObject:@"help3"];

    }
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH*[arrayHelpData count], scrollView.frame.size.height);
    
    
    [self setHelpView];
    
}


-(void)setHelpView
{
    int imageWidth = DEVICE_WIDTH;
    int imageHeight;

    
    if(appDelegate.iPad)
        imageHeight = DEVICE_HEIGHT;//-110;
    else
        imageHeight = DEVICE_HEIGHT;//-40;

    
    int xPos = 0;
    
    for(int i=0; i<[arrayHelpData count]; i++)
    {
        CGSize currentSize = CGSizeMake(imageWidth, imageHeight);
        
        UIImage *test = [appDelegate imageByScalingAndCroppingForSize:currentSize SourceImage:[UIImage imageNamed:[arrayHelpData objectAtIndex:i]]];

        UIImageView *imageHelp = [[UIImageView alloc]init];
        imageHelp.frame = CGRectMake(xPos, 0, imageWidth, imageHeight);
        imageHelp.image = test;
        imageHelp.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageHelp];
        
        xPos+=imageWidth;
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnLoginTapped:(id)sender
{
    LoginViewController *login;
    
    if(appDelegate.iPad)
        login = [[LoginViewController alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
    else
        login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];

    [self.navigationController pushViewController:login animated:YES];

}


-(IBAction)btnSignUpTapped:(id)sender
{
    SignUpViewController *signup;
    
    if(appDelegate.iPad)
        signup = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController_iPad" bundle:nil];
    else
        signup = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:signup animated:YES];
    

}

#pragma mark -- --- --- --- ---
#pragma mark --- ---  SCROLLVIEW DELEGATE --- ---

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    
    NSUInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}

#pragma mark -- --- --- --- ---


@end
