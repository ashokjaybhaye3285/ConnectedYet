//
//  InboxMessagesCell.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "InboxMessagesCell.h"


@implementation InboxMessagesCell


@synthesize imageProfile;
@synthesize imageStatus;
@synthesize labelName;
@synthesize labelMessage;
@synthesize labelTime;
@synthesize labelCount;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
