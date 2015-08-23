//
//  announcementDTO.h
//  ESportsHub
//
//  Created by RajeSH on 19/04/15.
//  Copyright (c) 2015 MYSApple01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chatAnnouncementDTO : NSObject

// Announcement from the admin to all users

@property(nonatomic,retain)NSString *announcementId;
@property(nonatomic,retain)NSString *announcementMessage;

@end
