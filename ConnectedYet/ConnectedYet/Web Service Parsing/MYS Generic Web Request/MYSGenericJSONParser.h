//
//  MYSGenericJSONParser.h
//  ttest
//
//  Created by Mahesh on 25/07/14.
//  Copyright (c) 2014 MYS Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSGenericJSONParser : NSObject

- (id)parseDataToMyObject:(NSMutableDictionary *)responseData inObject:(id)object;

@end
