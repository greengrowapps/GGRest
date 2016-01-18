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
#import "GGAuthentication.h"


@interface GGWs() <GGHttpClientWraperDelegate>{
    NSOperationQueue* callbackQueue;
    id<GGHttpClientWraper> httpclient;
    NSMutableDictionary *customResponses;
    dispatch_semaphore_t latch;
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
    self.headers=nil;
    self.authentication=nil;
    customResponses=[[NSMutableDictionary alloc] init];
}


-(void) checkIntegrity{
    if(!self.headers){
        self.headers=[[GGHeaders alloc] init];
    }
    
}

-(void) execute{
    
    [self checkIntegrity];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    callbackQueue = [NSOperationQueue currentQueue];
    
    
    [self.authentication processHeaders:self.headers];
    
    [httpclient doRequestWithUrl:self.url
                          metdod:self.method
                         headers:self.headers
                            body:[self bodyToData]
                        delegate:self];
    
}

-(void) executeAndWait{
    latch=dispatch_semaphore_create(0);
    
    NSOperationQueue *q=[[NSOperationQueue alloc] init];
    
    [q addOperationWithBlock:^(){
        [self execute];
    }];
    
    long result= dispatch_semaphore_wait(latch, DISPATCH_TIME_FOREVER);
    latch=nil;
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
   ///// NSLog(@"signature %@", [signature debugDescription]);
    
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

-(void) runOnCallbackQueue:(id) block withBlock:(void (^)()) blockToExecute{
    
    if (block) {
        NSOperation *op=[NSBlockOperation blockOperationWithBlock:blockToExecute];
        [callbackQueue addOperations:[NSArray arrayWithObject:op] waitUntilFinished:true];
    }
    
    if(latch){
        dispatch_semaphore_signal(latch);
    }
}


#pragma mark httpClientWraperDelegate

-(void)connectionFinish:(GGHttpResponse*) fullResponse{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    _response=fullResponse;
    id b = [customResponses objectForKey:[NSNumber numberWithInt:fullResponse.code]];
    
    if(b){
        id<GGJsoneableObject> o = [self objectForBlock:b withResponse:fullResponse];
        
        [self runOnCallbackQueue:b withBlock:^(void){
            if([o isKindOfClass:[NSArray class]]){
                ((ArrayResponseBlock) b)((NSArray*)o,nil);
            }else{
                ((ObjectResponseBlock)b)(o);
            }
        }];
        
    }else{
        [self runOnCallbackQueue:self.onError withBlock:^(){
            self.onError(fullResponse,nil);
        }];
    }
    
    
   }

-(void) connectionError:(GGHttpResponse*) fullResponse
                  error:(NSError*) error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    _response=fullResponse;

    [self runOnCallbackQueue:self.onError withBlock:^(){
        self.onError(fullResponse,error);
    }];
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
