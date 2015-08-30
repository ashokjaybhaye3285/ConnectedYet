



#import "HomeViewController.h"
#import "MVYSideMenuController.h"
#import "HomeViewCell.h"
#import "UserDetailsView.h"
#import "UserListView.h"

#import "Constant.h"

#import "MyProfileView.h"
#import "PartnerPreferencesView.h"
#import "ProfileViewController.h"
#import "myAnnotation.h"

#import "CustomAlertView.h"

#define kCellHeight 90
#define kCellHeightiPad 110

#define METERS_PER_MILE 1609000.344

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize isYourMatch;

@synthesize chatObj;

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    arrayUserDetails = [[NSMutableArray alloc] init];
    

    btnListView.selected = YES;
    //btnListView.enabled = NO;
   
    btnGridView.selected = NO;
    btnGridView.enabled = YES;

    btnMapView.selected = NO;
    btnMapView.enabled = YES;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [imageSelection addGestureRecognizer:panGestureRecognizer];
    
    
    //[self getAllUsersDetails]; //TODO: TEMP HIDE ---- --- -- -
    
    __weak HomeViewController *weakSelf = self;
    tableUser.pullToRefreshView.arrowColor = [UIColor whiteColor];
    [tableUser addPullToRefreshWithActionHandler:^{
        
        if([currentFilterString isEqualToString:@"all"] || [currentFilterString isEqualToString:@"ALL"])
            [weakSelf getAllUsersDetails];
        else
        [weakSelf filterDataBy:currentFilterString];
        
    }];
    
    // [tableUser triggerPullToRefresh]; TODO: Programatically Trigger
    
    //[scrollGridView setContentOffset:CGPointMake(0, 0) animated:NO]
    //[scrollGridView addPullToRefreshWithActionHandler:^(){
      //   [weakSelf getAllUsersDetails];
     //}position:SVPullToRefreshPositionTop];

    //TODO: Refresh At Bottom Scroll
    //[tableUser addInfiniteScrollingWithActionHandler:^{
      //[weakSelf getAllUsersDetails];
    //}];
    
    NSLog(@"-- Chat Login :%@",[appDelegate retrieveFromUserDefaults:kChatLogin]);
    // Instantiate chat object
    self.chatObj=[ChatWrapper sharedChatWrapper];
    [self.chatObj instantiateChat];
    [self.chatObj setChatObserver:self];

    
    //BOOL isLogin = [self.chatObj isLoing];
    //NSLog(@"== Login :%d", isLogin);
    //if([[appDelegate retrieveFromUserDefaults:kChatLogin] isEqualToString:@"NO"]) //TODO:unused remove that..
    //if(!isLogin)
        [self chatLogIn];
    
}


#pragma mark -------- Chat functions ----------

-(void)viewWillDisappear:(BOOL)animated
{
    

}

-(void)chatLogIn
{
#if DEBUG
    NSLog(@"-- Chat Login From Home Screen --");
#endif
   
    
    if (![self.chatObj isLoing])
    {
        // Login with userId
        [self.chatObj loginWithUserName:appDelegate.userDetails.userName andPassword:@"12345" completionBlock:^(BOOL status){
            if (status) {
                // Login
                NSLog(@"Login success");
                [appDelegate saveToUserDefaults:kChatLogin value:@"YES"];

                
            }else{
                NSLog(@"Login fail");
                [appDelegate saveToUserDefaults:kChatLogin value:@"NO"];

            }
        }];
    }
    
   
}

-(void)didReceivedOnlineUsersList:(NSDictionary*)onlineUsersList
{
    NSLog(@"HOME  didReceivedOnlineUsersList ->%@",[onlineUsersList description]);
}

-(void)didReceivedErrorWithInfo:(NSError *)error
{
    NSLog(@"---  didReceivedErrorWithInfo --");
}

#pragma mark ---- ---- ----
#pragma mark -----  GET DATA FROM SERVER  ------

-(void)getOnlineUserData
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        isAllData = NO;
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        [userManager getAllUsersDetails:@"online"];
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }

}

-(void)getAllUsersDetails
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        isAllData = YES;

        currentFilterString = @"ALL";
        
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        [userManager getAllUsersDetails:@"all"];

    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:NSLocalizedString(@"app_name", nil) contentText:NSLocalizedString(@"network_error", nil) leftButtonTitle:nil rightButtonTitle:NSLocalizedString(@"ok", nil) showsImage:NO];
        [alert show];
        
    }
    
}

#pragma mark ---- ---- ----


-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer //TODO: MOVE UPWARD DIRECTION
{
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        int startX = btnOnline.frame.origin.x;
        int endX = btnNew.frame.origin.x + btnNew.frame.size.width/2; //imageSelection.frame.size.width;
        
        if((touchLocation.x >= startX) && (touchLocation.x <= endX))
        {
            imageSelection.frame = CGRectMake(touchLocation.x, imageSelection.frame.origin.y, imageSelection.frame.size.width, imageSelection.frame.size.height);
            
            actualX = touchLocation.x;
        }

    }

    //if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@" END  xxx : %f",touchLocation.x);
        
        actualX+= imageSelection.frame.size.width/2;
        
        if(actualX < btnAll.frame.origin.x)
            btnAnimator = btnOnline;
        else if(actualX < btnGirls.frame.origin.x)
            btnAnimator = btnAll;
        else if(actualX < btnBoys.frame.origin.x)
            btnAnimator = btnGirls;
        else if(actualX < btnNew.frame.origin.x)
            btnAnimator = btnBoys;
        else
            btnAnimator = btnNew;

        [self setSelectorAnimation:btnAnimator];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)openMenu:(id)sender {
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    if (sideMenuController) {
        [sideMenuController openMenu];
    }
}

-(void)setSelectorAnimation:(id)sender
{
    UIButton *btn = (UIButton *)sender;

    NSLog(@"-- BTN TAG :%d", (int)[sender tag]);
    
    if([sender tag] == 0)  // ONLINE
    {
        if(btnOnline.isSelected == NO)
            [self filterDataBy:@"ONLINE"];

    }
    else if([sender tag] == 1) // ALL
    {
        [self filterDataBy:@"ALL"];

    }
    else if([sender tag] == 2) // GIRLS
    {
        [self filterDataBy:@"GIRLS"];

    }
    else if([sender tag] == 3) // BOYS
    {
        [self filterDataBy:@"BOYS"];

    }
    else if([sender tag] == 4) //NEW
    {
        [self filterDataBy:@"NEW"];

    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageSelection.frame = CGRectMake(btn.frame.origin.x + btn.frame.size.width/2 -imageSelection.frame.size.width/2, imageSelection.frame.origin.y, imageSelection.frame.size.width, imageSelection.frame.size.height);
        
    }completion:^(BOOL finished){
        
    }];
    
}

#pragma mark – UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//arrayUserDetails.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayUserDetails count];

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
    static NSString *cellIdentifier = @"HomeCell";
    
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *xib;
    
    if(appDelegate.iPad)
        xib = [[NSBundle mainBundle] loadNibNamed:@"HomeViewCell_iPad" owner:self options:nil];
    else
        xib = [[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:self options:nil];

    cell = [xib objectAtIndex:0];
    
    
    UsersData *usersDataObject = [arrayUserDetails objectAtIndex:indexPath.row];
    
    cell.imageProfile.image = [ImageManager imageNamed:@"profile-placeholder.png"];
    [cell.imageProfile loadImageFromURL:usersDataObject.userProfileBig];


    if([usersDataObject.userStatus isEqualToString:@"offline"])
        cell.imageStatus.image = [UIImage imageNamed:@"status-offline"];
    else if([usersDataObject.userStatus isEqualToString:@"online"])
        cell.imageStatus.image = [UIImage imageNamed:@"status-online"];
    else
        cell.imageStatus.image = [UIImage imageNamed:@"status-away"];
    
    cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.size.height/2;
    cell.imageProfile.layer.masksToBounds = YES;
    cell.imageProfile.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
    cell.imageProfile.layer.borderWidth = 2.5;
    
    cell.labelName.text = [NSString stringWithFormat:@"%@, %@",usersDataObject.userName, usersDataObject.userAge];
    //cell.labelAddress.text = [NSString stringWithFormat:@"%@, %@, %@",usersDataObject.userCity, usersDataObject.userState, usersDataObject.userDistance];
    cell.labelAddress.text = [appDelegate getStringFromCity:usersDataObject.userCity State:usersDataObject.userState Distance:usersDataObject.userDistance];

    //cell.labelAge.text = @"21";
    //cell.labelDistance.text = @"10 km";
    
    if([usersDataObject.userGender isEqualToString:@"M"] || [usersDataObject.userGender isEqualToString:@"m"])
        cell.imageSex.image = [UIImage imageNamed:@"male-sex"];
    else if([usersDataObject.userGender isEqualToString:@"F"] || [usersDataObject.userGender isEqualToString:@"f"])
        cell.imageSex.image = [UIImage imageNamed:@"female-sex"];

    
    if(isYourMatch)
        cell.labelMatch.hidden = NO;
    else
        cell.labelMatch.hidden = YES;

    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

#pragma mark – UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];

    details.userDetails = [arrayUserDetails objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
    
}


-(IBAction)btnListViewTapped:(id)sender
{
    btnGridView.selected = NO;
    [btnGridView setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];
    
    if(btnListView.selected == NO)
    {
        btnListView.selected = YES;
        mapView.alpha = 0;
        tableUser.alpha = 0;
        
        [UIView animateWithDuration:0.6 animations:^{
            
            mapView.alpha = 0;
            tableUser.alpha = 1;
            scrollGridView.alpha = 0;
            
        }completion:^(BOOL finished){
            
        }];
    }
    
}


-(IBAction)btnMapViewTapped:(id)sender
{
    btnListView.selected = NO;
    btnGridView.selected = NO;
    [btnGridView setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];
    
    if(![mapView superview])
    {
        mapView = [[MKMapView alloc]init];
        mapView.frame = tableUser.frame;
        mapView.delegate = self;
            [self.view addSubview:mapView];
        
    }
    
    [self callMap];
    
    //mapView.alpha = 0;
    //tableUser.alpha = 1;
    
    [UIView animateWithDuration:0.6 animations:^{
        
        mapView.alpha = 1;
        tableUser.alpha = 0;
        scrollGridView.alpha = 0;
        
    }completion:^(BOOL finished){
        
    }];
    
}


-(IBAction)btnOnlineTapped:(id)sender
{
    if(btnOnline.selected == NO)
        [self setSelectorAnimation:sender];
    
}

-(IBAction)btnAllTapped:(id)sender
{
    [self setSelectorAnimation:sender];

}

-(IBAction)btnGirlsTapped:(id)sender
{
    [self setSelectorAnimation:sender];

}

-(IBAction)btnBoysTapped:(id)sender
{
    [self setSelectorAnimation:sender];

}

-(IBAction)btnNewTapped:(id)sender
{
    [self setSelectorAnimation:sender];

}


-(IBAction)btnGridViewTapped:(id)sender
{
    /*
    UserListView *list;
    
    if(appDelegate.iPad)
        list = [[UserListView alloc]initWithNibName:@"UserListView_iPad" bundle:nil];
    else
        list = [[UserListView alloc]initWithNibName:@"UserListView" bundle:nil];

    [self.navigationController pushViewController:list animated:YES];
    */
    
    btnMapView.selected = NO;
    
    if(btnGridView.selected ==NO)
    {
        btnListView.selected = NO;
        btnGridView.selected = YES;
        [btnGridView setImage:[UIImage imageNamed:@"list-icon"] forState:UIControlStateNormal];
        
        if(![scrollGridView superview])
        {
            scrollGridView = [[UIScrollView alloc]init];
            scrollGridView.frame = tableUser.frame;
            [self.view addSubview:scrollGridView];
            
        }
        
        [self setGridView];

        scrollGridView.alpha = 0;
        
        [UIView animateWithDuration:0.6 animations:^{
            
            mapView.alpha = 0;
            tableUser.alpha = 0;
            scrollGridView.alpha = 1;
            
        }completion:^(BOOL finished){
            
        }];
    }
    else
    {
        btnListView.selected = YES;
        btnGridView.selected = NO;
        [btnGridView setImage:[UIImage imageNamed:@"grid-view-icon"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.6 animations:^{
            
            mapView.alpha = 0;
            tableUser.alpha = 1;
            scrollGridView.alpha = 0;
            
        }completion:^(BOOL finished){
            
        }];

    }
    
    
}

-(IBAction)btnSettingsTapped:(id)sender
{

    
}


#pragma mark ---- ----  MAP DELEGATE ----- ------

-(void)callMap
{
    for(int i=0; i<[arrayUserDetails count]; i++)
    {
        CLLocationCoordinate2D coordinate;

        coordinate.latitude = [[[arrayUserDetails objectAtIndex:i] userLatitude] floatValue];
        coordinate.longitude = [[[arrayUserDetails objectAtIndex:i] userLongitude] floatValue];
        
        myAnnotation *annotation = [[myAnnotation alloc] initWithCoordinate:coordinate title:[NSString stringWithFormat:@"%@",[[arrayUserDetails objectAtIndex:i] userName]] selectedIndex:i];
        
        [mapView addAnnotation:annotation];

    }
        
    if([arrayUserDetails count])
    {
       // CLLocationCoordinate2D zoomLocation;
        //zoomLocation.latitude = [[[arrayUserDetails objectAtIndex:0] userLatitude] floatValue];
        //zoomLocation.longitude= [[[arrayUserDetails objectAtIndex:0] userLongitude] floatValue];
        // 2
        //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
        //[mapView setRegion:viewRegion animated:YES];
   
    }
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    myAnnotation *selectedAnnotation = view.annotation; // This will give the annotation.
    NSLog(@"-- annotationView: %@", selectedAnnotation.title);

    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:selectedAnnotation.selectedIndex];
    [self.navigationController pushViewController:details animated:YES];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //7
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //8
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[mapView
                                                                  dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        //9
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }
    else
    {
        annotationView.annotation = annotation;
    }
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}


#pragma mark ---- ---- ----- ------

-(void)setGridView
{
    
    int xPos = 0;
    int yPos = 0;
    
    int space;
    int btnWidth;
    int btnHeight;
    
    if(appDelegate.iPad)
    {
        btnWidth = (DEVICE_WIDTH-100)/4;
        btnHeight = btnWidth + 50;
        space = 20;
        xPos = space;
        
    }
    else
    {
        btnWidth = (DEVICE_WIDTH-50)/4;
        btnHeight = btnWidth + 40;
        space = 10;
        xPos = space;
    }
    
    for(id subview in scrollGridView.subviews)
        [subview removeFromSuperview];
    
    for(int i =0; i<[arrayUserDetails count]; i++)
    {
        UsersData *usersDataObject = [arrayUserDetails objectAtIndex:i];

        UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUser.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        btnUser.tag = i;
        [btnUser addTarget:self action:@selector(btnUserTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollGridView addSubview:btnUser];
        
        //[btnUser setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnUser setImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        
        
        AsyncImageView *imageUser = [[AsyncImageView alloc]init];
        imageUser.frame = CGRectMake(0, 0, btnWidth, btnWidth);
        
        imageUser.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageUser loadImageFromURL:usersDataObject.userProfileBig];

        imageUser.layer.cornerRadius = btnWidth/2;
        imageUser.layer.masksToBounds = btnWidth/2;
        imageUser.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
        imageUser.layer.borderWidth = 2.5;
        [btnUser addSubview:imageUser];
        
        UIImageView *imageStatus = [[UIImageView alloc]init];
        
        if([usersDataObject.userStatus isEqualToString:@"offline"])
            imageStatus.image = [UIImage imageNamed:@"status-offline"];
        else if([usersDataObject.userStatus isEqualToString:@"online"])
            imageStatus.image = [UIImage imageNamed:@"status-online"];
        else
            imageStatus.image = [UIImage imageNamed:@"status-away"];
        
        [btnUser addSubview:imageStatus];
        
        UIImageView *imageSex = [[UIImageView alloc]init];
        
        if([usersDataObject.userGender isEqualToString:@"f"] || [usersDataObject.userGender isEqualToString:@"F"])
            imageSex.image = [UIImage imageNamed:@"female-sex"];
        else if([usersDataObject.userGender isEqualToString:@"m"] || [usersDataObject.userGender isEqualToString:@"M"])
            imageSex.image = [UIImage imageNamed:@"male-sex"];

        [btnUser addSubview:imageSex];
        
        UILabel *labelName = [[UILabel alloc]init];
        labelName.text = [NSString stringWithFormat:@"%@", usersDataObject.userName];
        labelName.textAlignment = NSTextAlignmentCenter;
        labelName.textColor = [UIColor whiteColor];
        labelName.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelName];
        
        UILabel *labelDistance = [[UILabel alloc]init];
       
        labelDistance.text = [NSString stringWithFormat:@"%@, %@", usersDataObject.userAge, usersDataObject.userDistance ];
        labelDistance.textAlignment = NSTextAlignmentCenter;
        labelDistance.textColor = [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:255.0/255.0 alpha:1];
        labelDistance.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelDistance];
        
        
        UILabel *labelMatch = [[UILabel alloc]init];
        labelMatch.text = @"60 % Match";
        labelMatch.textAlignment = NSTextAlignmentLeft;
        labelMatch.textColor = [UIColor whiteColor];
        labelMatch.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:57.0/255.0 blue:118.0/255.0 alpha:1];
        //labelMatch.backgroundColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1];
        [btnUser addSubview:labelMatch];

        if(isYourMatch)
            labelMatch.hidden = NO;
        else
            labelMatch.hidden = YES;
        
        if(appDelegate.iPad)
        {
            labelMatch.frame = CGRectMake(0, 0, 80, 24);
            
            imageStatus.frame = CGRectMake(btnWidth-35, 15, 20, 20);
            imageSex.frame = CGRectMake(btnWidth-35, btnHeight-25-50, 25, 25);
            
            labelName.frame = CGRectMake(5, btnHeight-50, btnWidth-10, 30);
            labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
            
            labelMatch.font = [UIFont fontWithName:@"Helvetica" size:14];

            labelName.font = [UIFont fontWithName:@"Helvetica" size:16];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:14];
            
        }
        else
        {
            labelMatch.frame = CGRectMake(0, 0, 45, 10);

            imageStatus.frame = CGRectMake(btnWidth-20, 0, 10, 10);
            imageSex.frame = CGRectMake(btnWidth-20, btnHeight-15-40, 15, 15);
            
            labelName.frame = CGRectMake(5, btnHeight-40, btnWidth-10, 20);
            labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
            
            labelMatch.font = [UIFont fontWithName:@"Helvetica" size:8];

            labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:12];
            
        }
        
        xPos+= btnWidth + space;
        
        if ((i+1)%4==0)
        {
            xPos = space;
            yPos+= btnHeight +space;
        }
    }
    
    scrollGridView.contentSize = CGSizeMake(scrollGridView.frame.size.width, yPos);
    
}

-(void)btnUserTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Tag :%d",(int)[sender tag]);
#endif
    
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)filterDataBy:(NSString *)_key
{
#if DEBUG
    NSLog(@"-- Filter Key :%@",_key);
#endif
    
    currentFilterString = _key;
    
    [arrayUserDetails removeAllObjects];
    
    if([_key isEqualToString:@"ONLINE"]) // ONLINE
    {
        [self getOnlineUserData];
    }
    else
    {
        btnOnline.selected = NO;
        
        for(int i =0; i<[arrayOriginalData count]; i++)
        {
            if([_key isEqualToString:@"BOYS"]) //BOYS
            {
                if([[[arrayOriginalData objectAtIndex:i] userGender] isEqualToString:@"m"] || [[[arrayOriginalData objectAtIndex:i] userGender] isEqualToString:@"M"])
                {
                    [arrayUserDetails addObject:[arrayOriginalData objectAtIndex:i]];
                }
                
            }
            else if([_key isEqualToString:@"GIRLS"]) // Girls
            {
                if([[[arrayOriginalData objectAtIndex:i] userGender] isEqualToString:@"f"] || [[[arrayOriginalData objectAtIndex:i] userGender] isEqualToString:@"F"])
                {
                    [arrayUserDetails addObject:[arrayOriginalData objectAtIndex:i]];
                }
                
            }
            else if([_key isEqualToString:@"NEW"]) // NEW
            {
                if([[[arrayOriginalData objectAtIndex:i] userIsNew] intValue] == 1)
                {
                    [arrayUserDetails addObject:[arrayOriginalData objectAtIndex:i]];
                }
                
            }
            else if([_key isEqualToString:@"ALL"]) // ALL
            {
                [arrayUserDetails addObject:[arrayOriginalData objectAtIndex:i]];
                
            }
            
        }
    }
    
    if(btnGridView.selected == YES)
        [self setGridView];
    else
    {
        [tableUser.pullToRefreshView stopAnimating];  //TODO: Stop pull to refresh
        [tableUser reloadData];
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


-(void)successWithUserListDetails:(NSMutableArray *)_dataArray
{
#if DEBUG
    NSLog(@"--- User List :%@",_dataArray);
#endif
    
    [appDelegate stopSpinner];

    [tableUser.pullToRefreshView stopAnimating];  //TODO: Stop pull to refresh

    
    if([_dataArray count])
    {
        if(isAllData)
            arrayOriginalData = [[NSMutableArray alloc] initWithArray:_dataArray];
        else
            btnOnline.selected = YES;

        arrayUserDetails = _dataArray;
        
        
        if(btnGridView.selected == YES)
            [self setGridView];
        else
            [tableUser reloadData];
        
    }
    else
    {
        
    }

}

-(void)successWithLogOut:(NSString *)_message
{
#if DEBUG
    NSLog(@"--- Log Out :%@",_message);
#endif
    
}

@end
