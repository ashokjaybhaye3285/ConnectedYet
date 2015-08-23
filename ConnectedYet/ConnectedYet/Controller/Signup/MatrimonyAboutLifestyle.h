//
//  MatrimonyAboutLifestyle.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginManager.h"

#import "MyScrollView.h"


@interface MatrimonyAboutLifestyle : UIViewController <UITableViewDataSource, UITableViewDelegate, LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet MyScrollView *scrollView;
    
    IBOutlet UITextField *textSmoke, *textDrink, *textExercise, *textEduLevel, *textCurrentField;
    
    UITableView *tablePrimaryLanguage;
    UIView *languageBg, *transparentView;
    NSString *selectedCountryCode;

    NSString *selectedSmokeId, *selectedDrinkId, *selectedExerciseId,*selectedEducationLevelId;
    
    NSMutableArray *arrayData;
    NSMutableArray *arraySmoke, *arrayDrink, *arrayExercise, *arrayEducationLevel, *arraySportExercise, *arrayLanguageSpeak, *arrayEthnicity;
    int selectedType;
    
    IBOutlet UIButton *btnSportExercise, *btnLangSpeak, *btnEthnicity, *btnContinue;
    NSMutableArray *arraySelectedSportExercise, *arraySelectedLangSpeak, *arraySelectedEthnicity;
    
    int yPos;

    IBOutlet UIImageView *imageBackgroundDevider1, *imageBackgroundDevider2;
    IBOutlet UILabel *labelAboutBg, *labelEduLevel, *labelLangSpeak, *labelEthnicity;

}

@end
