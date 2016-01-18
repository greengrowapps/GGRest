//
//  GGAuthor.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGAuthor.h"
#import <GGRest/GGJsonHelper.h>

#define jskDate @"date"
#define jskEmail @"email"
#define jskName @"name"


@implementation GGAuthor

-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self=[super init];
    if(self){
        self.date=[json getDateForKey:jskDate];
        self.email=[json getStringForKey:jskEmail];
        self.name=[json getStringForKey:jskName];
    }
    return self;
}

@end
