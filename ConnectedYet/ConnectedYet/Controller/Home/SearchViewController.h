//
//  SearchViewController.h
//  ConnectedYet
//
//  Created by Iphone_Dev on 13/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UserManager.h"
#import "DatabaseConnection.h"

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UserManagerDelegate, UITextFieldDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;
    DatabaseConnection *database;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *textGender, *textAgeFrom, *textAgeTo;
    IBOutlet UIButton *btnPeopleNear, *btnCountry, *btnCity, *btnInviteContacts, *btnSearch;
    
    IBOutlet UITextField *textCountryCity;
    
    int ageFrom, ageTo;
    IBOutlet UIView *viewInvite;
    
    
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    
    NSString *selectedLanguageCode;

    NSMutableArray *arrayData, *arrayGender, *arrayCountry, *arrayAge;
    IBOutlet UITextField *textCurrentField;
    int selectedType;
    NSString *selectedLocatioType;
    
}

@end
