//
//  MatrimonyMatchView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "MyScrollView.h"
#import "CountryData.h"

#import "LoginManager.h"
#import "MatchData.h"

@interface MatrimonyMatchView : UIViewController <UITableViewDataSource, UITableViewDelegate, LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    MatchData *matchDataObject;
    
    IBOutlet MyScrollView *scrollView;
    IBOutlet UILabel *labelHeaderTitle;
    
    IBOutlet UIButton *btnBack;

    
    IBOutlet UITextField *textSeeking, *textAgrFrom, *textAgeTo, *textCountry, *textState, *textCity,  *textHairColor, *textEyeColor, *textBodyType, *textHeight, *textEduLevel, *textReligiousBelief, *textLanguage, *textEthnicity, *textCurrentField;
    
    
    
    UITableView *tableSliderOptions;
    UIView *languageBg, *transparentView;
    
    NSMutableArray *arrayData, *arrayLanguage, *arrayEthnicity, *arrayAgeFrom, *arrayAgeTo, *arrayCountry, *arrayHairColor, *arrayEyeColor, *arrayHeight, *arrayBodyType, *arrayEduLevel, *arraySeeking, *arrayReligiousRelief;
    
    NSString *selectedLanguageId, *selectedEthnicityId, *selectedAgeFromId, *selectedAgeToId, *selectedCountryId, *selectedHailColorId, *selectedEyeColorId, *selectedHeightId, *selectedBodyTypeId, *selectedEduLevelId, *selectedSeekingId, *selectedReligiousReliefId;
    
    int selectedType;
    BOOL isEdit;
    
}

@property(nonatomic, readwrite) BOOL isCommingFromMatrimony;

-(void)isForEdit:(BOOL)_isEdit;

@end
