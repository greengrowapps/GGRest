//
//  GGHttpResponse.m
//  Pods
//
//  Created by piro on 11/1/16.
//
//

#import "GGHttpResponse.h"
#import "GGJsonHelper.h"

@implementation GGHttpResponse

- (instancetype)initWithCode:(int) code
                        data:(NSData*) data
                     headers:(GGHeaders*) h
{
    self = [super init];
    if (self) {
        _code=code;
        _data=[data copy];
        _headers=h;
    }
    return self;
}

-(NSString*) getContentString{
    if(!self.data || self.data.length == 0){
        return nil;
    }
    
    NSString *ret=[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    if(!ret){
        ret=[[NSString alloc] initWithData:self.data encoding:NSWindowsCP1252StringEncoding];
    }
    
    return ret;
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"CODE: %d CONTENT:%@",self.code , [self getContentString]];
}

-(id) getObject:(Class)targetClass{
    return [targetClass fromJsonString:[self getContentString]];
    
}
-(NSArray *) getObjectsArray:(Class)targetClass{
    NSArray *arrayOfDics=[GGJsonHelper JsonStringArrayToArray:[self getContentString]];
    NSMutableArray *ret=[[NSMutableArray alloc] initWithCapacity:arrayOfDics.count];
    for(NSDictionary *jsonDic in arrayOfDics){
        NSString *jsonString=[GGJsonHelper JsonDicToString:jsonDic];
        [ret addObject:[targetClass fromJsonString:jsonString]];
    }
    return ret;
}

@end
