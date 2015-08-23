//
//  wallPostsCell.m
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 09/05/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "wallPostsCell.h"

@implementation wallPostsCell

@synthesize labelPostTitle;
@synthesize labelPostDateTime;
@synthesize labelLikeComment;

@synthesize imagePostProfile;
@synthesize imagePost;

@synthesize imageBg;

@synthesize btnLike;
@synthesize btnComment;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
