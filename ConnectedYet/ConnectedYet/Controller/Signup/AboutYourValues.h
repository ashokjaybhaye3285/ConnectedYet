//
//  AboutYourValues.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomTextView.h"

#import "LoginManager.h"
#import "MyScrollView.h"

@interface AboutYourValues : UIViewController <LoginManagerDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet MyScrollView *scrollView;
    

    IBOutlet CustomTextView *textAboutYourself;    
    IBOutlet UITextField *textReligiousBefiefs, *textCurrentField;
    
    
    IBOutlet UILabel *labelAboutYourself;
    IBOutlet UIButton *btnContinue;
    UIButton *btnMovies;
    NSMutableArray *arrayMovies, *arrayReligiousBelief;
    NSMutableArray *arraySelectedMovies;
    
    int yPos;
    
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    NSString *selectedReligiousBeliefId;

}

@end
