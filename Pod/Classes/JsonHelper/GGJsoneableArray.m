

#import "GGJsoneableArray.h"
#import "GGJsonHelper.h"

@implementation NSMutableArray (GGJsoneableObject)

-(NSString *) toJsonStringWithViews:(NSArray *)views{
    
    NSMutableString *s=[[NSMutableString alloc] init];
    [s appendString:@"["];

    for( id<GGJsoneableObject> obj in self ){
       NSString *jsonObject=[obj toJsonStringWithViews:views];
        [s appendFormat:@"%@,",jsonObject];
    }
    
    if(s.length > 1){
        [s deleteCharactersInRange:NSMakeRange(s.length-1, 1)];
    }
    
    [s appendString:@"]"];
    
    return s;
}

+(id) fromJsonString:(NSString *) json{
    NSAssert(false, @"notImplementedForArrays");
    return nil;
}

+(id) fromJsonString:(NSString *) json ofClass:(Class) claz {
    NSArray *a=[GGJsonHelper JsonStringArrayToArray:json];
    return  [self fromJsonArray:a ofClass:claz];
    
}

+(id) fromJsonArray:(NSArray *) jsonA ofClass:(Class) claz {

    NSMutableArray *ret=[[NSMutableArray alloc] init];
    
    for (NSDictionary*d in jsonA) {
        [ret addObject:[claz fromJsonObject:d]];
    }
    
    return ret;
}



-(NSArray*) toJsonArrayWithViews:(NSArray*)views{
    NSMutableArray *ret=[[NSMutableArray alloc] init];
    for( id<GGJsoneableObject> obj in self ){
        [ret addObject:[obj toJsonDicWithViews:views]];
    }
    return ret;
}


@end
