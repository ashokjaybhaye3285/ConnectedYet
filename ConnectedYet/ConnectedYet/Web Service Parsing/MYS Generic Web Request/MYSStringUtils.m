//
//  MYSStringUtils.m
//  MYSTayrniApp
//
//  Created by Mahesh on 25/07/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import "MYSStringUtils.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

@implementation MYSStringUtils

+ (BOOL)isStringBlank:(NSString *)string
{
    BOOL isBlank = NO;
    
    NSString *trimmed = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if (!trimmed || [trimmed isEqualToString:@""] || trimmed.length == 0)
    {
        isBlank = YES;
    }
    
    return isBlank;
}

+ (BOOL)isValidEmail:(NSString *)emailString
{
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (int)findSmallDateFrom:(NSString *)firstDateStr and:(NSString *)secondDateStr
{
    NSScanner* timeScanner=[NSScanner scannerWithString:firstDateStr];
    int year,month,day;
    [timeScanner scanInt:&year];
    [timeScanner scanString:@"-" intoString:nil]; //jump over :
    [timeScanner scanInt:&month];
    [timeScanner scanString:@"-" intoString:nil]; //jump over :
    [timeScanner scanInt:&day];
    
    NSScanner* timeScanner1=[NSScanner scannerWithString:secondDateStr];
    int year1,month1,day1;
    [timeScanner1 scanInt:&year1];
    [timeScanner1 scanString:@"-" intoString:nil]; //jump over :
    [timeScanner1 scanInt:&month1];
    [timeScanner1 scanString:@"-" intoString:nil]; //jump over :
    [timeScanner1 scanInt:&day1];
    
    if (year < year1)
    {
        return 1;
    }
    else if(year == year1)
    {
        if (month < month1)
        {
            return 1;
        }
        else if (month == month1)
        {
            if (day < day1)
            {
                return 1;
            }
            else if (day == day1)
            {
                return 0;
            }
            else
            {
                return 2;
            }
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 2;
    }
}

+ (int)findSmallTimeFrom:(NSString *)firstTimeStr and:(NSString *)secondTimeStr
{
    NSScanner* timeScanner=[NSScanner scannerWithString:firstTimeStr];
    int hours,minutes,seconds;
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&seconds];
    
    NSScanner* timeScanner1=[NSScanner scannerWithString:secondTimeStr];
    int hours1,minutes1,seconds1;
    [timeScanner1 scanInt:&hours1];
    [timeScanner1 scanString:@":" intoString:nil]; //jump over :
    [timeScanner1 scanInt:&minutes1];
    [timeScanner1 scanString:@":" intoString:nil]; //jump over :
    [timeScanner1 scanInt:&seconds1];
    
    if (hours < hours1)
    {
        return 1;
    }
    else if(hours == hours1)
    {
        if (minutes < minutes1)
        {
            return 1;
        }
        else if (minutes == minutes1)
        {
            if (seconds < seconds1)
            {
                return 1;
            }
            else if (seconds == seconds1)
            {
                return 0;
            }
            else
            {
                return 2;
            }
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 2;
    }
}

+ (int)convertTimeStringToMins:(NSString *)timeStr
{
    NSScanner* timeScanner=[NSScanner scannerWithString:timeStr];
    int hours,minutes;
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];

    minutes = minutes + (hours * 60);
    return minutes;
}

+ (NSString *)convertStringInToHex:(NSString *)_string
{
    NSData *dataString = [_string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* hexString =[[NSString stringWithFormat:@"%@",dataString] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hexString =[hexString stringByReplacingOccurrencesOfString:@">" withString:@""];
    hexString =[hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return hexString;
}

+ (NSString *)createHexStringFromDictionary:(NSDictionary *)inputDictionary
{
    NSMutableString *resultantString = [NSMutableString stringWithFormat:@""];
    
    for (NSString *key in [inputDictionary allKeys])
    {
        [resultantString  appendFormat:@"&%@=%@",key,[MYSStringUtils convertStringInToHex:[inputDictionary valueForKey:key]]];
    }
    
    return resultantString;
}

+ (NSString *)createStringFromDict:(NSDictionary *)dict
{
    NSMutableString *resultantString = [NSMutableString stringWithFormat:@""];
    
    int i = 0;
    
    for (NSString *key in [dict allKeys])
    {
        if (i == 0)
        {
            [resultantString  appendFormat:@"%@=%@",key,[dict valueForKey:key]];
        }
        else
        {
            [resultantString  appendFormat:@"&%@=%@",key,[dict valueForKey:key]];
        }
        i++;
    }
    
    return resultantString;
}

+ (void)setArrayToUserDefaults:(NSMutableArray *)array forKey:(NSString *)keyString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:keyString];
    [userDefaults synchronize];
}

+ (NSMutableArray *)getArrayFromUserDefaultsForKey:(NSString *)keyString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:keyString];
    return [array mutableCopy];
}

+ (UIImage *)imageWithColor:(UIColor *)color1 withUIImage:(UIImage *)img
{
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color1 setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -
#pragma mark - Hex Conversion

+ (NSString*)generateSignatureForString:(NSString *)inputString withKey:(NSString*)secret
{
    CCHmacContext    ctx;
    const char       *key = [secret UTF8String];
    const char       *str = [inputString UTF8String];
    unsigned char    mac[CC_MD5_DIGEST_LENGTH];
    char             hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
    char             *p;
    
    CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
    CCHmacUpdate(&ctx, str, strlen(str));
    CCHmacFinal(&ctx, mac);
    
    p = hexmac;
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++ )
    {
        snprintf( p, 3, "%02x", mac[i] );
        p += 2;
    }
    
    return [NSString stringWithUTF8String:hexmac];
}

@end
