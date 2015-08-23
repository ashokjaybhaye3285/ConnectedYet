//
//  MYSStringUtils.h
//  MYSTayrniApp
//
//  Created by Mahesh on 25/07/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYSStringUtils : NSObject

+ (BOOL)isStringBlank:(NSString *)string;

+ (BOOL)isValidEmail:(NSString *)emailString;

+ (UIColor*)colorWithHexString:(NSString*)hex;

+ (int)findSmallDateFrom:(NSString *)firstDateStr and:(NSString *)secondDateStr;

+ (int)findSmallTimeFrom:(NSString *)firstTimeStr and:(NSString *)secondTimeStr;

+ (int)convertTimeStringToMins:(NSString *)timeStr;

+ (NSString *)convertStringInToHex:(NSString *)_string;

+ (NSString *)createHexStringFromDictionary:(NSDictionary *)inputDictionary;

+ (NSString *)createStringFromDict:(NSDictionary *)dict;

+ (void)setArrayToUserDefaults:(NSMutableArray *)array forKey:(NSString *)keyString;

+ (NSMutableArray *)getArrayFromUserDefaultsForKey:(NSString *)keyString;

+ (UIImage *)imageWithColor:(UIColor *)color1 withUIImage:(UIImage *)img;

+ (NSString*)generateSignatureForString:(NSString *)inputString withKey:(NSString*)secret;

@end
