//
//  GGCommitItem.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGCommitItem.h"
#import <GGRest/GGJsonHelper.h>


@implementation GGCommitItem

-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self= [super init];
    
    if(self){
        self.comment=[json getStringForKey:@"message"];
        self.author=[json getObjectForKey:@"author" ofType:[GGAuthor class]];
    }
    
    return self;
}

@end
