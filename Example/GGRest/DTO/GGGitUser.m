//
//  GGGitUser.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGGitUser.h"
#import <GGRest/GGJsonHelper.h>

#define jskUsername @"login"

@implementation GGGitUser

-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self=[super init];
    if(self){
        self.username = [json getStringForKey:jskUsername];
    }
    return self;
}

@end
