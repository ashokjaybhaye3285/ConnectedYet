//
//  MessageDTO.h
//  ESportsHub
//
//  Created by RajeSH on 19/04/15.
//  Copyright (c) 2015 MYSApple01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chatMessageDTO : NSObject

/**
* type = 0 : For normal text messages
* type = 1 : For messages containing emoticons
* type = 2 : For join chatroom invite message
* type = 3 : For image messages
* type = 4 : For video messages
**/

@property(nonatomic,retain)NSString *messageType;
@property(nonatomic,retain)NSString *messageFromUserId;
@property(nonatomic,retain)NSString *messageToUserId;
@property(nonatomic,retain)NSString *messageId;
@property(nonatomic,retain)NSString *message;
@property(nonatomic,retain)NSString *messageOld;
@property(nonatomic,retain)NSString *messageSelf;
@property(nonatomic,retain)NSString *messageSent;

/**
 *
 * Types of messages received in this callback:
 
 * AVCHAT_CALL_ACCEPTED
 * type = 1 : Audio video call request has been accepted
 
 * AVCHAT_INCOMING_CALL
 * type = 2 : Incoming audio video call request
 
 * AVCHAT_INCOMING_CALL_USER_BUSY
 * type = 3 : Incoming audio video call request while user is busy
 
 * AVCHAT_END_CALL
 * type = 4 : Audio video call has been ended
 
 * AVCHAT_REJECT_CALL
 * type = 5 : Audio video call request has been rejected
 
 * AVCHAT_CANCEL_CALL
 * type = 6 : Audio video call has been cancelled
 
 * AVCHAT_NO_ANSWER
 * type = 7 : No answer received for audio video call request sent
 
 * AVCHAT_BUSY_CALL
 * type = 8 : Busy call received for audio video call request sent
 *
 **/

@end
