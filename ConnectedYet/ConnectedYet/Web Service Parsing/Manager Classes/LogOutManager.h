//
//  LogOutManager.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 17/05/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSGenericProxy.h"

@protocol  LogOutManagerDelegate <NSObject>

-(void)requestFailWithError:(NSString *)_errorMessage;


@optional
-(void)successWithLogOut:(NSString *)_message;

-(void)problemForGettingResponse:(NSString *)_message;
@end


@interface LogOutManager : NSObject <MYSWebRequestProxyDelegate>
{
    MYSGenericProxy *proxy;
    
}

@property (nonatomic, assign) id<LogOutManagerDelegate>logOutManagerDelegate;

-(void)getLogOut;   // Get Log Out

@end
