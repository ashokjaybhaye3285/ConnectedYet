//
//  ChatHistoryData.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 07/06/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatHistoryData : NSObject

@property (nonatomic, retain) NSString *messageId;
@property (nonatomic, retain) NSString *message;

@property (nonatomic, retain) NSString *messageFromId;
@property (nonatomic, retain) NSString *messageToId;

@property (nonatomic, retain) NSString *messageRead;
@property (nonatomic, retain) NSString *messageDirection;

@property (nonatomic, retain) NSString *messageSent;


@property (nonatomic, retain) NSString *otherChatUserId;
@property (nonatomic, retain) NSMutableArray *arrayOneToOneChat;


@end
