//
//  MatrimonyStatusView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomTextView.h"


@interface MatrimonyStatusView : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *textEducationLevel, *textEducationField, *textWorkingWith, *textWorkingAs, *textAnnualIncome, *textFamilyStatus, *textFamilyType;
    
    IBOutlet CustomTextView *textAboutYoueself;
    
}


@end
