//
//  InboxViewController.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "InboxViewController.h"

#import "InboxMessagesCell.h"
#import "ChatViewController.h"

#import "Constant.h"

#define kCellHeight 90
#define kCellHeightiPad 110


@interface InboxViewController ()

@end

@implementation InboxViewController
@synthesize chatManager;

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // Get all chat threads
    [self getChatUsersList];
    
    arrayMessages = [[NSMutableArray alloc]init];
}

-(void)getChatUsersList
{
    // Get chat history
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        self.chatManager = [[ChatDataManager alloc]init];
        [self.chatManager setDelegate:self];
        [self.chatManager getAllChatForUser:appDelegate.userDetails.userId];
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
    }
}



-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark –--  Button Click Methods ----

-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }
    
}

#pragma mark –--  -----  ----

#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayMessages count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelegate.iPad)
        return kCellHeightiPad;
    else
        return kCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Messages";
    InboxMessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *xib;
    
    if(appDelegate.iPad)
        xib = [[NSBundle mainBundle] loadNibNamed:@"InboxMessagesCell_iPad" owner:self options:nil];
    else
        xib = [[NSBundle mainBundle] loadNibNamed:@"InboxMessagesCell" owner:self options:nil];
    
    cell = [xib objectAtIndex:0];
    

    cell.imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [cell.imageProfile loadImageFromURL:[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"profilePicSmall"]];

    //[cell.imageProfile loadImageFromURL:@"http://aegis-infotech.com/connectedyet/web/cometchat/plugins/filetransfer/download.php?file=cc78b337365f08ab4fadc5daf78642c3.jpg&unencryptedfilename=IMG20150614WA0018.jpg"];


    
    if(indexPath.row%2 == 0)
        cell.imageStatus.image = [UIImage imageNamed:@"status-offline"];
    else if(indexPath.row%3 == 0)
        cell.imageStatus.image = [UIImage imageNamed:@"status-online"];
    else
        cell.imageStatus.image = [UIImage imageNamed:@"status-away"];
    
    cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.size.height/2;
    cell.imageProfile.layer.masksToBounds = YES;
    cell.imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    cell.imageProfile.layer.borderWidth = 2.5;
    
    NSString *titleString=[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"username"];
    
    /*if ([self.loginUser.userId integerValue]==[[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"from"] integerValue]) {
        // message from us
        titleString=[NSString stringWithFormat:@"Message to: %@",[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"to"]];
    }
    else{
        // message to us
        titleString=[NSString stringWithFormat:@"Message from: %@",[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"from"]];
    }*/
    
    cell.labelName.text = titleString;
    cell.labelMessage.text = [[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    cell.labelTime.text = [NSString stringWithFormat:@"%@",[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"sent"]];
    cell.labelCount.text = [NSString stringWithFormat:@"%@",[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"unread"]];
    
    cell.labelCount.layer.cornerRadius = 15;
    cell.labelCount.layer.masksToBounds = YES;

    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create target user object
    UsersData *targetUser=[UsersData new];
    
    if ([appDelegate.userDetails.userId integerValue]==[[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"from"] integerValue]) {
        // message from us
        targetUser.userId=[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"to"];
        targetUser.userName=[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"username"];
        targetUser.userProfileSmall = [[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"profilePicSmall"];
        
    }
    else{
        // message to us
        targetUser.userId=[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"from"];
        targetUser.userName=[[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"username"];
        targetUser.userProfileSmall = [[arrayMessages objectAtIndex:indexPath.row] objectForKey:@"profilePicSmall"];

    }
    
    ChatViewController *chatView;
    if(appDelegate.iPad)
        chatView = [[ChatViewController alloc]initWithNibName:@"ChatViewController_iPad" bundle:nil];
    else
        chatView = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    [chatView setTargetUser:targetUser];
    [self.navigationController pushViewController:chatView animated:YES];
}


#pragma mark ---- ----- -------
#pragma mark ----  DELEGATE RETURNS -------

-(void)allChatResponseWithData:(NSMutableArray*)data message:(NSString*)message
{
    [appDelegate stopSpinner];
    
    arrayMessages= (NSMutableArray *)[[data reverseObjectEnumerator] allObjects];

    
    NSLog(@"%@",[arrayMessages description]);
    //[data objectForKey:[NSString stringWithFormat:@"%@",self.loginUser.userId]];
    
    if (data.count>0) {
        // We have data to show
        [tableMessages reloadData];
    }
    else{
        NSLog(@"No data available with message %@",message);
    }
}

@end
