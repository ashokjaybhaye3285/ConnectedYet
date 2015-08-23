//
//  MYSGenericJSONParser.m
//  ttest
//
//  Created by Mahesh on 25/07/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import "MYSGenericJSONParser.h"
#import <objc/runtime.h>

@implementation MYSGenericJSONParser

- (id)parseDataToMyObject:(NSMutableDictionary *)responseData inObject:(id)object
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    unsigned i;
    
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        if ([responseData valueForKey:name])
        {
            [object setValue:[responseData valueForKey:name] forKey:name];
        }
    }
    
    free(properties);
    
    return object;
}

@end
