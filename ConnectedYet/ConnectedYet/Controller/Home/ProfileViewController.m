//
//  ProfileViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "ProfileViewController.h"
#import "Constant.h"

#import "EmailSignUpView.h"
#import "LoginDetailsView.h"

#import "DatingStatusView.h"
#import "MatrimonyMatchView.h"

#define iPhoneFont [UIFont fontWithName:@"Helvetica" size:14]
#define iPadFont [UIFont fontWithName:@"Helvetica" size:16]

@interface ProfileViewController ()

@end

@implementation ProfileViewController


-(void)initWithUsersDetails:(UsersData *)_usersDetails
{
    usersDetailsObject = _usersDetails;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if([appDelegate.userDetails.userId intValue] == [usersDetailsObject.userId intValue])
        btnEdit.hidden = NO;
    else
        btnEdit.hidden = YES;

    imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2;
    imageProfile.layer.masksToBounds = YES;
    
    imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    imageProfile.layer.borderWidth = 2.5;
    
    
    imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [imageProfile loadImageFromURL:usersDetailsObject.userProfileBig];
    
    NSString *strName = [NSString stringWithFormat:@"%@ %@", usersDetailsObject.userFirstName, usersDetailsObject.userLastName];
    
    strName = [strName stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(strName.length ==0)
        strName = usersDetailsObject.userName;
    
    labelUserName.text = strName;
    
    labelUserGender.text = [NSString stringWithFormat:@"%@, %@", usersDetailsObject.userAge, [appDelegate getGender:usersDetailsObject.userGender]];
    labelDistance.text = usersDetailsObject.userDistance;
    
    
    labelMessage.text = usersDetailsObject.userBiography; //usersDetailsObject.usermes
    
    labelLocation.text = [NSString stringWithFormat:@"%@ %@", usersDetailsObject.userCity, usersDetailsObject.userState]; //usersDetailsObject.user
    labelRelStatus.text = usersDetailsObject.userRelStatus;
    labelSexuality.text = usersDetailsObject.userInterest; //usersDetailsObject.user
    labelHeight.text = usersDetailsObject.userHeight;
    labelSmoking.text = usersDetailsObject.userSmoke; //usersDetailsObject.usersm
    labelDrinking.text = usersDetailsObject.userDrink; //usersDetailsObject.user
    
    labelEducation.text = usersDetailsObject.userEducation; //usersDetailsObject.usere
    labelLanguage.text = usersDetailsObject.userPreferedLang;
    
    float _width = labelMessage.frame.size.width;
    NSString *strBiography = usersDetailsObject.userBiography;
    
    float _height = [appDelegate heightOfString:strBiography withFont:appDelegate.iPad ? iPadFont : iPhoneFont labelWidth:_width];
    
    CGRect newFrame = labelMessage.frame;
    newFrame.size.height = _height+1;
    labelMessage.frame = newFrame;

    newFrame = viewDetails.frame;
    newFrame.origin.y = labelMessage.frame.origin.y + _height + 5;
    viewDetails.frame = newFrame;

    if(!appDelegate.iPad)
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 400);
    
    //if([[UIScreen mainScreen] bounds].size.height == 480)
       // btnBack.frame = CGRectMake(24, 435, 280, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnEditProfileTapped
{
#if DEBUG
    NSLog(@"User Interest :%@",appDelegate.userDetails.userInterest);
#endif
    
    viewEditViewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH , DEVICE_HEIGHT)];
    viewEditViewBg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewEditViewBg];

    UIView *viewTransparent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH , DEVICE_HEIGHT)];
    viewTransparent.backgroundColor = [UIColor blackColor];
    viewTransparent.alpha = 0.4;
    [viewEditViewBg addSubview:viewTransparent];

    
    viewEditView = [[UIView alloc]init];
    viewEditView.backgroundColor = [UIColor whiteColor];
    viewEditView.layer.cornerRadius = 10.0;
    viewEditView.alpha = 0.0;
    [viewEditViewBg addSubview:viewEditView];
    
    [viewEditView addSubview:btnPersonalDetails];
    [viewEditView addSubview:btnLoginDetails];
    [viewEditView addSubview:btnCancel];
    
    if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
    {
        [viewEditView addSubview:btnProfileDetails];
    }
    else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
    {
        [viewEditView addSubview:btnProfileDetails];
    }

    
    int space = 20;
    int btnHeight = 40;
    
    
    if(appDelegate.iPad)
    {
        btnHeight = 45;
        
        if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
        {
            viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, DEVICE_HEIGHT, 500 , 215);
            
            btnCancel.frame = CGRectMake(50, 3*space+btnHeight+btnHeight, viewEditView.frame.size.width-100, btnHeight);
        }
        else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
        {
            viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, DEVICE_HEIGHT, 500 , 280);
            
            btnProfileDetails.frame = CGRectMake(50, 3*space+btnHeight*2, viewEditView.frame.size.width-100, btnHeight);

            btnCancel.frame = CGRectMake(50, 4*space+btnHeight*3, viewEditView.frame.size.width-100, btnHeight);
        }
        else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
        {
            viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, DEVICE_HEIGHT, 500 , 280);
            
            btnProfileDetails.frame = CGRectMake(50, 3*space+btnHeight*2, viewEditView.frame.size.width-100, btnHeight);
            
            btnCancel.frame = CGRectMake(50, 4*space+btnHeight*3, viewEditView.frame.size.width-100, btnHeight);
        }
            

        btnLoginDetails.frame = CGRectMake(50, space, viewEditView.frame.size.width-100, btnHeight);
        btnPersonalDetails.frame = CGRectMake(50, 2*space+btnHeight, viewEditView.frame.size.width-100, btnHeight);

    }
    else
    {
        if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
        {
            viewEditView.frame = CGRectMake(30, DEVICE_HEIGHT, DEVICE_WIDTH-60 , 200);
        
            btnCancel.frame = CGRectMake(20, 3*space+btnHeight+btnHeight, viewEditView.frame.size.width-40, btnHeight);
        }
        else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
        {
            viewEditView.frame = CGRectMake(30, DEVICE_HEIGHT, DEVICE_WIDTH-60 , 280);

            btnProfileDetails.frame = CGRectMake(20, 3*space+btnHeight*2, viewEditView.frame.size.width-40, btnHeight);

            btnCancel.frame = CGRectMake(20, 4*space+btnHeight*3, viewEditView.frame.size.width-40, btnHeight);
        }
        else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
        {
            viewEditView.frame = CGRectMake(30, DEVICE_HEIGHT, DEVICE_WIDTH-60 , 280);
            
            btnProfileDetails.frame = CGRectMake(20, 3*space+btnHeight*2, viewEditView.frame.size.width-40, btnHeight);
            
            btnCancel.frame = CGRectMake(20, 4*space+btnHeight*3, viewEditView.frame.size.width-40, btnHeight);
        }
            
        
        btnLoginDetails.frame = CGRectMake(20, space, viewEditView.frame.size.width-40, btnHeight);
        btnPersonalDetails.frame = CGRectMake(20, 2*space+btnHeight, viewEditView.frame.size.width-40, btnHeight);

    }
    

    [UIView animateWithDuration:0.4 animations:^()
     {
         if(appDelegate.iPad)
         {
             if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, (DEVICE_HEIGHT-215)/2, 500 , 215);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, (DEVICE_HEIGHT-280)/2, 500 , 280);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, (DEVICE_HEIGHT-280)/2, 500 , 280);

         }
         else
         {
             if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
                 viewEditView.frame = CGRectMake(30, (DEVICE_HEIGHT-200)/2, DEVICE_WIDTH-60 , 200);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
                 viewEditView.frame = CGRectMake(30, (DEVICE_HEIGHT-260)/2, DEVICE_WIDTH-60 , 260);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
                 viewEditView.frame = CGRectMake(30, (DEVICE_HEIGHT-260)/2, DEVICE_WIDTH-60 , 260);

             
         }

         viewEditView.alpha = 1.0;

     }];
    
}


-(IBAction)btnPersonalDetailsTapped
{
    EmailSignUpView *persinalDetails;
    
    if(appDelegate.iPad)
        persinalDetails = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView_iPad" bundle:nil];
    else
        persinalDetails = [[EmailSignUpView alloc]initWithNibName:@"EmailSignUpView" bundle:nil];
    
    [persinalDetails isCommingForEditProfile:YES];
    [self.navigationController pushViewController:persinalDetails animated:YES];

    [self removeEditView];

}


-(IBAction)btnLoginDetailsTapped
{
    LoginDetailsView *loginDetails;
    
    if(appDelegate.iPad)
        loginDetails = [[LoginDetailsView alloc]initWithNibName:@"LoginDetailsView_iPad" bundle:nil ];
    else
        loginDetails = [[LoginDetailsView alloc]initWithNibName:@"LoginDetailsView" bundle:nil ];
    
    [loginDetails initWithIsEditProfile:YES];
    [self.navigationController pushViewController:loginDetails animated:YES];

    [self removeEditView];

}


-(IBAction)btnProfileDetailsTapped
{
    if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
    {
        DatingStatusView *dating;
        
        if(appDelegate.iPad)
            dating = [[DatingStatusView alloc]initWithNibName:@"DatingStatusView_iPad" bundle:nil];
        else
            dating = [[DatingStatusView alloc]initWithNibName:@"DatingStatusView" bundle:nil];
        
        [dating isForEdit:YES];
        [self.navigationController pushViewController:dating animated:YES];

    }
    else
    {
        MatrimonyMatchView *matrimonyMatch;
        
        if(appDelegate.iPad)
            matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView_iPad" bundle:nil];
        else
            matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView" bundle:nil];
        
        matrimonyMatch.isCommingFromMatrimony = YES;
        [self.navigationController pushViewController:matrimonyMatch animated:YES];

    }
   
    [self removeEditView];

}


-(IBAction)btnCancelTapped
{
    [UIView animateWithDuration:0.4 animations:^()
     {
         if(appDelegate.iPad)
         {
             if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, -200, 500 , 215);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, -280, 500 , 280);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
                 viewEditView.frame = CGRectMake((DEVICE_WIDTH-500)/2, -280, 500 , 280);


         }
         else
         {
             if([appDelegate.userDetails.userInterest isEqualToString:@"chatting"])
                 viewEditView.frame = CGRectMake(30, -200, DEVICE_WIDTH-60 , 200);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"datting"])
                 viewEditView.frame = CGRectMake(30, -260, DEVICE_WIDTH-60 , 260);
             else if([appDelegate.userDetails.userInterest isEqualToString:@"matrimony"])
                 viewEditView.frame = CGRectMake(30, -260, DEVICE_WIDTH-60 , 260);


         }

         viewEditView.alpha = 0.0;

     }completion:^(BOOL finish)
     {
         if(finish)
             [self removeEditView];
             
    }];
    
}

-(void)removeEditView
{
    [viewEditViewBg removeFromSuperview];

}

@end
