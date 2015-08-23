//
//  wallPostsCell.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 09/05/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface wallPostsCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelPostTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelPostDateTime;
@property (nonatomic, retain) IBOutlet UILabel *labelLikeComment;

@property (nonatomic, retain) IBOutlet AsyncImageView *imagePostProfile;
@property (nonatomic, retain) IBOutlet AsyncImageView *imagePost;

@property (nonatomic, retain) IBOutlet UIImageView *imageBg;

@property (nonatomic, retain) IBOutlet UIButton *btnLike;
@property (nonatomic, retain) IBOutlet UIButton *btnComment;

@end
