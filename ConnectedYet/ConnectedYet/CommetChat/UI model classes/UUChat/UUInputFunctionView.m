//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUInputFunctionView.h"
//#import "Mp3Recorder.h"
#import "UUProgressHUD.h"
#import "ACMacros.h"


@interface UUInputFunctionView ()<UITextViewDelegate>//,Mp3RecorderDelegate>
{
    BOOL isbeginVoiceRecord;
    //Mp3Recorder *MP3;
    NSInteger playTime;
    NSTimer *playTimer;
    
    UILabel *placeHold;
}
@end

@implementation UUInputFunctionView

- (id)initWithSuperVC:(UIViewController *)superVC
{
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    self.superVC = superVC;
    CGFloat VCWidth = Main_Screen_Width;
    CGFloat VCHeight = Main_Screen_Height;
        
    CGRect frame;
    
    if(appDelegate.iPad)
        frame = CGRectMake(0, VCHeight-80, VCWidth, 80);
    else
        frame = CGRectMake(0, VCHeight-40, VCWidth, 40);
    
    self = [super initWithFrame:frame];
    if (self) {
        //MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
        self.backgroundColor = [UIColor whiteColor];
        //发送消息
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.isAbleToSendTextMessage = NO;
        [self.btnSendMessage setTitle:@"" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundImage:[UIImage imageNamed:@"add-attachment"] forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        
        //改变状态（语音、文字）
        self.btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoiceState.frame = CGRectMake(5, 5, 30, 30);
        isbeginVoiceRecord = NO;
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChangeVoiceState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoiceState];

        //语音录入键
        self.btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnVoiceRecord.hidden = YES;
        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [self.btnVoiceRecord setTitle:@"Hold to Talk" forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitle:@"Release to Send" forState:UIControlStateHighlighted];
       
        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside];
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchCancel];
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:self.btnVoiceRecord];
        
        
        //输入框
        self.TextViewInput = [[UITextView alloc]init];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.TextViewInput];
        self.TextViewInput.textAlignment = NSTextAlignmentLeft;
        
        //输入框的提示语
        placeHold = [[UILabel alloc]init];
        placeHold.text = @"Input the contents here";
        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self.TextViewInput addSubview:placeHold];
        
        //分割线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 1)];
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [self addSubview:lineView];
        
        
        if(appDelegate.iPad)
        {
            self.btnVoiceRecord.frame = CGRectMake(20, 15, Main_Screen_Width-70*2, 50);

            self.btnSendMessage.frame = CGRectMake(VCWidth-70, 15, 50, 50);
            self.TextViewInput.frame = CGRectMake(80, 15, Main_Screen_Width-160, 50);
            placeHold.frame = CGRectMake(20, 10, 200, 30);
            
            self.TextViewInput.font = [UIFont fontWithName:@"Helvetica" size:18];
            
        }
        else
        {
            self.btnVoiceRecord.frame = CGRectMake(10, 5, Main_Screen_Width-70*2, 30);

            self.btnSendMessage.frame = CGRectMake(VCWidth-40, 5, 30, 30);
            self.TextViewInput.frame = CGRectMake(50, 5, Main_Screen_Width-100, 30);
            placeHold.frame = CGRectMake(20, 0, 200, 30);
            self.TextViewInput.font = [UIFont fontWithName:@"Helvetica" size:16];

        }
        
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShowOrHide:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    //[MP3 startRecord];TODO:HIDE-----
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        //[MP3 stopRecord];TODO:HIDE------
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        //[MP3 cancelRecord];TODO:HIDE--------
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"Cancel"];
}


- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Slide up to cancel"];
}


- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}

#pragma mark - Mp3RecorderDelegate

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate UUInputFunctionView:self sendVoice:voiceData time:playTime+1];
    [UUProgressHUD dismissWithSuccess:@"Success"];
   
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"Too short"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

#pragma mark - Keyboard methods
//跟随键盘高度变化
-(void)keyboardDidShowOrHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.frame = newFrame;
    
    [UIView commitAnimations];
}

//改变输入与录音状态
- (void)voiceRecord:(UIButton *)sender
{
    self.btnVoiceRecord.hidden = !self.btnVoiceRecord.hidden;
    self.TextViewInput.hidden  = !self.TextViewInput.hidden;
    isbeginVoiceRecord = !isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.TextViewInput resignFirstResponder];
    }else{
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.TextViewInput becomeFirstResponder];
    }
}

//发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
    if (self.isAbleToSendTextMessage) {
        NSString *resultStr = [self.TextViewInput.text stringByReplacingOccurrencesOfString:@"   " withString:@""];
        [self.delegate UUInputFunctionView:self sendMessage:resultStr];
    }
    else{
        [self.TextViewInput resignFirstResponder];
        
        /*
        UIActionSheet *actionSheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Capture Image",@"Choose Images",@"Choose Video",nil];
        [actionSheet showInView:self.window];
         */
        
        self.funkyIBAS = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Capture Photo", @"Share Images", @"Share Video",@"Capture Video", nil];
        
        self.funkyIBAS.buttonResponse = IBActionSheetButtonResponseShrinksOnPress;
        
        [self.funkyIBAS setButtonBackgroundColor: [UIColor whiteColor]];//[UIColor colorWithRed:0.258 green:1.000 blue:0.499 alpha:1.000]];
        [self.funkyIBAS setButtonTextColor:[UIColor redColor]];
        [self.funkyIBAS setTitleBackgroundColor:[UIColor whiteColor]];
        [self.funkyIBAS setTitleTextColor:[UIColor blackColor]];
        [self.funkyIBAS setTitleFont:[UIFont fontWithName:@"Helvetica" size:14]];
        
        
        [self.funkyIBAS setCancelButtonFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [self.funkyIBAS setButtonTextColor:[UIColor redColor]];
        
        
        [self.funkyIBAS setButtonTextColor:[UIColor darkGrayColor] forButtonAtIndex:0];
        [self.funkyIBAS setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:0];
        [self.funkyIBAS setFont:[UIFont fontWithName:@"Helvetica" size:appDelegate.iPad ? 18 : 16] forButtonAtIndex:0];
        
        [self.funkyIBAS setButtonTextColor:[UIColor darkGrayColor] forButtonAtIndex:1];
        [self.funkyIBAS setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:1];
        [self.funkyIBAS setFont:[UIFont fontWithName:@"Helvetica" size:appDelegate.iPad ? 18 : 16] forButtonAtIndex:1];

        [self.funkyIBAS setButtonTextColor:[UIColor darkGrayColor] forButtonAtIndex:2];
        [self.funkyIBAS setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:2];
        [self.funkyIBAS setFont:[UIFont fontWithName:@"Helvetica" size:appDelegate.iPad ? 18 : 16] forButtonAtIndex:2];

        [self.funkyIBAS setButtonTextColor:[UIColor darkGrayColor] forButtonAtIndex:3];
        [self.funkyIBAS setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:3];
        [self.funkyIBAS setFont:[UIFont fontWithName:@"Helvetica" size:appDelegate.iPad ? 18 : 16] forButtonAtIndex:3];

        [self.funkyIBAS showInView:self.window];

    }
}


#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.TextViewInput.text.length>0)
        placeHold.hidden = YES;
    else
        placeHold.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self changeSendBtnWithPhoto:textView.text.length>0?NO:YES];
    placeHold.hidden = textView.text.length>0;
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    self.isAbleToSendTextMessage = !isPhoto;
    //[self.btnSendMessage setTitle:isPhoto?@"":@"send" forState:UIControlStateNormal];
    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
    UIImage *image = [UIImage imageNamed:isPhoto?@"add-attachment":@"sent-icon"];
    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.TextViewInput.text.length>0)
        placeHold.hidden = YES;
    else
        placeHold.hidden = NO;
}


#pragma mark - Add Picture


//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1)
    {
        [self openPicLibrary];
    }
    else if (buttonIndex == 2)
    {
        [self captureVideo];
    }
    else if (buttonIndex == 3) //Capture Video code here.....
    {
        //[self captureAudio];
    }
}

-(void)addCarema
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}


-(void)captureVideo
{
#if DEBUG
    NSLog(@"-- Capture Video ---");
#endif
    
    /* //TODO: Capture Video
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        picker.allowsEditing = NO;
        picker.delegate = self;
        
        [self.superVC presentViewController:picker animated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
     */
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self.superVC presentViewController:picker animated:YES completion:^{
        
    }];

   
}

-(void)captureAudio
{
#if DEBUG
    NSLog(@"-- Capture Audio ---");
#endif
 
    IQAudioRecorderController *controller = [[IQAudioRecorderController alloc] init];
    controller.delegate = self;
    [self.superVC presentViewController:controller animated:YES completion:nil];

}

-(void)audioRecorderController:(IQAudioRecorderController *)controller didFinishWithAudioAtPath:(NSString *)filePath
{
#if DEBUG
    NSLog(@"-- Capture Audio ---");
#endif

    [self.superVC dismissViewControllerAnimated:YES completion:^{
        [self.delegate UUInputFunctionView:self sendVoice:[NSData dataWithContentsOfFile:filePath] time:0];
    }];

   // appDelegate.dataVoiceNote = [NSData dataWithContentsOfFile:filePath];
    
    //if(isEditProfile)
      //  [self UploadVoiceNote];
}

-(void)audioRecorderControllerDidCancel:(IQAudioRecorderController *)controller
{
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo)
    {
        
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        
        NSLog(@"found a video");
        
        // Code To give Name to video and store to DocumentDirectory //
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"ddMMyyyyHHmmSS"];
        NSDate *now = [[NSDate alloc] init];
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"DefaultAlbum"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        
        NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@.mp4",dataPath,[dateFormat stringFromDate:now]]];
        
        [[NSData dataWithContentsOfURL:videoUrl] writeToFile:videopath atomically:NO];
        
        
        NSLog(@"video path --> %@",videopath);
        
        [self.superVC dismissViewControllerAnimated:YES completion:^{
            [self.delegate UUInputFunctionView:self sendVideoPath:videopath];
        }];
        
        
        
//        [self.superVC dismissViewControllerAnimated:YES completion:^{
//            [self.delegate UUInputFunctionView:self sendVideoPath:videopath];
//        }];
        
        /*
         MPMoviePlayerViewController* theMovie =
         [[MPMoviePlayerViewController alloc] initWithContentURL: [info objectForKey:
         UIImagePickerControllerMediaURL]];
         [self.superVC presentMoviePlayerViewControllerAnimated:theMovie];
         
         // Register for the playback finished notification
         [[NSNotificationCenter defaultCenter]
         addObserver: self
         selector: @selector(myMovieFinishedCallback:)
         name: MPMoviePlayerPlaybackDidFinishNotification
         object: theMovie];
         */
        
        
    }
    else
    {
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self.superVC dismissViewControllerAnimated:YES completion:^{
            [self.delegate UUInputFunctionView:self sendPicture:editImage];
        }];

    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}


// When the movie is done, release the controller.
-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    [self.superVC dismissMoviePlayerViewControllerAnimated];
    
    MPMoviePlayerController* theMovie = [aNotification object];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver: self
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: theMovie];
    // Release the movie instance created in playMovieAtURL:
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
