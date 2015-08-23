//
//  UsersCommonCell.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface UsersCommonCell : UITableViewCell


@property (nonatomic, retain) IBOutlet AsyncImageView *imageProfile;
@property (nonatomic, retain) IBOutlet UIImageView *imageStatus;
@property (nonatomic, retain) IBOutlet UIImageView *imageSex;
@property (nonatomic, retain) IBOutlet UIImageView *imageFavourite;

@property (nonatomic, retain) IBOutlet UILabel *labelName;
@property (nonatomic, retain) IBOutlet UILabel *labelAge;
@property (nonatomic, retain) IBOutlet UILabel *labelAddress;
@property (nonatomic, retain) IBOutlet UILabel *labelDistance;

@property (nonatomic, retain) IBOutlet UIButton *btnAccept;
@property (nonatomic, retain) IBOutlet UIButton *btnReject;

@property (nonatomic, retain) IBOutlet UILabel *labelMyMatch;

@end
