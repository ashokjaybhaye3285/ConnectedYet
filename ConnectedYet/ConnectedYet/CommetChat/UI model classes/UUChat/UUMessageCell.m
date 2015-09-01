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
        
        
        [self playVideo:voiceURL];

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
    
    
    if ([vedioURL containsString:@"unencryptedfilename="]) {

    
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:vedioURL]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"DefaultAlbumServer"];
        
        
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        
        NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/server.mp4",dataPath]];

        [imageData writeToFile:videopath atomically:YES];
        NSLog(@"videopath %@",videopath);
        
        movieURL = [NSURL fileURLWithPath:videopath];
        NSLog(@"movieURL %@",[movieURL absoluteString]);

        
        
        NSURL *vedioURL;

        
        NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dataPath  error:nil];
        NSLog(@"files array %@", filePathsArray);
        
        NSString *fullpath;
        
        for ( NSString *apath in filePathsArray )
        {
            fullpath = [documentsDirectory stringByAppendingPathComponent:apath];
            vedioURL =[NSURL fileURLWithPath:fullpath];
        }
        
        
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory1 = [paths2 objectAtIndex:0]; //2
//        NSString* file1 = [[NSString alloc]initWithFormat:@"%@",filename1];
        
        NSString* path1 = [documentsDirectory1 stringByAppendingPathComponent:@"DefaultAlbumServer/server.mp4"];
        
        NSLog(@"vurl %@",path1);
        movieURL = [NSURL fileURLWithPath:path1];

        MPMoviePlayerViewController *playercontroller = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [appDelegate.nvc presentMoviePlayerViewControllerAnimated:playercontroller];
        playercontroller.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [playercontroller.moviePlayer play];
        playercontroller = nil;
        
        
    } else {
        
        NSLog(@"videopath %@",vedioURL);
        
        movieURL = [NSURL fileURLWithPath:vedioURL];
        NSLog(@"movieURL %@",[movieURL absoluteString]);
        
        MPMoviePlayerViewController *playercontroller = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [appDelegate.nvc presentMoviePlayerViewControllerAnimated:playercontroller];
        playercontroller.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [playercontroller.moviePlayer play];
        playercontroller = nil;
    }
    
    
    
}
/*
-(void)setupMovie:(NSString *)videoURL
{
    NSURL *movieURL1 = [NSURL fileURLWithPath:videoURL];
    
    mpController =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL1];
    mpController.scalingMode = MPMovieScalingModeAspectFill;
    mpController.controlStyle = MPMovieControlStyleNone;
    mpController.view.frame = appDelegate.nvc.view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(moviePlayerPlaybackStateDidChange:)  name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification  object:nil];
    
    [appDelegate.nvc.view addSubview:mpController.view];
    [mpController prepareToPlay];
}


- (void)moviePlayBackDidFinish:(MPMoviePlayerController *)player
{
    [mpController.view removeFromSuperview];
}

- (void)moviePlayerPlaybackStateDidChange:(NSNotification*)notification
{
    if ( mpController.isPreparedToPlay) {
        [ mpController play];
    }
}
*/

- (void)playmov:(NSString*)aVideoUrl
{
    // Initialize the movie player view controller with a video URL string
    playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:aVideoUrl]] ;
    
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:playerVC
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:playerVC.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerVC.moviePlayer];
    
    // Set the modal transition style of your choice
    playerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // Present the movie player view controller
    [appDelegate.nvc presentMoviePlayerViewControllerAnimated:playerVC];
    
    // Start playback
    [playerVC.moviePlayer prepareToPlay];
    [playerVC.moviePlayer play];
}


- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayer3 = [aNotification object];
        
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer3];
        
        // Dismiss the view controller
//        [appDelegate.nvc dismissMoviePlayerViewControllerAnimated:YES];
    }
}


-(void)LoadVideo
{
    
    MPMoviePlayerViewController *playercontroller = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [appDelegate.nvc presentMoviePlayerViewControllerAnimated:playercontroller];
    playercontroller.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [playercontroller.moviePlayer play];
    
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player1 = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player1];
    
    if ([player1
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player1.view removeFromSuperview];
    }
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



