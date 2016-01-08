

#import <Foundation/Foundation.h>
#import "GGJsonHelper.h"

@interface NSObject(Json) <GGJsoneableObject>

+(id)fromJsonObject:(NSDictionary *)jsonObject;
+(id) fromJsonString:(NSString *)json;


@end
