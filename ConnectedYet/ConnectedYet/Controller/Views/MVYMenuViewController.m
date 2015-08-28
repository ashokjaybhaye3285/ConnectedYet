



#import "MVYMenuViewController.h"
#import "MVYSideMenuController.h"
#import "HomeViewController.h"

#import "SearchViewController.h"

#import "MyProfileView.h"
#import "SearchViewController.h"
#import "PartnerPreferencesView.h"
#import "LoginViewController.h"

#import "EncountersViewController.h"
#import "SocialRadarView.h"

#import "AboutUsView.h"
#import "SettingsViewController.h"

#import "UsersCommonView.h"
#import "InboxViewController.h"
#import "MatrimonyMatchView.h"

#import "CustomAlertView.h"

#define kHeaderHeight 40
#define kHeaderHeightiPad 45

#define kCellHeightiPhone 44
#define kCellHeightiPad 50


@interface MVYMenuViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation MVYMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    arrayMenuOption = [[NSMutableArray alloc]init];
    arraySection = [[NSMutableArray alloc]init];
    arrayMenuIcon = [[NSMutableArray alloc] init];
    
    [arraySection addObject:@"Account"];
    [arraySection addObject:@"Interest"];
    [arraySection addObject:@"Browse"];
    [arraySection addObject:@"Messages"];
    [arraySection addObject:@"General"];

// ---- MENU OPTION ----
    NSMutableArray *arraySection1 = [[NSMutableArray alloc]init];
    [arraySection1 addObject:@"View Profile"];
    [arraySection1 addObject:@"Edit Search Filter"];
    [arraySection1 addObject:@"Partner Preference"];
    [arraySection1 addObject:@"Logout"];
    [arraySection1 addObject:@"Contact Request"];

    NSMutableArray *arraySection2 = [[NSMutableArray alloc]init];
    [arraySection2 addObject:@"Encounters"];
    [arraySection2 addObject:@"Radar"];
    
    NSMutableArray *arraySection3 = [[NSMutableArray alloc]init];
    [arraySection3 addObject:@"Nearest"];
    [arraySection3 addObject:@"Favourites"];
    [arraySection3 addObject:@"My Matches"];
    [arraySection3 addObject:@"Liked Me"];
    [arraySection3 addObject:@"Global"];
    [arraySection3 addObject:@"My Contacts"];

    NSMutableArray *arraySection4 = [[NSMutableArray alloc]init];
    [arraySection4 addObject:@"Inbox"];
   
    NSMutableArray *arraySection5 = [[NSMutableArray alloc]init];
    [arraySection5 addObject:@"About Us"];
    [arraySection5 addObject:@"Settings"];
    
    [arrayMenuOption addObject:arraySection1];
    [arrayMenuOption addObject:arraySection2];
    [arrayMenuOption addObject:arraySection3];
    [arrayMenuOption addObject:arraySection4];
    [arrayMenuOption addObject:arraySection5];

//----------
    
// ---- MENU ICON ----
    NSMutableArray *arraySectionLogo1 = [[NSMutableArray alloc]init];
    [arraySectionLogo1 addObject:@"edit-profile-icon"];
    [arraySectionLogo1 addObject:@"search-filter-icon"];
    [arraySectionLogo1 addObject:@"partner-preferences-icon"];
    [arraySectionLogo1 addObject:@"logout-icon"];
    [arraySectionLogo1 addObject:@"contact-request-icon"];
    
    NSMutableArray *arraySectionLogo2 = [[NSMutableArray alloc]init];
    [arraySectionLogo2 addObject:@"encounters-icon"];
    [arraySectionLogo2 addObject:@"radar-icon"];
    
    NSMutableArray *arraySectionLogo3 = [[NSMutableArray alloc]init];
    [arraySectionLogo3 addObject:@"nearest-icon"];
    [arraySectionLogo3 addObject:@"favorites-icon"];
    [arraySectionLogo3 addObject:@"my-matches-icon"];
    [arraySectionLogo3 addObject:@"liked-me-icon"];
    [arraySectionLogo3 addObject:@"global-icon"];
    [arraySectionLogo3 addObject:@"my-contacts-icon"];
    
    NSMutableArray *arraySectionLogo4 = [[NSMutableArray alloc]init];
    [arraySectionLogo4 addObject:@"inbox-icon"];
    
    NSMutableArray *arraySectionLogo5 = [[NSMutableArray alloc]init];
    [arraySectionLogo5 addObject:@"about-us"];
    [arraySectionLogo5 addObject:@"settings-icon"];

    [arrayMenuIcon addObject:arraySectionLogo1];
    [arrayMenuIcon addObject:arraySectionLogo2];
    [arrayMenuIcon addObject:arraySectionLogo3];
    [arrayMenuIcon addObject:arraySectionLogo4];
    [arrayMenuIcon addObject:arraySectionLogo5];

//----------

    
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayMenuOption.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return [[arrayMenuOption objectAtIndex:section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(appDelegate.iPad)
        return kHeaderHeightiPad;
    else
        return kHeaderHeight;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelegate.iPad)
        return kCellHeightiPad;
    else
        return kCellHeightiPhone;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc] init];

    //headerView.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:32.0/255.0 blue:34.0/255.0 alpha:1];
    headerView.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    
    UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeader.tag = section;
    [headerView addSubview:btnHeader];
    
    UILabel *labelTitle=[[UILabel alloc] init];
    labelTitle.TextAlignment = NSTextAlignmentLeft;
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor colorWithRed:114.0/255.0 green:229.0/255.0 blue:242.0/242.0 alpha:1];
    [btnHeader addSubview:labelTitle];
    
    labelTitle.text = [arraySection objectAtIndex:section];
    
    
    //UIView *headerSeperator = [[UIView alloc]init];
    //headerSeperator.backgroundColor = [UIColor colorWithRed:24.0/255.0 green:24.0/255.0 blue:26.0/255.0 alpha:1];
    //headerSeperator.alpha = 0.6;
    
    UIImageView *headerSeperator = [[UIImageView alloc]init];
    headerSeperator.image = [UIImage imageNamed:@"divider-line.png"];
    
    [btnHeader addSubview:headerSeperator];
    
    if(appDelegate.iPad)
    {
        headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, kHeaderHeightiPad);
        btnHeader.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);

        labelTitle.frame = CGRectMake(20, 10, tableView.frame.size.width-40, 25);
        labelTitle.font = [UIFont fontWithName:@"Helvetica" size:18];

        headerSeperator.frame = CGRectMake(5, kHeaderHeightiPad-1, tableView.frame.size.width-10, 1);
        
    }
    else
    {
        headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, kHeaderHeight);
        btnHeader.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
        
        labelTitle.frame = CGRectMake(10, 10, tableView.frame.size.width-20, 24);
        labelTitle.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        headerSeperator.frame = CGRectMake(0, kHeaderHeight-1, tableView.frame.size.width, 1);

    }
    
    return headerView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"MenuCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

	NSString *item = [[arrayMenuOption objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *logo = [[arrayMenuIcon objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    UIImageView *imageLogo = [[UIImageView alloc]init];
    imageLogo.image = [UIImage imageNamed:logo];
    imageLogo.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageLogo];
    
    
    UILabel *labelTitle=[[UILabel alloc] init];
    labelTitle.TextAlignment = NSTextAlignmentLeft;
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.text = item;
    [cell.contentView addSubview:labelTitle];
    
    
    UIView *headerSeperator = [[UIView alloc]init];
    headerSeperator.backgroundColor = [UIColor colorWithRed:24.0/255.0 green:24.0/255.0 blue:26.0/255.0 alpha:1];
    //[cell.contentView addSubview:headerSeperator];
 
    
    UIView *cellBgView = [[UIView alloc] init];
    
    UIImageView *imageTransparent = [[UIImageView alloc] init];
    //imageTransparent.image = [UIImage imageNamed:@"button-bg"];
    imageTransparent.image = [UIImage imageNamed:@"divider-line.png"];
    imageTransparent.alpha = 0.2;
    [cellBgView addSubview:imageTransparent];
    
    cell.selectedBackgroundView = cellBgView;
    
    
    if(appDelegate.iPad)
    {
        imageLogo.frame = CGRectMake(15, 10, 30, 30);
        
        labelTitle.frame = CGRectMake(65, 10, tableView.frame.size.width-60, 30);
        labelTitle.font = [UIFont fontWithName:@"Helvetica" size:14];
      
        headerSeperator.frame = CGRectMake(0, kCellHeightiPad-1, tableView.frame.size.width, 1);
        
        imageTransparent.frame = CGRectMake(0, 5, tableView.frame.size.width, kCellHeightiPad-10);

    }
    else
    {
        imageLogo.frame = CGRectMake(10, 11, 22, 22);
        
        labelTitle.frame = CGRectMake(50, 10, tableView.frame.size.width-50, 24);
        labelTitle.font = [UIFont fontWithName:@"Helvetica" size:12];

        headerSeperator.frame = CGRectMake(0, kCellHeightiPhone-1, tableView.frame.size.width, 1);

        imageTransparent.frame = CGRectMake(0, 4, tableView.frame.size.width, kCellHeightiPhone-8);

    }
    
    

    
    cell.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1];
    
	return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[self sideMenuController] closeMenu];
    
    if(indexPath.section ==0) // Section 1
    {
        if(indexPath.row == 0) // Edit Profile
        {
            MyProfileView *profile;
            
            if(appDelegate.iPad)
                profile = [[MyProfileView alloc]initWithNibName:@"MyProfileView_iPad" bundle:nil];
            else
                profile = [[MyProfileView alloc]initWithNibName:@"MyProfileView" bundle:nil];
            
            [appDelegate.nvc pushViewController:profile animated:NO];
            

        }
        else if(indexPath.row == 1) // Edit Search Filter
        {
            SearchViewController *search;
            
            if(appDelegate.iPad)
                search = [[SearchViewController alloc]initWithNibName:@"SearchViewController_iPad" bundle:nil];
            else
                search = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:search animated:NO];

            
        }
        else if(indexPath.row == 2) // Partner Performances
        {
            /*
            PartnerPreferencesView *preference;
            if(appDelegate.iPad)
                preference = [[PartnerPreferencesView alloc]initWithNibName:@"PartnerPreferencesView_iPad" bundle:nil];
            else
                preference = [[PartnerPreferencesView alloc]initWithNibName:@"PartnerPreferencesView" bundle:nil];
            */
            
            MatrimonyMatchView *matrimonyMatch;
            
            if(appDelegate.iPad)
                matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView_iPad" bundle:nil];
            else
                matrimonyMatch = [[MatrimonyMatchView alloc]initWithNibName:@"MatrimonyMatchView" bundle:nil];
            
            matrimonyMatch.isCommingFromMatrimony = NO;
            
            [appDelegate.nvc pushViewController:matrimonyMatch animated:NO];
            

        }
        else if(indexPath.row == 3) // Logout
        {
            [self getLogOut];
            
            /*
            alertLogout = [[UIAlertView alloc]initWithTitle:@"ConnectedYet" message:@"Are you sure want to logout ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
            [alertLogout show];
            */
        }
        else if(indexPath.row == 4) // Contact Request
        {
            UsersCommonView *favourites;
            
            if(appDelegate.iPad)
                favourites = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
            else
                favourites = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
            
            favourites.strHeaderTitle = @"Contact Request";
            
            [appDelegate.nvc pushViewController:favourites animated:NO];

            
        }
        
    }
    else if(indexPath.section ==1) // Section 2
    {
        if(indexPath.row == 0) //
        {
            EncountersViewController *encounters;
            
            if(appDelegate.iPad)
                encounters = [[EncountersViewController alloc]initWithNibName:@"EncountersViewController_iPad" bundle:nil];
            else
                encounters = [[EncountersViewController alloc]initWithNibName:@"EncountersViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:encounters animated:NO];

            
        }
        else if(indexPath.row == 1)
        {
            
            SocialRadarView *radar;
            
            if(appDelegate.iPad)
                radar = [[SocialRadarView alloc]initWithNibName:@"SocialRadarView_iPad" bundle:nil];
            else
                radar = [[SocialRadarView alloc]initWithNibName:@"SocialRadarView" bundle:nil];
            
            [appDelegate.nvc pushViewController:radar animated:NO];

        }
    }
    else if(indexPath.section ==2) // Section 3
    {
        if(indexPath.row == 0) // Nearest
        {
            HomeViewController *home;
            
            if(appDelegate.iPad)
                home = [[HomeViewController alloc]initWithNibName:@"HomeViewController_iPad" bundle:nil];
            else
                home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:home animated:NO];

            
        }
        else if(indexPath.row == 1) // Favourite
        {
            UsersCommonView *favourites;
            
            if(appDelegate.iPad)
                favourites = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
            else
                favourites = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
            
            favourites.strHeaderTitle = @"Favourite";
            
            [appDelegate.nvc pushViewController:favourites animated:NO];

            
        }
        else if(indexPath.row == 2 ) // My Matches
        {
           
            UsersCommonView *myMatch;
            
            if(appDelegate.iPad)
                myMatch = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
            else
                myMatch = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
            
            myMatch.strHeaderTitle = @"My Match";
            
            [appDelegate.nvc pushViewController:myMatch animated:NO];

            
        }
        else if(indexPath.row == 3) // Liked Me
        {
            UsersCommonView *likedMe;
            
            if(appDelegate.iPad)
                likedMe = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
            else
                likedMe = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
            
            likedMe.strHeaderTitle = @"Liked Me";
            
            [appDelegate.nvc pushViewController:likedMe animated:NO];
            
        }
        else if(indexPath.row == 4) //Global
        {
            HomeViewController *home;
            
            if(appDelegate.iPad)
                home = [[HomeViewController alloc]initWithNibName:@"HomeViewController_iPad" bundle:nil];
            else
                home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:home animated:NO];

            
        }
        else if(indexPath.row == 5) // My Contact
        {
            UsersCommonView *myContact;
            
            if(appDelegate.iPad)
                myContact = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView_iPad" bundle:nil];
            else
                myContact = [[UsersCommonView alloc]initWithNibName:@"UsersCommonView" bundle:nil];
            
            myContact.strHeaderTitle = @"My Contact";
            
            [appDelegate.nvc pushViewController:myContact animated:NO];
            
        }
        
    }
    else if(indexPath.section ==3) // Section 4
    {
        if(indexPath.row == 0)
        {
            InboxViewController *inbox;
            
            if(appDelegate.iPad)
                inbox = [[InboxViewController alloc]initWithNibName:@"InboxViewController_iPad" bundle:nil];
            else
                inbox = [[InboxViewController alloc]initWithNibName:@"InboxViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:inbox animated:NO];

        }
    }
    else // Section 5  GENERAL
    {
        if(indexPath.row == 0) // About US
        {
            AboutUsView *about;
            
            if(appDelegate.iPad)
                about = [[AboutUsView alloc]initWithNibName:@"AboutUsView_iPad" bundle:nil];
            else
                about = [[AboutUsView alloc]initWithNibName:@"AboutUsView" bundle:nil];
            
            [appDelegate.nvc pushViewController:about animated:NO];
            
        }
        else   // Settings
        {
            SettingsViewController *settings;
            
            if(appDelegate.iPad)
                settings = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController_iPad" bundle:nil];
            else
                settings = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:settings animated:NO];
            
            
        }

    }
   
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == alertLogout)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            LoginViewController *login;
            
            if(appDelegate.iPad)
                login = [[LoginViewController alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
            else
                login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            
            [appDelegate.nvc pushViewController:login animated:YES];
            
            
        }
    }
    
}

-(void)getLogOut
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"logout_message", nil) leftButtonTitle:NSLocalizedString(@"cancel", nil) rightButtonTitle:NSLocalizedString(@"yes", nil) showsImage:NO];
    [alert show];
    
    alert.rightBlock = ^()
    {
        LoginViewController *login;
        
        [appDelegate clearAllData];
        
        if(appDelegate.iPad)
            login = [[LoginViewController alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
        else
            login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        
        [appDelegate.nvc pushViewController:login animated:YES];
        
    };
    
}

@end
