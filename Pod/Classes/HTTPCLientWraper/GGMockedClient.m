//
//  GGMockedClient.m
//  Pods
//
//  Created by piro on 11/1/16.
//
//

#import "GGMockedClient.h"

@interface GGMockedClient(){
    int delayTime;
    NSMutableDictionary *codesForUrl;
    NSMutableDictionary *contentForUrl;
}

@end

@implementation GGMockedClient

- (instancetype)initWithDelayTime:(int) ms
{
    self = [super init];
    if (self) {
        delayTime=ms;
        codesForUrl=[[NSMutableDictionary alloc] init];
        contentForUrl=[[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) addResponeCode:(int) code andContent:(NSString*)content forUrl:(NSString*) url{
    
    [codesForUrl setObject:[NSNumber numberWithInt:code] forKey:url];
    [contentForUrl setObject:content forKey:url];
}


-(void)doRequestWithUrl:(NSString *)url
                 metdod:(GGRequestType)method
                headers:(GGHeaders *)h
                   body:(NSData *)body
               delegate:(id<GGHttpClientWraperDelegate>)delegate{
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSNumber *code=[codesForUrl objectForKey:url];
        NSString *content=[contentForUrl objectForKey:url];
        GGHttpResponse *fullResponse =
        [[GGHttpResponse alloc] initWithCode:code.intValue
                                        data:[content dataUsingEncoding:NSUTF8StringEncoding]
                                     headers:nil];
        
        sleep(delayTime);
        
        
        if(!code){
            [delegate connectionError:fullResponse error:nil];
        }else{
            [delegate connectionFinish:fullResponse];
        }
        
    });
    
}
@end
