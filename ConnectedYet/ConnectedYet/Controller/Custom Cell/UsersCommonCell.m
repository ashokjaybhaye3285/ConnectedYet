//
//  UsersCommonCell.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "UsersCommonCell.h"

@implementation UsersCommonCell


@synthesize imageProfile;
@synthesize imageStatus;
@synthesize imageSex;
@synthesize imageFavourite;

@synthesize labelName;
@synthesize labelAge;
@synthesize labelAddress;
@synthesize labelDistance;

@synthesize btnAccept;
@synthesize btnReject;

@synthesize labelMyMatch;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
