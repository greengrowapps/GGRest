

#import "NSObject+Json.h"

@implementation  NSObject(Json)


- (instancetype)initWithJsonDic:(NSDictionary*) json;
{
    return self;
}



+(id)fromJsonObject:(NSDictionary *)jsonObject{
    return [[self alloc] initWithJsonDic:jsonObject];
}

+(id) fromJsonString:(NSString *)json{
    NSDictionary *dic=[GGJsonHelper JsonStringToDic:json];
    if(!dic){
        return nil;
    }
    return [self fromJsonObject:dic];
}


-(NSString *)toJsonStringWithViews:(NSArray *)views{
    return [GGJsonHelper JsonDicToString:[self toJsonDicWithViews:views]];
}


-(NSMutableDictionary *) toJsonDicWithViews:(NSArray *)views{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    return dic;
}

@end
