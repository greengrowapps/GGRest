
#import <Foundation/Foundation.h>
#import "GGJsoneableArray.h"
#import "GGJsoneableObject.h"
#import "NSObject+Json.h"
#import "NSDictionary+GGJson.h"
#import "NSMutableDictionary+GGJson.h"
#import "GGDateConverter.h"

@interface GGJsonHelper : NSObject

+(NSString *) JsonDicToString:(NSDictionary *)jsonDic;
+(NSDictionary *) JsonStringToDic:(NSString *) jsonString;
+(NSArray*) JsonStringArrayToArray:(NSString *) jsonArrayString;

+(void) addDateConverter:(GGDateConverter*) dateConverter;
+(NSDate*) parseDateWithConverters:(NSString *) dateString;
+(NSString *) formatDateWithConverters:(NSDate *) d;

@end
