//
//  InboxMessagesCell.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface InboxMessagesCell : UITableViewCell


@property (nonatomic, retain) IBOutlet AsyncImageView *imageProfile;
@property (nonatomic, retain) IBOutlet UIImageView *imageStatus;


@property (nonatomic, retain) IBOutlet UILabel *labelName;
@property (nonatomic, retain) IBOutlet UILabel *labelMessage;
@property (nonatomic, retain) IBOutlet UILabel *labelTime;
@property (nonatomic, retain) IBOutlet UILabel *labelCount;


@end
