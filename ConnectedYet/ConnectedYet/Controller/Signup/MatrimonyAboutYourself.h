//
//  MatrimonyAboutYourself.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 11/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"
#import "MyScrollView.h"

@interface MatrimonyAboutYourself : UIViewController <LoginManagerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet MyScrollView *scrollView;
 
    IBOutlet UITextField *textHairColor, *textEyeColor, *textBodyType, *textHeight, *textSign, *textRelStatus, *textOccupation, *textSalaryRange, *textHaveKids, *textHowManyKids, *textWantKids, *textCurrentField;
    
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    //NSString *selectedCountryCode;

    NSMutableArray *arrayEyesColor, *arrayHairColor, *arrayBodyType, *arrayHeight, *arraySign, *arrayRelationshipstatus, *arrayOccupation, *arraySalaryRange, *arrayHaveKids, *arrayWantKids, *arrayHowManyKids;
    NSMutableArray *arrayData;
    
    int selectedType;
    NSString *selectedHairColorId, *selectedEyeColorId, *selectedBodyTypeId, *selectedHeightId, *selectedSignId, *selectedRelationshipId, *selectedOccupationId, *selectedSalaryId, *selectedHowManyKidId, *selectedWantMoreId, *selectedHaveKidsId;
    
}


@end
