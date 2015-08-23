//
//  PartnerPreferencesView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 14/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface PartnerPreferencesView : UIViewController
{

    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UISlider *sliderAge;
    
    IBOutlet UITextField *textReligion, *textCaste, *textMotherTongue, *textCountry, *textState, *textCity, *textMaritalStatus, *textKids, *textHeight, *textSkinTone, *textBodyType, *textDiet, *textSmoke, *textDrink, *textEduLevel, *textEduField, *textWorkingWith, *textWorkingAs, *textAnnualIncome, *textFamilyStatus, *textFamilyType, *textFamilyValue;
    
    IBOutlet UIButton *btnReligion, *btnCaste, *btnMotherTongue, *btnCountry, *btnState, *btnCity, *btnMaritalStatus, *btnKids, *btnHeight, *btnSkinTone, *btnBodyType, *btnDiet, *btntSmoke, *btnDrink, *btnEduLevel, *btnEduField, *btnWorkingWith, *btnWorkingAs, *btnAnnualIncome, *btnFamilyStatus, *btnFamilyType, *btnFamilyValue;
    
    IBOutlet UIButton *btnMyMatches;
    
}


@end
