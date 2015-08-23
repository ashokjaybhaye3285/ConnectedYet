//
//  UUMessageCell.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageCell.h"
#import "UUMessage.h"
#import "UUMessageFrame.h"
#import "UUAVAudioPlayer.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UUImageAvatarBrowser.h"
#import <MediaPlayer/MediaPlayer.h>

@interface UUMessageCell ()<UUAVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
    NSString *voiceURL;
    NSData *songData;
    
    UUAVAudioPlayer *audio;
    
    UIView *headImageBackView;
}
@end

@implementation UUMessageCell

@synthesize imageProfile;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor whiteColor];
        self.labelTime.font = ChatTimeFont;
        [self.contentView addSubview:self.labelTime];
        
        // 2、创建头像
        headImageBackView = [[UIView alloc]init];
        headImageBackView.layer.cornerRadius = 22;
        headImageBackView.layer.masksToBounds = YES;
        headImageBackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [self.contentView addSubview:headImageBackView];
        self.btnHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnHeadImage.layer.cornerRadius = 20;
        self.btnHeadImage.layer.masksToBounds = YES;
        [self.btnHeadImage addTarget:self action:@selector(btnHeadImageClick:)  forControlEvents:UIControlEventTouchUpInside];
        [headImageBackView addSubview:self.btnHeadImage];
        
        imageProfile = [[AsyncImageView alloc]init];
        imageProfile.frame = CGRectMake(0, 0, 40, 40);
        imageProfile.layer.cornerRadius = 20;
        imageProfile.layer.masksToBounds = YES;
        [self.btnHeadImage addSubview:imageProfile];
        
        
        // 3、创建头像下标
        self.labelNum = [[UILabel alloc] init];
        self.labelNum.textColor = [UIColor whiteColor];
        self.labelNum.textAlignment = NSTextAlignmentCenter;
        self.labelNum.font = ChatTimeFont;
        [self.contentView addSubview:self.labelNum];
        
        // 4、创建内容
        self.btnContent = [UUMessageContentButton buttonWithType:UIButtonTypeCustom];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
        [self.btnContent addTarget:self action:@selector(btnContentClick)  forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnContent];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UUAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];

    }
    return self;
}

//头像点击
- (void)btnHeadImageClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(headImageDidClick:userId:)])  {
        [self.delegate headImageDidClick:self userId:self.messageFrame.message.strId];
    }
}


- (void)btnContentClick{
    //play audio
    if (self.messageFrame.message.type == UUMessageTypeVoice) {
//        
//        audio = [UUAVAudioPlayer sharedInstance];
//        audio.delegate = self;
//        voiceURL = @"http://aegis-infotech.com/connectedyet/web/cometchat/plugins/filetransfer/download.php?file=9ac84bda2ba422b14d5651dd5b0baf32&unencryptedfilename=trim.P1G2MI.MOV";
        [self playVideo:voiceURL];
       // [audio playSongWithData:songData];
    }
    //show the picture
    else if (self.messageFrame.message.type == UUMessageTypePicture)
    {
        if (self.btnContent.backImageView) {
            [UUImageAvatarBrowser showImage:self.btnContent.backImageView];
        }
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            [[(UIViewController *)self.delegate view] endEditing:YES];
        }
    }
    // show text and gonna copy that
    else if (self.messageFrame.message.type == UUMessageTypeText)
    {
        [self.btnContent becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.btnContent.frame inView:self.btnContent.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}


-(void)playVideo :(NSString *)vedioURL
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DefaultAlbum"];
    NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",path,vedioURL]];
    NSURL *movieURL = [NSURL fileURLWithPath:videopath];
    
    MPMoviePlayerViewController *playercontroller = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [appDelegate.nvc presentMoviePlayerViewControllerAnimated:playercontroller];
    playercontroller.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [playercontroller.moviePlayer play];
    playercontroller = nil;
    
}


- (void)UUAVAudioPlayerBeiginLoadVoice
{
    [self.btnContent benginLoadVoice];
}
- (void)UUAVAudioPlayerBeiginPlay
{
    [self.btnContent didLoadVoice];
}
- (void)UUAVAudioPlayerDidFinishPlay
{
    [self.btnContent stopPlay];
    [[UUAVAudioPlayer sharedInstance]stopSound];
}



//内容及Frame设置
- (void)setMessageFrame:(UUMessageFrame *)messageFrame
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _messageFrame = messageFrame;
    UUMessage *message = messageFrame.message;
    
    // 1、设置时间
    self.labelTime.text = message.strTime;
    self.labelTime.frame = messageFrame.timeF;
    
    // 2、设置头像
    headImageBackView.frame = messageFrame.iconF;
    self.btnHeadImage.frame = CGRectMake(2, 2, ChatIconWH-4, ChatIconWH-4);
    
    imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [imageProfile loadImageFromURL:message.strIcon];

 
    // 3、设置下标
    self.labelNum.text = message.strName;
    if (messageFrame.nameF.origin.x > 160) {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x - 50, messageFrame.nameF.origin.y + 3, 100, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentRight;
    }else{
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x, messageFrame.nameF.origin.y + 3, 80, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentLeft;
    }

    // 4、设置内容
    
    //prepare for reuse
    [self.btnContent setTitle:@"" forState:UIControlStateNormal];
    self.btnContent.voiceBackView.hidden = YES;
    self.btnContent.backImageView.hidden = YES;

    self.btnContent.frame = messageFrame.contentF;
    
    if (message.from == UUMessageFromMe) {
        self.btnContent.isMyMessage = YES;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);
    }else{
        self.btnContent.isMyMessage = NO;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);
    }

    NSLog(@"-- Message Type :%d",message.type);
    switch (message.type)
    {
        case UUMessageTypeText:
            [self.btnContent setTitle:message.strContent forState:UIControlStateNormal];
            
            break;
        case UUMessageTypePicture:
        {
            self.btnContent.backImageView.hidden = NO;
            self.btnContent.backImageView.image = message.picture;
        }
            break;
        case UUMessageTypeVoice:
        {
            self.btnContent.voiceBackView.hidden = NO;
            self.btnContent.second.hidden = YES;
//            songData = message.voice;
            voiceURL = message.voice;
        }
            break;
            
        default:
            break;
    }
    
    //背景气泡图
    UIImage *normal;
    if (message.from == UUMessageFromMe) {
        normal = [UIImage imageNamed:@"bubble-2"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    else{
        normal = [UIImage imageNamed:@"bubble-1"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }
    
    [self.btnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.btnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
}

@end



