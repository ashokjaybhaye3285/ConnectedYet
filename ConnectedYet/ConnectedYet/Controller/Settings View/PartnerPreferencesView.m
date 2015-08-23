//
//  PartnerPreferencesView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 14/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "PartnerPreferencesView.h"
#import "Constant.h"


@interface PartnerPreferencesView ()

@end

@implementation PartnerPreferencesView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //scrollView.backgroundColor = [UIColor redColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textReligion.leftView = paddingView;
    textReligion.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textCaste.leftView = paddingView;
    textCaste.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textMotherTongue.leftView = paddingView;
    textMotherTongue.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textCountry.leftView = paddingView;
    textCountry.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textState.leftView = paddingView;
    textState.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textCity.leftView = paddingView;
    textCity.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textMaritalStatus.leftView = paddingView;
    textMaritalStatus.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textKids.leftView = paddingView;
    textKids.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textHeight.leftView = paddingView;
    textHeight.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textSkinTone.leftView = paddingView;
    textSkinTone.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textBodyType.leftView = paddingView;
    textBodyType.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textDiet.leftView = paddingView;
    textDiet.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textSmoke.leftView = paddingView;
    textSmoke.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textDrink.leftView = paddingView;
    textDrink.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textEduLevel.leftView = paddingView;
    textEduLevel.leftViewMode = UITextFieldViewModeAlways;
   
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textEduField.leftView = paddingView;
    textEduField.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textWorkingWith.leftView = paddingView;
    textWorkingWith.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textWorkingAs.leftView = paddingView;
    textWorkingAs.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textAnnualIncome.leftView = paddingView;
    textAnnualIncome.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textFamilyStatus.leftView = paddingView;
    textFamilyStatus.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textFamilyType.leftView = paddingView;
    textFamilyType.leftViewMode = UITextFieldViewModeAlways;

    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textFamilyValue.leftView = paddingView;
    textFamilyValue.leftViewMode = UITextFieldViewModeAlways;

    
    if(appDelegate.iPad)
    {
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 2350);

    }
    else
    {
        scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1800);

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----  ----  BUTTON CLICK METHOD ----  -----

-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }

}


-(IBAction)btnReligionTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- btnReligionTapped ---");
    NSLog(@"Religion Text :%@", textReligion.text);
#endif
    
    
}

-(IBAction)btnCasteTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Caste ---");
    NSLog(@"Caste Text :%@", textCaste.text);
#endif
    
}


-(IBAction)btnMotherTongueTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Mother Tongue ---");
    NSLog(@"Mother Tounge Text :%@", textMotherTongue.text);
#endif
    
}


-(IBAction)btnCountryTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Country ---");
    NSLog(@"Country Text :%@", textCountry.text);
#endif
    
}


-(IBAction)btnStateTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- State ---");
    NSLog(@"State Text :%@", textState.text);
#endif

    
}


-(IBAction)btnCityTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- City ---");
    NSLog(@"City Text :%@", textCity.text);
#endif

}


-(IBAction)btnMaritalStatusTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Marital Status ---");
    NSLog(@"Marital Status Text :%@", textMaritalStatus.text);
#endif

}


-(IBAction)btnKidsTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Kids ---");
    NSLog(@"Kids Text :%@", textKids.text);
#endif

}


-(IBAction)btnHeightTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Height ---");
    NSLog(@"Height Text :%@", textHeight.text);
#endif

}


-(IBAction)btnSkinToneTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Skin Tone ---");
    NSLog(@"Skin tone Text :%@", textSkinTone.text);
#endif

}


-(IBAction)btnBodyTypeTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Body Type ---");
    NSLog(@"Body Type Text :%@", textBodyType.text);
#endif

}


-(IBAction)btnDietTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Diet ---");
    NSLog(@"Diet Text :%@", textDiet.text);
#endif

}


-(IBAction)btntSmokeTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Smoke ---");
    NSLog(@"Smoke Text :%@", textSmoke.text);
#endif

}


-(IBAction)btnDrinkTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Drink ---");
    NSLog(@"Drink Text :%@", textDrink.text);
#endif

}


-(IBAction)btnEduLevelTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Edu Level ---");
    NSLog(@"Edu Level Text :%@", textEduLevel.text);
#endif

}


-(IBAction)btnEduFieldTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Edu Field ---");
    NSLog(@"Edu Field Text :%@", textEduField.text);
#endif

}


-(IBAction)btnWorkingWithTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Working With ---");
    NSLog(@"Working With Text :%@", textWorkingWith.text);
#endif

}


-(IBAction)btnWorkingAsTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Working As ---");
    NSLog(@"Working As Text :%@", textWorkingAs.text);
#endif

}


-(IBAction)btnAnnualIncomeTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Annual Income ---");
    NSLog(@"Annual Income Text :%@", textAnnualIncome.text);
#endif

}


-(IBAction)btnFamilyStatusTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Fam Status ---");
    NSLog(@"Fam Status Text :%@", textFamilyStatus.text);
#endif

}


-(IBAction)btnFamilyTypeTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Fam Type ---");
    NSLog(@"Fam Type Text :%@", textFamilyType.text);
#endif

}


-(IBAction)btnFamilyValueTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Fam Val ---");
    NSLog(@"Fam Value Text :%@", textFamilyValue.text);
#endif

}


-(IBAction)btnMyMatchesTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- My Matches ---");
#endif

}


#pragma mark ----  ----  ----  ---- 
#pragma mark TEXT FIELD DELEGATE

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}


@end
