//
//  MatrimonyPersonalInfo.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 08/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"
#import "CountryData.h"

#import "MyScrollView.h"
#import "DatabaseConnection.h"

@interface MatrimonyPersonalInfo : UIViewController <LoginManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;

    DatabaseConnection *database;
    
    IBOutlet MyScrollView *scrollView;
    
    IBOutlet UITextField *textFirstName, *textLastName, *textReligion, *textCast, *textMotherTongue, *textStateLivingIn, *textCityLiving, *textCountry, *textMaritalStatus, *textHeight, *textBodyType, *textSkinTone, *textDiet, *textSmoke, *textDrink;
    
    UITextField *textCurrentField;
    
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    
    NSString *selectedCountryCode;
    

}

@end
