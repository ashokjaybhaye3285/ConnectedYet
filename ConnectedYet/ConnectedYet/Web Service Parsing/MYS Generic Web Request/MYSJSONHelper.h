//
//  MYSJSONHelper.h
//  My Property Friend
//
//  Created by Ashwini Shahapurkar on 07/05/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSJSONHelper : NSObject

-(id)initWithDictionary:(NSString*)aDictionary;
-(void)addValue:(id)value forKey:(id)key;
-(void)addInteger:(int)value forKey:(id)key;
-(void)addFloat:(float)value forKey:(id)key;
-(void)addBoolean:(BOOL)value forKey:(id)key;
-(NSString*)description;
-(NSString*)valueForKey:(id)key;
-(int)integerForKey:(id)key;
-(float)floatForKey:(id)key;
-(BOOL)boolForKey:(id)key;
-(NSArray*)arrayForKey:(id)key;
-(void)addArray:(id)value forKey:(id)key;

@end
