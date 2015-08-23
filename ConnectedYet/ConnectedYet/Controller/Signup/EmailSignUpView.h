//
//  EmailSignUpView.h
//  ConnectedYet
//
//  Created by Iphone_Dev on 27/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "FlatDatePicker.h"
#import <AVFoundation/AVFoundation.h>

#import "LoginManager.h"
#import "AsyncImageView.h"

#import "IQAudioRecorderController.h"

@interface EmailSignUpView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, FlatDatePickerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, LoginManagerDelegate, IQAudioRecorderControllerDelegate>
{
    AppDelegate *appDelegate;
    FlatDatePicker *flatDatePicker;
    
    LoginManager *loginManager;
    
    IBOutlet UILabel *labelVoiceNote, *labelProfilePic, *labelTopHeader;
    
    IBOutlet UIButton *btnMaleGender, *btnFemaleGender, *btnAddProfile, *btnAddVoiceNote, *btnBirthDate, *btnNext;
    IBOutlet UITextField *textBirthDate;
    
    UIView *datePickerView;
    UIDatePicker *datePicker;
    
    UIImagePickerController *imagePicker;
    
    UIAlertView *alertProfilePic;
    
    UIView * temp1, *temp2;
    UILabel *labelTitle;
    NSString *selectedGender;
    
    BOOL isEditProfile;
    
       
}

-(void)isCommingForEditProfile:(BOOL)_flag;

@end
