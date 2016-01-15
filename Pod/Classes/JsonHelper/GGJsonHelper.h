
#import <Foundation/Foundation.h>
#import "GGJsoneableArray.h"
#import "GGJsoneableObject.h"
#import "NSObject+Json.h"
#import "NSDictionary+GGJson.h"
#import "NSMutableDictionary+GGJson.h"

@interface GGJsonHelper : NSObject

+(NSString *) JsonDicToString:(NSDictionary *)jsonDic;
+(NSDictionary *) JsonStringToDic:(NSString *) jsonString;
+(NSArray*) JsonStringArrayToArray:(NSString *) jsonArrayString;



@end
