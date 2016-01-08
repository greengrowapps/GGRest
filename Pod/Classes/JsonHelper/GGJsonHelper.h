
#import <Foundation/Foundation.h>
#import "GGJsoneableArray.h"
#import "GGJsoneableObject.h"
#import "NSObject+Json.h"
#import "NSDictionary+GGJson.h"
#import "NSMutableDictionary+GGJson.h"

@interface GGJsonHelper : NSObject

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
