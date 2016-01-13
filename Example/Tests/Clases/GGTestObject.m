//
//  GGTestObject.m
//  GGRest
//
//  Created by piro on 11/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGTestObject.h"
#import <GGRest/GGJsonHelper.h>

#define jskIntValue @"intValue"
#define jskFloatValue @"floatValue"
#define jskStringValue @"stringValue"


@implementation GGTestObject


-(NSMutableDictionary *)toJsonDicWithViews:(NSArray *)views{
    NSMutableDictionary *ret=[super toJsonDicWithViews:views];
    return ret;
}
-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self = [super init];
    if(self){
        self.intField=[json getIntForKey:jskIntValue];
        self.floatField=[json getFloatForKey:jskFloatValue];
        self.stringField=[json getStringForKey:jskStringValue];
    }
    return self;
}

@end
