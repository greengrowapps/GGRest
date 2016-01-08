//
//  NSObject+Json.h
//  LemoniOS
//
//  Created by AdriLocal on 07/08/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STJsonHelper.h"

@interface NSObject(Json) <STJsoneableObject>

+(id)fromJsonObject:(NSDictionary *)jsonObject;
+(id) fromJsonString:(NSString *)json;


@end
