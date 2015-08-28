//
//  EmailSignUpView.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 27/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "EmailSignUpView.h"
#import "LoginDetailsView.h"
#import "Constant.h"

#import "LoadremoteImages.h"
#import "CustomAlertView.h"

#define kTimeLimit 0.10

@interface EmailSignUpView ()

@end

@implementation EmailSignUpView

-(void)isCommingForEditProfile:(BOOL)_flag
{
    isEditProfile = _flag;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textBirthDate.leftView = paddingView;
    textBirthDate.leftViewMode = UITextFieldViewModeAlways;

    //----------
    flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
    flatDatePicker.delegate = self;
    flatDatePicker.title = @"Select Your Birthday";
    
    selectedGender = @"m";

    if(isEditProfile)
    {
        selectedGender = appDelegate.userDetails.userGender;
        textBirthDate.text = appDelegate.userDetails.userBirthDate;
        
        appDelegate.birthDate = appDelegate.userDetails.userBirthDate;
        
        labelTopHeader.text = @"Edit";
        [btnNext setTitle:@"Update" forState:UIControlStateNormal];

        labelProfilePic.text = @"Change Profile Picture";
        labelVoiceNote.text = @"Change Voice Note";
        
        if([selectedGender isEqualToString:@"m"] || [selectedGender isEqualToString:@"M"])
        {
            [btnMaleGender setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
            [btnFemaleGender setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMaleGender setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
            [btnFemaleGender setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
        }
    
        /*
        LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, btnAddProfile.frame.size.width, btnAddProfile.frame.size.height) ];
        [remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
        [remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [remote setImageWithURL:[NSURL URLWithString:appDelegate.userDetails.userProfileBig] placeholderImage:[UIImage imageNamed:@""]]; //profile-placeholder
        remote.contentMode = UIViewContentModeScaleAspectFit;

        [btnAddProfile addSubview:remote];
        */
        
        AsyncImageView *temp = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, btnAddProfile.frame.size.width, btnAddProfile.frame.size.height)];
        temp.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [temp loadImageFromURL:appDelegate.userDetails.userProfileBig];
       
        [btnAddProfile addSubview:temp];
        
        btnAddProfile.layer.cornerRadius = btnAddProfile.frame.size.height/2;
        btnAddProfile.layer.masksToBounds = YES;

    }
    else
    {
        labelTopHeader.text = @"Signup";
        [btnNext setTitle:@"Next" forState:UIControlStateNormal];
        
        labelProfilePic.text = @"Add Profile Picture";
        labelVoiceNote.text = @"Add Voice Note";
    }
       
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----  ----  ----  -----
#pragma mark ----  ---- UIIMAGE PICKER DELEGATE  ----  -----


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    appDelegate.profileImage = chosenImage;
    
    for(id subview in btnAddProfile.subviews)
        if([subview isKindOfClass:[AsyncImageView class]])
            [subview removeFromSuperview];
    
    [btnAddProfile setImage:chosenImage forState:UIControlStateNormal];
    
    btnAddProfile.layer.cornerRadius = btnAddProfile.frame.size.height/2;
    btnAddProfile.layer.masksToBounds = YES;
    
    if(isEditProfile)
        [self uploadProfilePicture];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark ----  ----  ----  -----

-(void)uploadProfilePicture
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSData *_data = UIImageJPEGRepresentation (appDelegate.profileImage, 1);
        
        NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
        [imgDict setObject:_data forKey:@"profilePicturePath"];
        
        [loginManager updateUsersProfilePicture:imgDict];

        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(alertView == alertProfilePic)
    {
        if(buttonIndex == 0)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:NULL];
                
            }
            else
            {
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Device has no camera"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];
                
            }
            
        }
        else if(buttonIndex == 1)
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
        else
        {
            [alertView removeFromSuperview];
        }

    }
    
}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(IBAction)btnAddProfilePictureTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Add Profile Picture"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take Photo", @"Choose from Gallery",
                                  nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
    
//    alertProfilePic = [[UIAlertView alloc] initWithTitle:@"Profile Picture"
//                                                          message:nil
//                                                         delegate:self
//                                                cancelButtonTitle:@"Take Photo"
//                                                otherButtonTitles: @"Choose from Gallery", @"Cancel", nil];
//    
//    [alertProfilePic show];
    

    
}


-(IBAction)btnVoiceNoteTapped:(id)sender
{
    IQAudioRecorderController *controller = [[IQAudioRecorderController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
    /*
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Add voice note" leftButtonTitle:@"Capture" rightButtonTitle:@"Upload" showsImage:NO];
    [alert show];
    
    alert.leftBlock =^()
    {
        [self setVoiceNoteView];

    };
    */
}

-(void)audioRecorderController:(IQAudioRecorderController *)controller didFinishWithAudioAtPath:(NSString *)filePath
{
    appDelegate.dataVoiceNote = [NSData dataWithContentsOfFile:filePath];
    
    if(isEditProfile)
        [self UploadVoiceNote];
}

-(void)audioRecorderControllerDidCancel:(IQAudioRecorderController *)controller
{

}

-(IBAction)btnBirthDateTapped:(id)sender
{
    if(btnBirthDate.selected == NO)
    {
        btnBirthDate.selected = YES;
        
        [self displayCalender];
    }
    else
    {
        [self removeCalender];
        
    }
    
    /*
    if(btnBirthDate.selected == NO)
    {
        btnBirthDate.selected = YES;
        
        if(![datePickerView superview])
        {
            datePickerView = [[UIView alloc]init];
            datePicker = [[UIDatePicker alloc] init];
        }
        
        datePickerView.frame = CGRectMake(textBirthDate.frame.origin.x, textBirthDate.frame.origin.y+textBirthDate.frame.size.height, textBirthDate.frame.size.width, 200);
        datePickerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:datePickerView];
        
        datePicker.frame = CGRectMake(0, 0, datePickerView.frame.size.width, 0);
        [datePickerView addSubview:datePicker];

        
        datePickerView.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            datePickerView.alpha = 1;

        }completion:^(BOOL finished){
            
        }];
        
    }
    else
    {
        btnBirthDate.selected = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            datePickerView.alpha = 0;

        }completion:^(BOOL finished){
            
        }];
        
    }
     */
    //[datePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // register to be notified when the value changes
    // As an example we'll use a tap gesture recognizer to dismiss on a double-tap
    
    //UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDoubleTapped:)];
    //tapGR.numberOfTapsRequired = 2; // Limit to double-taps
    //[self.view addGestureRecognizer:tapGR];

    
}


-(IBAction)btnGenderTapped:(id)sender
{
    if([sender tag]==0)
    {
        [btnMaleGender setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
        [btnFemaleGender setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];

        selectedGender = @"m";

    }
    else
    {
        [btnMaleGender setImage:[UIImage imageNamed:@"radio-btn"] forState:UIControlStateNormal];
        [btnFemaleGender setImage:[UIImage imageNamed:@"radio-btn-selected"] forState:UIControlStateNormal];
        
        selectedGender = @"f";

    }
}

-(int)checkAgeISEighteenYear:(NSString *)_date
{
    int _isEighteen = 0;
    
    int selectedYY = [[_date substringToIndex:4] intValue];
    int selecetdMM = [[_date substringWithRange:NSMakeRange(5, 2)]intValue];
    int selectedDD = [[_date substringWithRange:NSMakeRange(8, 2)]intValue];
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *value = [dateFormatter stringFromDate:[NSDate date]];

    int currentYY = [[value substringToIndex:4] intValue];
    int currentMM = [[value substringWithRange:NSMakeRange(5, 2)]intValue];
    int currentDD = [[value substringWithRange:NSMakeRange(8, 2)]intValue];

    NSLog(@"-- YEAR :%d", selectedYY);
    NSLog(@"-- MONTH :%d", selecetdMM);
    NSLog(@"-- DATE :%d", selectedDD);

    NSLog(@"-- YEAR :%d", currentYY);
    NSLog(@"-- MONTH :%d", currentMM);
    NSLog(@"-- DATE :%d", currentDD);

    if((selectedYY + 18) < currentYY)
    {
        _isEighteen = 1;
    }
    else if((selectedYY + 18) == currentYY)
    {
        if(selecetdMM < currentMM)
        {
            _isEighteen = 0;
        }
        if(selecetdMM == currentMM)
        {
            if(selectedDD < currentDD)
                _isEighteen = 1;
        }

    }
    
    return _isEighteen;
}

-(IBAction)btnNextTapped:(id)sender
{
    if(textBirthDate.text.length !=0)
    {
        int isEighteen = [self checkAgeISEighteenYear:appDelegate.birthDate];
        
        if(isEighteen)
        {
            if(isEditProfile)
            {
                [self editPersonalDetails];
            }
            else
            {
                LoginDetailsView *loginDetails;
                appDelegate.selectedGender = selectedGender;
                
                if(appDelegate.iPad)
                    loginDetails = [[LoginDetailsView alloc]initWithNibName:@"LoginDetailsView_iPad" bundle:nil ];
                else
                    loginDetails = [[LoginDetailsView alloc]initWithNibName:@"LoginDetailsView" bundle:nil ];
                
                [loginDetails initWithIsEditProfile:isEditProfile];
                
                [self.navigationController pushViewController:loginDetails animated:YES];

            }
           
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"User has to be 18+ year" leftButtonTitle:nil rightButtonTitle:@"Ok" showsImage:NO];
            [alert show];
        }
      
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Please select birth date." leftButtonTitle:nil rightButtonTitle:@"Ok" showsImage:NO];
        [alert show];
    }
    
}

#pragma mark ---- -----  TEXT FIELD DELEGATE ----  -----

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self btnBirthDateTapped:nil];
    return NO;
}


#pragma mark ---- ----- ----  -----
#pragma mark ---- ----- ACTION SHEET DELEGATE ----  -----

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
            
        case 0:
            [self takePhotoFromCamera];
            break;
            
        case 1:
            [self choosePhotoFromGallery];
            break;
    }
    
}


-(void)takePhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if(appDelegate.iPad)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:imagePicker animated:YES completion:NULL];
            }];
        }
        else
        {
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

-(void)choosePhotoFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if(appDelegate.iPad)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self presentViewController:picker animated:YES completion:NULL];
        }];

    }
    else
    {
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}


-(void)displayCalender
{
    
//    temp1.frame = CGRectMake(0, DEVICE_HEIGHT, (DEVICE_WIDTH-500)/2, 320);
//    temp2.frame = CGRectMake((DEVICE_WIDTH-500)/2 + 500, DEVICE_HEIGHT, (DEVICE_WIDTH-500)/2, 320);
//
//    labelTitle.frame = CGRectMake(80, DEVICE_HEIGHT, DEVICE_WIDTH-160, 60);
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        temp1.frame = CGRectMake(0, DEVICE_HEIGHT-320, (DEVICE_WIDTH-500)/2, 320);
//        temp2.frame = CGRectMake((DEVICE_WIDTH-500)/2 + 500, DEVICE_HEIGHT-320, (DEVICE_WIDTH-500)/2, 320);
//        
//        labelTitle.frame = CGRectMake(80, DEVICE_HEIGHT-320, DEVICE_WIDTH-160, 60);
//
//
//    }completion:^(BOOL finished){
//        
//    }];

    [flatDatePicker show];

}


-(void)removeCalender
{
    btnBirthDate.selected = NO;

    [flatDatePicker dismiss];

//    [UIView animateWithDuration:0.3 animations:^{
//        
//        temp1.frame = CGRectMake(0, DEVICE_HEIGHT, (DEVICE_WIDTH-500)/2, 320);
//        temp2.frame = CGRectMake((DEVICE_WIDTH-500)/2 + 500, DEVICE_HEIGHT, (DEVICE_WIDTH-500)/2, 320);
//        
//        labelTitle.frame = CGRectMake(80, DEVICE_HEIGHT, DEVICE_WIDTH-160, 60);
//
//    }completion:^(BOOL finished){
//        
//    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(appDelegate.iPad)
    {
        if([flatDatePicker superview])
            [self removeCalender];
    }
}

- (IBAction)actionSetDate:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString:@"07-12-1985"];
    
    [flatDatePicker setDate:date animated:NO];
}

#pragma mark - FlatDatePicker Delegate

- (void)flatDatePicker:(FlatDatePicker*)datePicker dateDidChange:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    //NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    //[dateFormatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    appDelegate.birthDate = [dateFormatter stringFromDate:date];

    
    
    textBirthDate.text = value;
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:@"Did cancelled !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alertView show];
    
    [self removeCalender];
    
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];

    appDelegate.birthDate = [dateFormatter2 stringFromDate:date];
    
    textBirthDate.text = value;
    
    [self removeCalender];

    //NSString *message = [NSString stringWithFormat:@"Did valid date : %@", value];
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alertView show];
    
}


-(void)UploadVoiceNote
{
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc]init];
    [imgDict setObject:appDelegate.dataVoiceNote forKey:@"audio"];
    
    [loginManager uploadVoiceNote:imgDict];
    
}

-(void)editPersonalDetails
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        loginManager = [[LoginManager alloc]init];
        [loginManager setLoginManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];

        [dataDict setObject:selectedGender forKey:@"gender"];
        
        if(appDelegate.birthDate.length != 0)
            [dataDict setObject:appDelegate.birthDate forKey:@"date_of_birth"];
        else
            [dataDict setObject:@"" forKey:@"date_of_birth"];
        
        [loginManager updatePersonalDetails:dataDict];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
}

-(IBAction)btnPlayTapped:(id)sender
{
    /*
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
     */
    
    //[self btnUploadAudio:nil];
    
}


#pragma mark -----  ----- ----- -----
#pragma mark -----  -----   DELEGATE RETURN METHOD  ----- -----

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successfullyUploadProfilePicture:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    appDelegate.profileImage = nil;
    
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

-(void)successfullyUploadVoiceNote:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    appDelegate.dataVoiceNote = nil;
        
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Voice note upload succesfully." leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];

}

-(void)successWitUpdatePersonalDetails:(NSString *)_message
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_message leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];

    alert.rightBlock =^()
    {
        [self.navigationController popViewControllerAnimated:YES];
    };
}


@end
