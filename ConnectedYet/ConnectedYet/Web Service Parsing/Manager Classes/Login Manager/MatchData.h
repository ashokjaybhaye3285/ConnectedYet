//
//  MatchData.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 05/04/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchData : NSObject

@property (nonatomic, retain) NSString *matchSeeking;
@property (nonatomic, retain) NSString *matchAgeFrom;

@property (nonatomic, retain) NSString *matchAgeTo;
@property (nonatomic, retain) NSString *matchCountry;

@property (nonatomic, retain) NSString *matchState;
@property (nonatomic, retain) NSString *matchCity;

@property (nonatomic, retain) NSString *matchHairColor;
@property (nonatomic, retain) NSString *matchEyeColor;

@property (nonatomic, retain) NSString *matchHeight;
@property (nonatomic, retain) NSString *matchBodyType;

@property (nonatomic, retain) NSString *matchEduLevel;
@property (nonatomic, retain) NSMutableArray *matchLanguageSpeakArray;

@property (nonatomic, retain) NSString *matchEthnicity;
@property (nonatomic, retain) NSString *matchReligiousBelief;


@end
