//
//  SocialRadarView.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 30/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "SocialRadarView.h"
#import "Constant.h"

#import "CustomAlertView.h"
#import "LoadremoteImages.h"

#import "UserDetailsView.h"
#import "myAnnotation.h"

#define METERS_PER_MILE 1609000.344


@interface SocialRadarView ()
{
    UIView *hand;
    NSMutableArray *targets;

}
@end

@implementation SocialRadarView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    arrayUserDetails = [[NSMutableArray alloc]init];
    
    if(DEVICE_HEIGHT == 480)
    {
        CGRect newFrame = self.radarView.frame;
        newFrame.size.height-= 45;
        self.radarView.frame = newFrame;
    }
    
     self.minSize = (MIN(self.radarView.frame.size.width, self.radarView.frame.size.height) -10);
     self.minRadius = (self.minSize/6);
     self.widthCenter = self.radarView.frame.size.width/2;
     self.heightCenter = self.radarView.frame.size.height/2;
    
    currentValue = 10;
    
    [self getCurrentLocation];
    
    //[self getAllUsersDetails];
    [self getRadarUsersDetails];

    //[self createGridSheet];
    [self createContourLine];
    [self createHand];
    [self start];
    
    [self setScrollView];
    
    UIImageView *imageScrollBg = [[UIImageView alloc]init];
    imageScrollBg.frame = scrollView.frame;
    imageScrollBg.image = [UIImage imageNamed:@"bg-transparent"];
    [self.view addSubview:imageScrollBg];

}


-(void)getCurrentLocation
{
    if ([CLLocationManager locationServicesEnabled])
    {
        isFirstTime = YES;
        
        locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])//TODO: Add Key in plist -
        {
            [locationManager requestWhenInUseAuthorization];
        }
        
        [locationManager startUpdatingLocation];
        
    }
    
}

-(void)getRadarUsersDetails
{
    if([MYSBaseProxy isNetworkAvailable])
    {
        [appDelegate startSpinner];
        
        userManager = [[UserManager alloc]init];
        [userManager setUserManagerDelegate:self];
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        
        NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
        
        [dataDict setObject:latitude forKey:@"latitude"];
        [dataDict setObject:longitude forKey:@"longitude"];
        
        [userManager getRadarUsersDetails:dataDict];

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


-(void)setScrollView
{
    NSLog(@"-- Scroll View : %@", NSStringFromCGSize(scrollView.frame.size));
    NSLog(@"-- Radar users : %@", arrayUserDetails);

    int xPos = 0;
    int yPos = 0;
    
    int btnWidth;
    int btnHeight;

    for(id subview in scrollView.subviews)
        [subview removeFromSuperview];

    if(appDelegate.iPad)
    {
        btnWidth =140;
        btnHeight = btnWidth + 40;

    }
    else
    {
        if(DEVICE_HEIGHT == 480)
        {
            CGRect newframe = scrollView.frame;
            newframe.origin.y = 313;
            scrollView.frame = newframe;
        }
        
        btnWidth = (DEVICE_WIDTH-20)/4;
        btnHeight = btnWidth + 40;

    }
    
    
    for(int i =0; i<[arrayUserDetails count]; i++)
    {
        UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUser.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        btnUser.tag = i;
        [btnUser addTarget:self action:@selector(btnUserTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnUser];
        
        //[btnUser setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnUser setImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        
        AsyncImageView *imageUser = [[AsyncImageView alloc]init];
        imageUser.frame = CGRectMake(5, 5, btnWidth-5, btnWidth-5);
        
        imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
        imageUser.layer.masksToBounds = YES;
        imageUser.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
        imageUser.layer.borderWidth = 2.5;
       
        imageUser.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageUser loadImageFromURL:[[arrayUserDetails objectAtIndex:i] userProfileMedium]];
        
     
        [btnUser addSubview:imageUser];
        
        
        UIImageView *imageStatus = [[UIImageView alloc]init];
        if(i%2==0)
            imageStatus.image = [UIImage imageNamed:@"status-offline"];
        else if(i%3==0)
            imageStatus.image = [UIImage imageNamed:@"status-online"];
        else
            imageStatus.image = [UIImage imageNamed:@"status-away"];
        
        //[btnUser addSubview:imageStatus];
        
        UIImageView *imageSex = [[UIImageView alloc]init];
        imageSex.image = [UIImage imageNamed:@"female-sex"];
        [btnUser addSubview:imageSex];
        
        UILabel *labelName = [[UILabel alloc]init];
        labelName.frame = CGRectMake(5, btnHeight-40, btnWidth-10, 20);
        labelName.text = [[arrayUserDetails objectAtIndex:i] userName];
        labelName.textAlignment = NSTextAlignmentCenter;
        labelName.textColor = [UIColor whiteColor];
        labelName.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelName];
        
        UILabel *labelDistance = [[UILabel alloc]init];
        labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
        labelDistance.text = [NSString stringWithFormat:@"%@, %@", [[arrayUserDetails objectAtIndex:i] userAge], [[arrayUserDetails objectAtIndex:i] userDistance]];
        labelDistance.textAlignment = NSTextAlignmentCenter;
        labelDistance.textColor = [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:255.0/255.0 alpha:1];
        labelDistance.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelDistance];
        
        if(appDelegate.iPad)
        {
            //imageStatus.frame = CGRectMake(btnWidth-35, 15, 20, 20);
            imageSex.frame = CGRectMake(btnWidth-35, btnHeight-25-45, 25, 25);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:16];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:14];
            
        }
        else
        {
            //imageStatus.frame = CGRectMake(btnWidth-20, 0, 10, 10);
            imageSex.frame = CGRectMake(btnWidth-20, btnHeight-15-50, 15, 15);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:12];
            
        }
        
        xPos+= btnWidth + 5;
        
        
    }
    
    scrollView.contentSize = CGSizeMake(xPos, scrollView.frame.size.height);
    distanceRange.text = [NSString stringWithFormat:@"%d person in range",(int)[arrayUserDetails count]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    MVYSideMenuController *sideMenuController = [self sideMenuController];
    
    if (sideMenuController) {
        
        [sideMenuController openMenu];
        
    }
    

}

-(IBAction)btnMinusTapped:(id)sender
{
    if(currentValue != 1)
    {
        --currentValue;
    
        if(currentValue)
            sliderView.value =  currentValue;
        
        [self getSortedUser];
        
    }
    
}

-(IBAction)btnPlusTapped:(id)sender
{
    if(currentValue != 10)
    {
        ++currentValue;
        
        if(currentValue)
            sliderView.value =  currentValue;
        
        [self getSortedUser];

    }
    
}


-(void)btnUserTapped:(id)sender
{
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:details animated:YES];
    
}


//Mahendra radar code

- (void)createContourLine
{
    /*
    float mapSize = self.minRadius*6;
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(self.widthCenter,self.heightCenter, mapSize, mapSize)];
    mapView.backgroundColor = [UIColor redColor];
    mapView.delegate = self;
    mapView.center = CGPointMake(self.widthCenter, self.heightCenter);
    mapView.layer.cornerRadius = mapSize/2;
    mapView.layer.masksToBounds = YES;
    [self.radarView addSubview:mapView];
    */
    
    float radius[] = {self.minRadius, self.minRadius*2, self.minRadius*3};
    for (int i=0; i<3; i++) {
        float size = radius[i] * 2.0;

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.widthCenter,self.heightCenter, size, size)];
        line.backgroundColor = [UIColor clearColor];
       // line.layer.borderColor = [self color:3].CGColor;
        line.layer.borderColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1.0].CGColor;
        
        line.layer.borderWidth = 2;
        line.center = CGPointMake(self.widthCenter, self.heightCenter);
        line.layer.cornerRadius = radius[i];
        [self.radarView addSubview:line];
        
    }
}

- (void)createHand
{
    hand = [[UIView alloc] initWithFrame:CGRectMake(self.widthCenter, self.heightCenter, self.minSize/2, 4)];
    hand.backgroundColor = [UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1.0]; //[self color:3];
    [self.radarView addSubview:hand];
    hand.layer.anchorPoint = CGPointMake(0, 0.5);
    hand.layer.position = CGPointMake(self.widthCenter, self.heightCenter);
    
}

- (void)createTargets
{
    targets = [[NSMutableArray alloc] init];
    
    for(id subview in self.radarView.subviews)
    {
        if([subview isKindOfClass:[AsyncImageView class]])
            [subview removeFromSuperview];
    }
    
    for (int i = 1; i < [arrayUserDetails count]; i++)
    {
        //float x = arc4random() % 152 + 10;
        //float y = arc4random() % 115 + 10;
    
        float x = self.widthCenter + ([[[arrayUserDetails objectAtIndex:i] userLatitude] intValue] % (int)self.minRadius);
        float y = self.heightCenter + ([[[arrayUserDetails objectAtIndex:i] userLongitude] intValue] % (int)self.minRadius);

        NSLog(@"-- CENTER: XX: %f    YY : %f", self.widthCenter, self.heightCenter);
        NSLog(@"-- Lattitude: %f", [[[arrayUserDetails objectAtIndex:i] userLatitude] floatValue]);
        NSLog(@"-- Longi: %f ", [[[arrayUserDetails objectAtIndex:i] userLongitude] floatValue]  );

        AsyncImageView *imageRadar = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        imageRadar.tag = i;
        imageRadar.userInteractionEnabled = YES;
        
        imageRadar.layer.cornerRadius = imageRadar.frame.size.width/2;
        imageRadar.layer.masksToBounds = YES;
        
        imageRadar.image = [ImageManager imageNamed:@"profile-placeholder.png"];
        [imageRadar loadImageFromURL:[[arrayUserDetails objectAtIndex:i] userProfileMedium]];
        
       
        UIGestureRecognizer *gesRecognizer;
        gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; // Declare the Gesture.
        gesRecognizer.delegate = self;
        [imageRadar addGestureRecognizer:gesRecognizer];
        
        //UIView *t = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageRadar.center = CGPointMake(x, y);
        imageRadar.backgroundColor = [self color:3];
        imageRadar.alpha = 0.0;
        [self.radarView addSubview:imageRadar];
        [targets addObject:imageRadar];
    }
}

- (void)start
{
    [NSTimer scheduledTimerWithTimeInterval:1.5/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)tick:(NSTimer*)sender
{
    hand.transform = CGAffineTransformRotate(hand.transform, M_PI * 0.01);
    float angle = [[hand.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, 0, self.minSize/2, 3);
    line.anchorPoint = CGPointMake(0, 0.5);
    line.position = CGPointMake(self.widthCenter, self.heightCenter);
    line.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    line.backgroundColor = [UIColor colorWithRed:126.0/255.0 green:243.0/255.0 blue:238.0/255.0 alpha:1.0].CGColor;//[self color:3].CGColor;
    line.opacity = 0;
    [self.radarView.layer addSublayer:line];
    
    
    for (int i=0; i<[targets count]; i++) {
        UIView *t = [targets objectAtIndex:i];
        if ([hand.layer.presentationLayer hitTest:t.center]) {
            t.alpha = 0.95;
            [UIView animateWithDuration:1.5 animations:^{
                //t.alpha = 0.0;
            }];
        }
    }
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @1.0;
    fade.toValue = @0;
    fade.duration = 0.5;
    [line addAnimation:fade forKey:nil];
    [line performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:0.5];
    
}

- (void)createGridSheet
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    float size = 32;
    for (int i=0; i<320/size; i++) {
        [path moveToPoint:CGPointMake(i * size, 0)];
        [path addLineToPoint:CGPointMake(i * size, 568)];
    }
    
    for (int i=0; i<568/size; i++) {
        [path moveToPoint:CGPointMake(0, i*size)];
        [path addLineToPoint:CGPointMake(320, i*size)];
    }
    
    CAShapeLayer *sl = [[CAShapeLayer alloc] init];
    sl.strokeColor = [self color:1].CGColor;
    sl.lineWidth = 1;
    sl.path = path.CGPath;
    
    [self.radarView.layer addSublayer:sl];
}

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (UIColor*)color:(int)i
{
    switch (i) {
        case 0:
            return UIColorHex(0x122B1C);
        case 1:
            return UIColorHex(0x467339);
        case 2:
            return UIColorHex(0x78AB46);
        case 3:
            return UIColorHex(0xB5ED63);
        case 4:
            return UIColorHex(0xF2F7CD);
        default:
            break;
    }
    return nil;
}



- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    UserDetailsView *details;
    
    if(appDelegate.iPad)
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView_iPad" bundle:nil];
    else
        details = [[UserDetailsView alloc]initWithNibName:@"UserDetailsView" bundle:nil];
    
    details.userDetails = [arrayUserDetails objectAtIndex:gestureRecognizer.view.tag];
    [self.navigationController pushViewController:details animated:YES];

    /*
    NSLog(@"Tapped");
    UIView* view = gestureRecognizer.view;
    NSLog(@"%ld",(long)view.tag);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[arrayUserDetails objectAtIndex:view.tag] userName]
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 10, 85, 50)];

    
    LoadremoteImages *remote = [[LoadremoteImages alloc]initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height) ];
    //[remote setfreamval:0 andy:0 andw:remote.frame.size.width andh:remote.frame.size.height];
    //[remote.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [remote setImageWithURL:[NSURL URLWithString:[[arrayUserDetails objectAtIndex:view.tag] userProfileMedium]] placeholderImage:[UIImage imageNamed:@"profile-placeholder"]];
    remote.contentMode = UIViewContentModeScaleAspectFit;
    
    //[imageView setImage:remote];
    
    //check if os version is 7 or above
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [alert setValue:remote forKey:@"accessoryView"];
    }else{
        [alert addSubview:remote];
    }
    
    [alert show];
    */
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [appDelegate stopSpinner];
    
    if ([error domain] == kCLErrorDomain)
    {
        // We handle CoreLocation-related errors here
        switch ([error code])
        {
            case kCLErrorDenied:
            case kCLErrorLocationUnknown:
            {
                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:@"ConnectedYet" contentText:@"Please enable location services for your application" leftButtonTitle:nil rightButtonTitle:@"OK" showsImage:NO];
                [alert show];
                
            }
            default:
                break;
        }
        
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:@"ConnectedYet" contentText:error.description leftButtonTitle:nil rightButtonTitle:@"OK" showsImage:NO];
        [alert show];
    }
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        NSLog(@"-- Longitude :%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"-- Latitude :%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations //TODO: Used for ios7 & 8
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    
#if DEBUG
    NSLog(@" Latitude : %.8f", currentLocation.coordinate.latitude);
    NSLog(@" Longitude: %.8f", currentLocation.coordinate.longitude);
#endif
 
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self getRadarUsersDetails];

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
    [appDelegate stopSpinner];

#if DEBUG
    NSLog(@"--- User List :%@",_dataArray);
#endif
    
    arrayUserDetails = _dataArray;
    
    [self setScrollView];
    [self createTargets];

}


-(void)successWithRadarUsers:(NSMutableArray *)_dataArray
{
#if DEBUG
    NSLog(@"--- Radar User List :%@",_dataArray);
#endif
    
    [appDelegate stopSpinner];
    
    arrayOriginalData = [[NSMutableArray alloc]initWithArray:_dataArray];
    arrayUserDetails = [[NSMutableArray alloc]initWithArray:_dataArray];
    
    [self getMinMaxDistance:arrayUserDetails];
    [self setScrollView];
    [self createTargets];
    //[self callMap];
    
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
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = [[[arrayUserDetails objectAtIndex:0] userLatitude] floatValue];
        zoomLocation.longitude= [[[arrayUserDetails objectAtIndex:0] userLongitude] floatValue];
        // 2
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
        [mapView setRegion:viewRegion animated:YES];
        
    }
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //7
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //8
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        //9
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }else {
        annotationView.annotation = annotation;
    }
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}


#pragma mark ---- ---- ----- ------

-(IBAction)sliderRadarChanged:(UISlider *)sender
{
    currentValue = (int)sender.value;
    NSLog(@"-- VALUE : %d",(int)sender.value);

    [self getSortedUser];

}

-(void)getMinMaxDistance:(NSMutableArray *)_dataArray
{
    if([_dataArray  count])
    {
        minValue = [[[_dataArray objectAtIndex:0] userDistance] floatValue];
        maxValue = [[[_dataArray objectAtIndex:0] userDistance] floatValue];

        for(int j = 1 ; j<[_dataArray count]; j++)
        {
            if(minValue > [[[_dataArray objectAtIndex:j] userDistance] floatValue])
                minValue = [[[_dataArray objectAtIndex:j] userDistance] floatValue];

            if(maxValue < [[[_dataArray objectAtIndex:j] userDistance] floatValue])
                maxValue = [[[_dataArray objectAtIndex:j] userDistance] floatValue];

        }
    }
    
    //distanceRange.text = [NSString stringWithFormat:@"%.2f - %.2f",minValue, maxValue];

}

-(void)getSortedUser
{
    float upperLimit = minValue + ((maxValue-minValue)/10)*currentValue;

    [arrayUserDetails removeAllObjects];
    
    NSLog(@"--- Float :%f", upperLimit);
    
    for(int i = 0; i<[arrayOriginalData count]; i++)
    {
        NSLog(@"--- Distance :%f", [[[arrayOriginalData objectAtIndex:i] userDistance] floatValue]);

        if([[[arrayOriginalData objectAtIndex:i] userDistance] floatValue] <= upperLimit)
        {
            [arrayUserDetails addObject:[arrayOriginalData objectAtIndex:i]];
        }
    }
    
    [self setScrollView];
    [self createTargets];

}


@end
