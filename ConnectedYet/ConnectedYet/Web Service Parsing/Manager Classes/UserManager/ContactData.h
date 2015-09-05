//
//  ContactData.h
//  ConnectedYet
//
//  Created by Ashok D Jaybhaye on 09/06/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactData : NSObject

@property (nonatomic, retain) NSString *contactFirstName;
@property (nonatomic, retain) NSString *contactLastName;

@property (nonatomic, retain) NSString *contactEmail;
@property (nonatomic, retain) NSString *contactNumber;

@property (nonatomic, retain) NSData *contactImageData;

@end
