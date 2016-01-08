//
//  STJsonMutableDiccionary.h
//  LemoniOS
//
//  Created by AdriLocal on 07/08/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STJsoneableObject.h"

@interface NSMutableDictionary(STJson)

-(void) setString:(NSString*)s forKey:(NSString*)key;
-(void) setInt:(int)v forKey:(NSString*)key;
-(void) setFloat:(float)v forKey:(NSString*)key;
-(void) setDate:(NSDate*)d forKey:(NSString*)key;
-(void) setBoolean:(BOOL)v forKey:(NSString*)key;
-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key;
-(void) setJsoneableObject:(id<STJsoneableObject>) obj forKey:(NSString*) key;
-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key withWiews:(NSArray*)views;
-(void) setJsoneableObject:(id<STJsoneableObject>) obj forKey:(NSString*) key withWiews:(NSArray*)views;
+(instancetype) create;

@end
