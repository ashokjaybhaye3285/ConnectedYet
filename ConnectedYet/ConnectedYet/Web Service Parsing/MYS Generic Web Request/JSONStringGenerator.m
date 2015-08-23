//
//  JSONStringGenerator.m
//  VAnswer
//
//  Created by Optimus Prime on 30/10/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import "JSONStringGenerator.h"

@implementation JSONStringGenerator

+(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint fromDict:(NSObject *)object
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
