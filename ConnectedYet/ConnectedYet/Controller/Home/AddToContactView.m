//
//  AddToContactView.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "AddToContactView.h"

@interface AddToContactView ()

@end

@implementation AddToContactView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
