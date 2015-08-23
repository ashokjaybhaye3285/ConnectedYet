



#import "InviteContactsView.h"
#import "ConfirmationView.h"

#import "CustomAlertView.h"
#import "Constant.h"

#import "InterestViewController.h"

#define kCellHeight 60
#define kCellHeightiPad 80

@interface InviteContactsView ()

@end

@implementation InviteContactsView

@synthesize isForEdit;


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    arrayContacts = [[NSMutableArray alloc]init];
   
    [self getAllContacts];
    
    if(isForEdit)
    {
        [btnSkip setTitle:@"Back" forState:UIControlStateNormal];
    }
    
}

-(void)getAllContacts
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            //ABAddressBookRef addressBook = ABAddressBookCreate( );
            [self getAllContacts];

        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
        
        for(int i = 0; i < numberOfPeople; i++) {
            
            ContactData *contact = [[ContactData alloc] init];
            
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            
            contact.contactFirstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            contact.contactLastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
           
            NSLog(@"Name:%@ %@", contact.contactFirstName, contact.contactLastName);
            
            CFDataRef imgData = ABPersonCopyImageData(person);
           // NSData *imageData = (__bridge NSData *)imgData;
            if (imgData != NULL) {
                CFRelease(imgData);
            }
            
            
            [[UIDevice currentDevice] name];
            
            ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(email); i++)
            {
                contact.contactEmail = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(email, i);
            
                NSLog(@"Email :%@", contact.contactEmail);
                
            }
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
                contact.contactNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                NSLog(@"phone:%@", contact.contactNumber);
            }
            
            [arrayContacts addObject:contact];
            contact = nil;
            
            NSLog(@"=============================================");
        }
        
        if([arrayContacts count])
        {
            [tableInviteContacts reloadData];
            labelRecordNotFound.hidden = YES;

        }
        else
            labelRecordNotFound.hidden = NO;
        
    }
    else {
        // Send an alert telling user to change privacy setting in settings app
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)inviteContact:(int)_index
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableArray *emailArray = [[NSMutableArray alloc] init];
        [emailArray addObject:[[arrayContacts objectAtIndex:_index] contactEmail]];

        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        [dataDict setObject:emailArray forKey:@"emails"];
        [dataDict setObject:@"Hi...join us at ConnectedYet" forKey:@"message"];

        [userManager inviteContactToApplication:dataDict];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
}

#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayContacts count];
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
    static NSString *cellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
   
    ContactData *contact = [arrayContacts objectAtIndex:indexPath.row];
    
    UIImageView *imageProfile = [[UIImageView alloc]init];
    imageProfile.image = [UIImage imageNamed:@"profile.png"];
    imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    imageProfile.layer.borderWidth = 2;
        [cell.contentView addSubview:imageProfile];
    
    
    UILabel *labelName=[[UILabel alloc] init];
    labelName.TextAlignment = NSTextAlignmentLeft;
    labelName.backgroundColor = [UIColor clearColor];
    labelName.textColor = [UIColor whiteColor];
    labelName.text = [NSString stringWithFormat:@"%@ %@", contact.contactFirstName, contact.contactLastName];
        [cell.contentView addSubview:labelName];
    
    UILabel *labelNumber=[[UILabel alloc] init];
    labelNumber.TextAlignment = NSTextAlignmentLeft;
    labelNumber.backgroundColor = [UIColor clearColor];
    labelNumber.textColor = [UIColor colorWithRed:169.0/255.0 green:240.0/255.0 blue:237.0/255.0  alpha:1];
    labelNumber.text = contact.contactNumber;
    
    [cell.contentView addSubview:labelNumber];

    
    UIImageView *imageSeperator = [[UIImageView alloc]init];
    imageSeperator.image = [UIImage imageNamed:@"members-devider.png"];
    [cell.contentView addSubview:imageSeperator];
    
    
    cell.backgroundColor = [UIColor blackColor];
    
    if(appDelegate.iPad)
    {
        imageProfile.frame = CGRectMake(20, 10, 60 , 60);
        
        labelName.frame = CGRectMake(95, 10, tableView.frame.size.width-90, 30);
        labelName.font = [UIFont fontWithName:@"Helvetica" size:16];

        labelNumber.frame = CGRectMake(95, 30, tableView.frame.size.width-90, 30);
        labelNumber.font = [UIFont fontWithName:@"Helvetica" size:14];

        imageSeperator.frame = CGRectMake(10, kCellHeightiPad-1, tableView.frame.size.width-20 , 1);
        
    }
    else
    {
        imageProfile.frame = CGRectMake(10, 5, 50 , 50);
        
        labelName.frame = CGRectMake(70, 5, tableView.frame.size.width-50, 24);
        labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        labelNumber.frame = CGRectMake(70, 25, tableView.frame.size.width-50, 24);
        labelNumber.font = [UIFont fontWithName:@"Helvetica" size:12];
        
        imageSeperator.frame = CGRectMake(10, kCellHeight-1, tableView.frame.size.width-20 , 1);
        
    }
    
    imageProfile.layer.cornerRadius = imageProfile.frame.size.height/2;
    imageProfile.layer.masksToBounds = YES;

    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactData *contact = [arrayContacts objectAtIndex:indexPath.row];
    
   // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Invite %@ to ConnectedYet App",[arrayContacts objectAtIndex:indexPath.row]] message:[NSString stringWithFormat:@"%@ will be invited via SMS",[arrayContacts objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Invite", nil];
    //[alert show];
    
    NSString *strMessage = [NSString stringWithFormat:@"Invite %@ %@ to ConnectedYet App", contact.contactFirstName, contact.contactLastName];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:strMessage leftButtonTitle:@"Cancel" rightButtonTitle:NSLocalizedString(@"Ok", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock =^()
    {
        [self inviteContact:(int)indexPath.row];
    };

}

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnSkipTapped:(id)sender
{
    if(isForEdit)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {   /*
        if([appDelegate.loginType isEqualToString:kEmail])
        {
            InterestViewController *interest;
            
            if(appDelegate.iPad)
                interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController_iPad" bundle:nil];
            else
                interest = [[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];
            
            [self.navigationController pushViewController:interest animated:YES];
  
        }
        else */
        {
            ConfirmationView *confirm;
            if(appDelegate.iPad)
                confirm = [[ConfirmationView alloc]initWithNibName:@"ConfirmationView_iPad" bundle:nil];
            else
                confirm = [[ConfirmationView alloc]initWithNibName:@"ConfirmationView" bundle:nil];
            
            [self.navigationController pushViewController:confirm animated:YES];

        }
     
    }

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

-(void)successWithInviteContact:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:@"Invitation senf succesfully" leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
    [alert show];
    
}

@end
