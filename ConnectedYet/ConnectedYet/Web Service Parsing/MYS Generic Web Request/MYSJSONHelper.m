//
//  MYSJSONHelper.m
//  My Property Friend
//
//  Created by Ashwini Shahapurkar on 07/05/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import "MYSJSONHelper.h"

@interface MYSJSONHelper()
{
    NSMutableDictionary *dictionary;
}

@end

@implementation MYSJSONHelper

-(id)init
{
    self = [super init];
    dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

-(id)initWithDictionary:(NSString*)aDictionary
{
    if([aDictionary isKindOfClass:[NSDictionary class]])
    {
        dictionary = [[NSMutableDictionary alloc] initWithDictionary:aDictionary];
    }
    else
    {
        NSDictionary *JSON =
        [NSJSONSerialization JSONObjectWithData: [aDictionary dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: nil];
        dictionary = [[NSMutableDictionary alloc] initWithDictionary:JSON];
        
    }
    
    return self;
}

-(void)addValue:(id)value forKey:(id)key
{
    [dictionary setObject:value forKey:key];
}

-(void)addInteger:(int)value forKey:(id)key
{
    [dictionary setObject:[NSNumber numberWithInt:value] forKey:key];
}

-(void)addBoolean:(BOOL)value forKey:(id)key
{
    [dictionary setObject:[NSNumber numberWithBool:value] forKey:key];
}

-(void)addFloat:(float)value forKey:(id)key
{
    [dictionary setObject:[NSNumber numberWithFloat:value] forKey:key];
}

-(NSString*)valueForKey:(id)key
{
    return [dictionary valueForKey:key];
}

-(int)integerForKey:(id)key
{
    return (int)[[dictionary valueForKey:key] integerValue];
}

-(BOOL)boolForKey:(id)key
{
    return (BOOL)[[dictionary valueForKey:key] boolValue];
}

-(float)floatForKey:(id)key
{
    return [[dictionary valueForKey:key] floatValue];
}

-(NSArray*)arrayForKey:(id)key
{
    return [dictionary valueForKey:key];
}

-(void)addArray:(id)value forKey:(id)key
{
     [dictionary setObject:value forKey:key];
}

-(NSString*)description
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];
    if (!jsonData) {
        //Deal with error
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

@end
