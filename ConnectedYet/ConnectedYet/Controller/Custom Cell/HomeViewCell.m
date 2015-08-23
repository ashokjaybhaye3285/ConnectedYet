//
//  HomeViewCell.m
//  ConnectedYet
//
//  Created by IMAC05 on 11/12/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "HomeViewCell.h"

@implementation HomeViewCell


@synthesize imageProfile;
@synthesize imageStatus;
@synthesize imageSex;
@synthesize labelName;
@synthesize labelAge;
@synthesize labelAddress;
@synthesize labelDistance;

@synthesize labelMatch;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
