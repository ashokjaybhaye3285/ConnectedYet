//
//  chatUser.h
//  ESportsHub
//
//  Created by RajeSH on 19/04/15.
//  Copyright (c) 2015 MYSApple01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chatUser : NSObject

@property(nonatomic,retain)NSString *userId;
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *userProfileLink;
@property(nonatomic,retain)NSString *userAvtar;
@property(nonatomic,retain)NSString *userStatus;
@property(nonatomic,retain)NSString *userCustomStatus;

@end
