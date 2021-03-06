//
//  myAnnotation.h
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//3.1
@interface myAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (nonatomic, readwrite) int selectedIndex;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

//-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)_title selectedIndex:(int)_index;

@end
