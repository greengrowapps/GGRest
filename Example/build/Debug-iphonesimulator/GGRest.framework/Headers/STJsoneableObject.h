//
//  STJsoneableObject.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 4/9/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol STJsoneableObject <NSObject>

-(NSString*) toJsonStringWithViews:(NSArray*)views;

@required
- (instancetype)initWithJsonDic:(NSDictionary*) json;
-(NSMutableDictionary *) toJsonDicWithViews:(NSArray*)views;


@end