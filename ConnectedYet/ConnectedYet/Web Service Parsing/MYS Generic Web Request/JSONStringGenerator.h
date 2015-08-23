//
//  JSONStringGenerator.h
//  VAnswer
//
//  Created by Optimus Prime on 30/10/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONStringGenerator : NSDictionary

+(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint fromDict:(NSObject *)object;

@end
