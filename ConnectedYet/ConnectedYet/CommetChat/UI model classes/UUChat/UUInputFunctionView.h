//
//  UUInputFunctionView.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "IQAudioRecorderController.h"
#import "IBActionSheet.h"

@class UUInputFunctionView;

@protocol UUInputFunctionViewDelegate <NSObject>

// text
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message;

// image
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image;

// audio
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second;

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVideoPath:(NSString *)videoPath;

@end

@interface UUInputFunctionView : UIView <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, IQAudioRecorderControllerDelegate, IBActionSheetDelegate>
{
    AppDelegate *appDelegate;
    
}

@property IBActionSheet *funkyIBAS;

@property (nonatomic, retain) UIButton *btnSendMessage;
@property (nonatomic, retain) UIButton *btnChangeVoiceState;
@property (nonatomic, retain) UIButton *btnVoiceRecord;
@property (nonatomic, retain) UITextView *TextViewInput;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, retain) UIViewController *superVC;

@property (nonatomic, assign) id<UUInputFunctionViewDelegate>delegate;


- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;

@end
