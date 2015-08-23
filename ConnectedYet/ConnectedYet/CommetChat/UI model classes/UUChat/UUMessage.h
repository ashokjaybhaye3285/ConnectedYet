//
//  UUMessage.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    UUMessageTypeText     = 10 , // 文字
    UUMessageTypePicture  = 12 , // 图片
    UUMessageTypeVoice    = 14   // 语音
} MessageType;

/*message_type = 10 : For normal text messages
 message_type = 11 : For join chatroom invite message
 message_type = 12 : For image messages
 message_type = 13 : For handwritten messages
 message_type = 14 : For video messages
 */


typedef enum {
    UUMessageFromMe    = 100,   // 自己发的
    UUMessageFromOther = 101    // 别人发得
} MessageFrom;


@interface UUMessage : NSObject

@property (nonatomic, copy) NSString *strIcon;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTime;
@property (nonatomic, copy) NSString *strName;

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) UIImage  *picture;
@property (nonatomic, copy) NSString   *voice;
@property (nonatomic, copy) NSString *strVoiceTime;

@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageFrom from;

@property (nonatomic, assign) BOOL showDateLabel;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end
