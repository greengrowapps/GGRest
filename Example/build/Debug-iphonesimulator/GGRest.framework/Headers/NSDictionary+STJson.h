//
//  STJsonDictionary.h
//  LemoniOS
//
//  Created by AdriLocal on 07/08/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(STJson)
-(NSString *) getStringForKey:(NSString *) key;
-(int) getIntForKey:(NSString *) key;
-(NSNumber*) getNumberForKey:(NSString *) key;
-(float) getFloatForKey:(NSString*)key;
-(NSDate*) getDateForKey:(NSString*) key;
-(BOOL) getBooleanForKey:(NSString*) key;
-(id) getObjectForKey:(NSString *) key ofType:(Class) claz;
-(NSMutableArray*) getObjectArrayForKey:(NSString *) key ofType:(Class) claz;
@end
