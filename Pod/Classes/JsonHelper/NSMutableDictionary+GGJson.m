
#import "NSMutableDictionary+GGJson.h"
#import "GGJsoneableArray.h"
#import "GGJsonHelper.h"

@implementation  NSMutableDictionary(GGJson)

-(void) setString:(NSString*)s forKey:(NSString*)key{
    if(!s){return;}
    [self setObject:s forKey:key];
}
-(void) setInt:(int)v forKey:(NSString*)key{
    [self setObject:[NSNumber numberWithInt:v] forKey:key];
}
-(void) setFloat:(float)v forKey:(NSString*)key{
    [self setObject:[NSNumber numberWithFloat:v] forKey:key];
}

-(void) setDateInTimestampFormat:(NSDate*) d forKey:(NSString *) key{
    if(!d){return;}
    [self setObject:[NSNumber numberWithLongLong:d.timeIntervalSince1970*1000] forKey:key];
}

-(void) setDate:(NSDate*)d forKey:(NSString*)key{
    if(!d){return;}
    [self setObject:[GGJsonHelper formatDateWithConverters:d] forKey:key];
}
-(void) setBoolean:(BOOL)d forKey:(NSString*)key{
    [self setObject:[NSNumber numberWithBool:d] forKey:key];
}


-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key{
    if(!v){return;}
    [self setObjectArray:v forKey:key withWiews:nil];
}

-(void) setJsoneableObject:(id<GGJsoneableObject>) obj forKey:(NSString*) key{
    if(!obj){return;}
    [self setJsoneableObject:obj forKey:key withWiews:nil];
}

-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key withWiews:(NSArray*)views{
    if(!v){
        return;
    }
    [self setObject:[(NSMutableArray *)v toJsonArrayWithViews:views ] forKey:key];
}
-(void) setJsoneableObject:(id<GGJsoneableObject>) obj forKey:(NSString*) key withWiews:(NSArray*)views{
    if(!obj){
        return;
    }
    [self setObject:[obj toJsonDicWithViews:views] forKey:key];
}




@end
