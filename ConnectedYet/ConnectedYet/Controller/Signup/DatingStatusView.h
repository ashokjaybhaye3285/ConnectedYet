//
//  DatingStatusView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomTextView.h"

#import "MyScrollView.h"
#import "LoginManager.h"

@interface DatingStatusView : UIViewController<UITableViewDataSource, UITableViewDelegate, LoginManagerDelegate, UITextViewDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet MyScrollView *scrollView;
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UITextField *textRelationshipStatus, *textSexualPreference, *textHeight, *textBodyType, *textLanguageSpeak, *textCurrentField;
    
    IBOutlet CustomTextView *textAboutYourself;
    
    IBOutlet UIButton *btnMale, *btnFemale, *btnNext;
 
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
 
    NSMutableArray *arrayData;
    NSMutableArray *arrayRelStaus, *arrayBodyType, *arrayHeight, *arrayLanguageSpeak;
    
    int selectedType;
    NSString *selectedRelStatusId, *selectedBodytype, *selectedHeightId, *selectedLangSpeakId, *selectedInterest;
    
    BOOL isEdit;
    
}

-(void)isForEdit:(BOOL)_isEdit;

@end
