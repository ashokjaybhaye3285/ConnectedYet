//
//  HomeViewCell.h
//  ConnectedYet
//
//  Created by IMAC05 on 11/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface HomeViewCell : UITableViewCell


@property (nonatomic, retain) IBOutlet AsyncImageView *imageProfile;
@property (nonatomic, retain) IBOutlet UIImageView *imageStatus;
@property (nonatomic, retain) IBOutlet UIImageView *imageSex;

@property (nonatomic, retain) IBOutlet UILabel *labelName;
@property (nonatomic, retain) IBOutlet UILabel *labelAge;
@property (nonatomic, retain) IBOutlet UILabel *labelAddress;
@property (nonatomic, retain) IBOutlet UILabel *labelDistance;

@property (nonatomic, retain) IBOutlet UILabel *labelMatch;

@end
