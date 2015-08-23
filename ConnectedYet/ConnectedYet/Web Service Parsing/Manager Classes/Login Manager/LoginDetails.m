//
//  LoginDetails.m
//  Kntor
//
//  Created by IMAC05 on 12/11/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "LoginDetails.h"

@implementation LoginDetails


@synthesize userId;
@synthesize userName;

@synthesize userEmail;
@synthesize userBirthDate;

@synthesize userFirstName;
@synthesize userLastName;

@synthesize userGender;
@synthesize userProfilePic;

@synthesize userFBLink;

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        //decode properties, other class vars
        userId = [decoder decodeObjectForKey:@"userId"];
        userName = [decoder decodeObjectForKey:@"userName"];

        userEmail = [decoder decodeObjectForKey:@"userEmail"];
        userBirthDate = [decoder decodeObjectForKey:@"userBirthDate"];
        
        userFirstName = [decoder decodeObjectForKey:@"userFirstName"];
        userLastName = [decoder decodeObjectForKey:@"userLastName"];

        userGender = [decoder decodeObjectForKey:@"userGender"];
        userProfilePic = [decoder decodeObjectForKey:@"userProfilePic"];

        userFBLink = [decoder decodeObjectForKey:@"userFBLink"];

        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:userId forKey:@"customerId"];
    [encoder encodeObject:userName forKey:@"userName"];

    [encoder encodeObject:userEmail forKey:@"userEmail"];
    [encoder encodeObject:userBirthDate forKey:@"userBirthDate"];

    [encoder encodeObject:userFirstName forKey:@"userFirstName"];
    [encoder encodeObject:userLastName forKey:@"userLastName"];

    [encoder encodeObject:userGender forKey:@"userGender"];
    [encoder encodeObject:userProfilePic forKey:@"userProfilePic"];

    [encoder encodeObject:userFBLink forKey:@"userFBLink"];

}

@end
