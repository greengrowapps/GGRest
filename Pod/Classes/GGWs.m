//
//  GGWs.m
//  Pods
//
//  Created by piro on 10/1/16.
//
//

#import "GGWs.h"
#import <objc/runtime.h>
#import "CTObjectiveCRuntimeAdditions/CTObjectiveCRuntimeAdditions.h"
#import "CTObjectiveCRuntimeAdditions/CTBlockDescription.h"
#import "GGjsonHelper.h"
#import "GGHttpClientImpl.h"
#import "GGHttpResponse.h"


@interface GGWs() <GGHttpClientWraperDelegate>{
    NSOperationQueue* callbackQueue;
    id<GGHttpClientWraper> httpclient;
    NSMutableDictionary *customResponses;
}

@end

@implementation GGWs

-(instancetype)init{
    self=[super init];
    
    if(self){
        [self config];
        httpclient=[[GGHttpClientImpl alloc] init];
    }
    
    return self;
}

-(instancetype)initWithClient:(id<GGHttpClientWraper>) client{
    self=[super init];
    
    if(self){
        [self config];
        httpclient=client;
    }
    
    return self;
}

-(void) config{
    self.bodyData=nil;
    self.url=nil;
    self.method=-1;
    self.serializationViews=nil;
    customResponses=[[NSMutableDictionary alloc] init];
}


-(void) checkIntegrity{
    
}

-(void) execute{
    
    [self checkIntegrity];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    callbackQueue = [NSOperationQueue currentQueue];
    
    [httpclient doRequestWithUrl:self.url
                          metdod:self.method
                         headers:nil
                            body:[self bodyToData]
                        delegate:self];
    
}
#pragma mark -private methods

-(NSData*) bodyToData{
    if(self.bodyData){
        NSString *postContent=[self.bodyData toJsonStringWithViews:self.serializationViews];
        NSLog(@"Content %@ ", postContent);
        return [postContent dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

-(id<GGJsoneableObject>) objectForBlock:(id) b withResponse:(GGHttpResponse*) response{
    
    NSString *resposeString=[response getContentString];

    
    id<GGJsoneableObject> o;
    NSArray *blokParams=[self blockParamsClassesForBlock:b];

    
    if(blokParams.count<=0){
        return nil;
    }
    
    Class expectedClass =[blokParams objectAtIndex:0];

    
    if([expectedClass isSubclassOfClass:[NSArray class]]){
        if(blokParams.count < 1){
            return nil;
        }
        Class expectedClass2 = [blokParams objectAtIndex:1];
        o=[NSMutableArray fromJsonString:resposeString ofClass:expectedClass2];
    }else if([expectedClass isSubclassOfClass:[GGHttpResponse class]]){
        o=response;
    }else{
        o=[expectedClass fromJsonString:resposeString];
    
    }
    return o;
}

-(NSArray*) blockParamsClassesForBlock:(id) block{
    NSMethodSignature *signature = [[[CTBlockDescription alloc] initWithBlock:block] blockSignature];
    NSLog(@"signature %@", [signature debugDescription]);
    
    
    NSMutableArray *ret=[[NSMutableArray alloc] init];
    
    for(int i=1 ; i< [signature numberOfArguments];i++){
        const char* type=[signature getArgumentTypeAtIndex:i];
        NSString *typeStr=[NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        typeStr=[typeStr substringWithRange:NSMakeRange(2, typeStr.length-3)];
        Class expectedClass = NSClassFromString (typeStr);
        [ret addObject:expectedClass];
    }
    return ret;
    
}


#pragma mark httpClientWraperDelegate

-(void)connectionFinish:(GGHttpResponse*) fullResponse{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    id b = [customResponses objectForKey:[NSNumber numberWithInt:fullResponse.code]];
    
    if(b){
        id<GGJsoneableObject> o = [self objectForBlock:b withResponse:fullResponse];
        [callbackQueue addOperationWithBlock:^(){
            if([o isKindOfClass:[NSArray class]]){
                ((ArrayResponseBlock) b)((NSArray*)o,nil);
            }else{
                ((ObjectResponseBlock)b)(o);
            }
        }];
    }else{
        if(self.onError){
            [callbackQueue addOperationWithBlock:^(){
                self.onError(fullResponse,nil);
            }];
        }
    }
    
    
   }

-(void) connectionError:(GGHttpResponse*) fullResponse
                  error:(NSError*) error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if(self.onError){

        [callbackQueue addOperationWithBlock:^(){
            self.onError(fullResponse,error);
        }];
    }
}
#pragma mark - public methods

-(void)setOnOk:(ObjectResponseBlock)onOk{
    _onOk=onOk;
    [self onResponse:200 objectCallBack:onOk];
}

-(void)setOnOkArray:(ArrayResponseBlock)onOkArray{
    _onOkArray=onOkArray;
    [self onResponse:200 arrayCallBack:onOkArray];
}

-(void) onResponse:(int) code objectCallBack:(ObjectResponseBlock) b{
    [customResponses setObject:b forKey:[NSNumber numberWithInt:code]];
}

-(void) onResponse:(int) code arrayCallBack:(ArrayResponseBlock) b{
    [customResponses setObject:b forKey:[NSNumber numberWithInt:code]];
}




@end
