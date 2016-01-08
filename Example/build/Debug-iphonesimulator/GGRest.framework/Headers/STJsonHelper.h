//
//  STJsonHelper.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 4/10/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STJsoneableArray.h"
#import "STJsoneableObject.h"
#import "NSObject+Json.h"
#import "NSDictionary+STJson.h"
#import "NSMutableDictionary+STJson.h"

@interface STJsonHelper : NSObject

+(NSString *) JsonDicToString:(NSDictionary *)jsonDic;
+(NSString *) JsonArrayOfDicToString:(NSArray *)jsonArrayOfDic;
+(NSDictionary *) JsonStringToDic:(NSString *) jsonString;
+(NSArray*) JsonStringArrayToArray:(NSString *) jsonArrayString;

+(long long) getLongLong:(NSDictionary*)jso withName:(NSString*)name;
+(BOOL) getBool:(NSDictionary*)jso withName:(NSString*)name;
+ (NSDictionary *)getObjectDictionary:(NSDictionary *)dictionary withName:(NSString *)key;
+ (NSArray *)getObjectArray:(NSDictionary *)dictionary withName:(NSString *)key;
+ (NSString *)getStringFullDateFromDate:(NSDate *)date;
+ (NSString *)getStringDateFromDate:(NSDate *)date;


+(void) setDate:(NSDate*) date toDic:(NSMutableDictionary*)dic forKey:(NSString *) key;
@end
