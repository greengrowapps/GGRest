//
//  GGTestObject.m
//  GGRest
//
//  Created by piro on 11/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGTestObject.h"
#import <GGRest/GGJsonHelper.h>

@implementation GGTestObject


-(NSMutableDictionary *)toJsonDicWithViews:(NSArray *)views{
    NSMutableDictionary *ret=[super toJsonDicWithViews:views];
    return ret;
}
-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self = [super init];
    
    return self;
}

@end
