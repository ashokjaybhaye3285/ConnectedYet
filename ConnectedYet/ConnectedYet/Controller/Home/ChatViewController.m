//
//  ChatViewController.m
//  ConnectedYet
//
//  Created by Iphone_Dev on 21/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "ChatViewController.h"
#import "Constant.h"

#define kCellHeight 50
#define kCellHeightiPad 70

#define iPhoneFont [UIFont fontWithName:@"Helvetica" size:14]
#define iPadFont [UIFont fontWithName:@"Helvetica" size:16]

@interface ChatViewController ()

@property (strong, nonatomic) ChatModel *chatModel;
@property(nonatomic,retain)UUInputFunctionView *IFView;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation ChatViewController
@synthesize chatObj,loginUser,chatManager,targetUser;

-(id)initWithTargetUser:(UsersData*)_targetUser
{
    if ([super init])
    {
        self.targetUser=_targetUser;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Get user details
    self.loginUser = [appDelegate loadCustomObjectWithKey:@"myLoginData"];
    
    labelTopHeader.text = self.targetUser.userName;

    // Get chat history
    //[self getHistory];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.iPad ? 10 : 5, 20)];
    textChat.leftView = paddingView;
    textChat.leftViewMode = UITextFieldViewModeAlways;

    // Initiate chatting
    [self chatFunctions];
    
    //[self.chatObj getChatHistory];//----static
    // Chat UI & Functionality functions
    [self loadBaseView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------------------- Chat history ---------------------------

-(void)getHistory
{
    // Get chat history
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        self.chatManager = [[ChatDataManager alloc]init];
        [self.chatManager setDelegate:self];
        [self.chatManager getChatHistoryForUser:self.loginUser.userId withUser:self.targetUser.userId];
        
        //229
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
    }
}

-(void)chatHistoryBetweenRequestedUsers:(NSMutableArray*)data
{
    [appDelegate stopSpinner];
    NSLog(@"%@",[data description]);
    
    for (chatMessageDTO *chatMsg in data) {
        [self.chatModel.dataSource addObject:[self getComposedMessageWithText:chatMsg messageType:[chatMsg.messageType integerValue] withImage:nil withVideoUrl:@""]];
    }
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
    
}

-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
}

#pragma mark --------------------------- Chat functions ---------------------------

-(void)chatFunctions
{
    // Instantiate chat object
    self.chatObj=[ChatWrapper sharedChatWrapper];
    [self.chatObj instantiateChat];
    
    // Set self as observer for chat
    [self.chatObj setChatObserver:self];
}

-(void)sendChatMessage:(NSString*)message toUser:(NSString*)userId
{
    // Send chat to user
    [self.chatObj sendMessage:message toUser:userId completionBlock:^(BOOL status){
        if (status) {
            NSLog(@"Text Chat sending success");
        }else{
            NSLog(@"Text Chat sending fail");
        }
    }];
}

- (void)sendImageWithData: (NSData * ) imageData
                   toUser: (NSString * ) userID{
    [self.chatObj sendImageWithData:imageData toUser:userID completionBlock:^(BOOL status){
        if (status) {
            NSLog(@"Image Chat sending success");
        }else{
            NSLog(@"Image Chat sending fail");
        }
    }];
}

-(void)closeChat:(id)sender
{
    //[self.textTypingView resignFirstResponder];
}

#pragma mark --------------------------- Chat Observer methods --------------------

// When the server sends an update related to your profile
-(void)didReceivedMyProfileUpdate:(NSDictionary*)userInfo
{
    NSLog(@"didReceivedMyProfileUpdate ->%@",[userInfo description]);
}

// When the server sends an updated user’s list
-(void)didReceivedOnlineUsersList:(NSDictionary*)onlineUsersList
{
    NSLog(@"didReceivedOnlineUsersList ->%@",[onlineUsersList description]);
}

// When a message is received
-(void)didReceivedMessage:(chatMessageDTO *)message
{
    NSLog(@"didReceivedMessage ->%@",message.message);
    
    if([message.messageType integerValue] == 10)
        [self.chatModel.dataSource addObject:[self getComposedMessageWithText:message messageType:[message.messageType integerValue] withImage:nil withVideoUrl:@""]];
    else if([message.messageType integerValue] == 12)
    {
        NSURL *imageURL = [NSURL URLWithString:message.message];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        [self.chatModel.dataSource addObject:[self getComposedMessageWithText:message messageType:[message.messageType integerValue] withImage:image withVideoUrl:@""]];
    }
    else if([message.messageType integerValue] == 14) // 
    {
        NSURL *imageURL = [NSURL URLWithString:message.message];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        //  UIImage *image = [UIImage imageWithData:imageData];
        
        NSString *search = @"unencryptedfilename=";
        NSString *sub = [message.message substringFromIndex:NSMaxRange([message.message rangeOfString:search])];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"DefaultAlbum"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        
        NSString *videopath= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",dataPath,sub]];
        
        
        NSURL *videoURL = [NSURL fileURLWithPath:videopath];
        
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        
        UIImage *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        
        
        [imageData writeToFile:videopath atomically:NO];
        
        [self.chatModel.dataSource addObject:[self getComposedMessageWithText:message messageType:[message.messageType integerValue] withImage:thumbnail withVideoUrl:sub] ];
    }

    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
    
    //[self UUInputFunctionView:self.IFView sendMessage:message.message];
}
/*
- (UUMessageFrame *)getComposedMessageWithText:(chatMessageDTO*)chatMessage messageType:(NSInteger)messageType withImage:(UIImage*)image
{
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    NSDictionary *dataDic = [self getDicWithMessage:chatMessage forType:messageType image:image];
    
    [message setWithDict:dataDic];
    //[message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
    messageFrame.showTime = message.showDateLabel;
    [messageFrame setMessage:message];
    return messageFrame;
}*/


- (UUMessageFrame *)getComposedMessageWithText:(chatMessageDTO*)chatMessage messageType:(NSInteger)messageType withImage:(UIImage*)image withVideoUrl:(NSString *)url
{
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    NSDictionary *dataDic = [self getDicWithMessage:chatMessage forType:messageType image:image withVideoUrl:url];
    
    [message setWithDict:dataDic];
    //[message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
    messageFrame.showTime = message.showDateLabel;
    [messageFrame setMessage:message];
    return messageFrame;
}


- (NSDictionary *)getDicWithMessage:(chatMessageDTO*)chatMessage forType:(NSInteger)type image:(UIImage*)image withVideoUrl:(NSString *)url
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    switch (type) {
        case 10:
            // text
            [dictionary setObject:chatMessage.message forKey:@"strContent"];
            break;
        case 12:
            // image
            [dictionary setObject:image forKey:@"picture"];
            break;
        case 14:
            // voice
            [dictionary setObject:url forKey:@"voice"];
            break;
        default:
            break;
    }
    
    static int dateNum = 10;
    NSString *URLStr;
    NSDate *date = [[NSDate date]dateByAddingTimeInterval:arc4random()%1000*(dateNum++) ];
    
    int msgFrom;
    NSString *userName;
    if([chatMessage.messageFromUserId integerValue]==[self.loginUser.userId integerValue])
    {
        //NSLog(@"Message from me");
        msgFrom=1;
        userName=self.loginUser.userName;
        URLStr = appDelegate.userDetails.userProfileSmall;
    }
    else
    {
        //NSLog(@"Message from other");
        msgFrom=0;
        userName=self.targetUser.userName;
        
        if([self.targetUser.userProfileSmall length] == 0)
            URLStr = @"";
        else
            URLStr = self.targetUser.userProfileSmall;

    }
    
    [dictionary setObject:[NSNumber numberWithInt:(msgFrom)] forKey:@"from"];
    [dictionary setObject:[NSNumber numberWithInt:(int)type] forKey:@"type"];
    [dictionary setObject:[date description] forKey:@"strTime"];
    [dictionary setObject:userName forKey:@"strName"];
    [dictionary setObject:URLStr forKey:@"strIcon"];
    
    return dictionary;
}

// When the admin sends a site-wide announcement
-(void)didReceivedAdminAnnouncement:(NSDictionary*)adminAnnouncement
{
    NSLog(@"didReceivedAdminAnnouncement ->%@",[adminAnnouncement description]);
}

// When an audio video chat message is received
-(void)didReceivedAVChat:(chatMessageDTO *)message
{
    NSLog(@"didReceivedAVChat ->%@",message.message);
}

// If there’s an error while performing the subscribing
-(void)didReceivedErrorWithInfo:(NSError*)error
{
    NSLog(@"didReceivedErrorWithInfo ->%@",[error description]);
}

#pragma mark -------------------- Chat UI & Functionality methods ----------------

- (void)loadBaseView
{
    self.chatModel = [[ChatModel alloc]init];
    
    self.IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    self.IFView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:185.0/255.0 blue:177.0/255.0 alpha:1];
    self.IFView.delegate = self;
    [self.view addSubview:self.IFView];
    
    [self.chatTableView reloadData];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
    
}

//adjust UUInputFunctionView's height
-(void)keyboardShow:(NSNotification *)notification
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
    
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomConstraint.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark ---------------- InputFunctionViewDelegate ----------------
// Used to send text chat
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    // Send chat to comet
    [self sendChatMessage:message toUser:self.targetUser.userId];
    
    NSDictionary *dic = @{@"strContent": message, @"type":@10};
    funcView.TextViewInput.text = @"";
    [funcView changeSendBtnWithPhoto:YES];
    [self dealTheFunctionData:dic];
}

// Used to send picture in chat
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image
{
    // Send picture data
    [self sendImageWithData:UIImagePNGRepresentation(image) toUser:self.targetUser.userId];
    
    NSDictionary *dic = @{@"picture": image, @"type":@12};
    [self dealTheFunctionData:dic];
    
}

// Used to send video in chat
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVideoPath:(NSString *)videoPath
{
    
    [self.chatObj sendVideoWithPath:videoPath toUser:[NSString stringWithFormat:@"%@",self.targetUser.userId] completionBlock:^(BOOL status)
     {
         if (status) {
             NSLog(@"Video sending success");
         }else{
             NSLog(@"Video sending fail");
         }
     }];
    
    
    NSString *search = @"DefaultAlbum/";
    NSString *videoName = [videoPath substringFromIndex:NSMaxRange([videoPath rangeOfString:search])];
    
    
    
    NSDictionary *dic = @{@"video": videoName, @"type":@14};
    [self dealTheFunctionData:dic];
    
}


// Used to send voice in chat
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    //[self.chatObj send
    
    NSDictionary *dic = @{@"voice": voice, @"strVoiceTime":[NSString stringWithFormat:@"%d",(int)second], @"type":@14};
    [self dealTheFunctionData:dic];
}

// Add chat to list here
// 10 - text
// 12 - Picture
// 14 - Voice

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    // Add extra feilds to dic
    NSMutableDictionary *mutableDic=[NSMutableDictionary dictionaryWithDictionary:dic];
    
    [mutableDic setValue:self.loginUser.userName forKey:@"strName"];
    [mutableDic setValue:self.loginUser.userProfileSmall forKey:@"avtar"];
    
    [self.chatModel addSpecifiedItem:mutableDic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId
{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"click !!!" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}

#pragma mark ------------------------------------------------------

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
