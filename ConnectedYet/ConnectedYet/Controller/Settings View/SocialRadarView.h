//
//  SocialRadarView.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 30/01/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "UserManager.h"
#import "AsyncImageView.h"


@interface SocialRadarView : UIViewController <UserManagerDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate, MKMapViewDelegate>
{
    AppDelegate *appDelegate;
    UserManager *userManager;

    IBOutlet UISlider *sliderView;
   
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    int currentValue;
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *arrayUserDetails, *arrayOriginalData;
    
    float minValue, maxValue;
    MKMapView *mapView;
    IBOutlet UILabel *distanceRange;
    
    BOOL isFirstTime;
    
}

@property(nonatomic, strong) IBOutlet UIView* radarView;
@property double minSize;
@property double minRadius;
@property double widthCenter;
@property double heightCenter;

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer;

@end
