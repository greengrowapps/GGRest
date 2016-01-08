//
//  STJsoneableArray.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 4/11/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STJsoneableObject.h"


@interface NSMutableArray(STJsoneableObject) <STJsoneableObject>
-(NSArray*) toJsonArrayWithViews:(NSArray*)views;
+(id) fromJsonString:(NSString *) json ofClass:(Class) claz;
+(id) fromJsonArray:(NSArray *) jsonA ofClass:(Class) claz;

@end
