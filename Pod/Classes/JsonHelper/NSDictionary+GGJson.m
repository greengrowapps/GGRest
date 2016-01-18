
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#import "NSDictionary+GGJson.h"
#import "GGJsoneableArray.h"
#import "GGJsonHelper.h"

@implementation NSDictionary(GGJson)

-(NSString *) getStringForKey:(NSString *) key{
    return NULL_TO_NIL([self objectForKey:key]);
}

-(int) getIntForKey:(NSString *) key{
    NSNumber *n=NULL_TO_NIL([self objectForKey:key]);
    return [n intValue];
}
-(BOOL) getBooleanForKey:(NSString*) key{
    NSObject *o=NULL_TO_NIL([self objectForKey:key]);
    if(!o){
        return false;
    }
    NSNumber *n=(NSNumber*)o;
    return n.boolValue;
}
-(NSNumber*) getNumberForKey:(NSString *) key{
    NSNumber *n=NULL_TO_NIL([self objectForKey:key]);
    return n;
}
-(float) getFloatForKey:(NSString*)key{
    NSNumber *n=NULL_TO_NIL([self objectForKey:key]);
    return [n floatValue];
}
-(NSDate*) getDateForKey:(NSString*) key{
    NSString *dateString=[self getStringForKey:key];
    NSNumber *dateNumber=[self getNumberForKey:key];
    NSDate *d;
    
    if(!dateString && !dateNumber){return nil;}
    
    if([dateString isKindOfClass:[NSString class]]){
        
        return [GGJsonHelper parseDateWithConverters:dateString];
    }else{
        return [NSDate dateWithTimeIntervalSince1970:dateNumber.doubleValue/1000];
    }
    
    return d;
}

-(id) getObjectForKey:(NSString *) key ofType:(Class) claz{
    NSDictionary *d = NULL_TO_NIL([self objectForKey:key]);
    if(d){
        return [claz fromJsonObject:[self objectForKey:key]];
    }else{
        return nil;
    }
}


-(NSMutableArray*) getObjectArrayForKey:(NSString *) key ofType:(Class) claz{
    NSArray *a=NULL_TO_NIL([self objectForKey:key]);

    return [NSMutableArray fromJsonArray:a ofClass:claz];
    
}


@end
