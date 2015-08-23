//
//  MatrimonyMyMatch.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 12/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"
#import "MatchData.h"

@interface MatrimonyMyMatch : UIViewController <UITableViewDelegate, UITableViewDataSource, LoginManagerDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    
    IBOutlet UIScrollView *scrollView;
 
    IBOutlet UITextField *textRelStatus, *textOccupation, *textSalaryRange, *textSmoke, *textDrink, *textHavingKids, *textWantsKids, *textCurrentField;

    IBOutlet UILabel *labelHeaderTitle;

    UITableView *tableSliderOptions;
    UIView *languageBg, *transparentView;
    
    NSMutableArray *arrayData, *arrayHavingKids, *arrayWantKids, *arrayRelationshipStatus, *arrayOccupation, *arraySalaryRange, *arraySmoke, *arrayDrink;
    
    int selectedType;
    NSString *selectedHavingKidsId, *selectedWantKidsId, *selectedRelStatusId, *selectedOccupationId, *selectedSalaryRangeId, *selectedSmokeId, *selectedDrinkId;
    

    
}

@property(nonatomic, retain) MatchData *matchDataObject;

@property(nonatomic, readwrite) BOOL isCommingFromMatrimony;

@end
