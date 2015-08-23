//
//  AboutUsView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "AboutUsView.h"
#import "MVYSideMenuController.h"

@interface AboutUsView ()

@end

@implementation AboutUsView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ----  ----  BUTTON CLICK METHOD ----  -----

-(IBAction)btnBackTapped:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }
    
}


#pragma mark ----  ----  ----  -----


@end
