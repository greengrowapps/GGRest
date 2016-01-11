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


@interface GGWs() <GGHttpClientWraperDelegate>{
    NSOperationQueue* callbackQueue;
    id<GGHttpClientWraper> httpclient;
}

@end

@implementation GGWs

-(instancetype)init{
    self=[super init];
    
    if(self){
        self.bodyData=nil;
        self.url=nil;
        self.method=-1;
        self.serializationViews=nil;
        httpclient=[[GGHttpClientImpl alloc] init];
    }
    
    return self;
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

-(NSString*) dataToString:(NSData*) data{
    
    if(!data || data.length == 0){
        return nil;
    }
    
   NSString *ret=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if(!ret){
        ret=[[NSString alloc] initWithData:data encoding:NSWindowsCP1252StringEncoding];
    }
    
    return ret;
}

#pragma mark httpClientWraperDelegate

-(void)connectionFinish:(int) responseCode
                   data:(NSData*) responseData
                headers:(NSDictionary*) headers{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    id<GGJsoneableObject> o;
    
    NSMethodSignature *signature = [[[CTBlockDescription alloc] initWithBlock:self.onOk] blockSignature];
    NSLog(@"signature %@", [signature debugDescription]);
    
    
    const char* type=[signature getArgumentTypeAtIndex:1];
    NSString *typeStr=[NSString stringWithCString:type encoding:NSUTF8StringEncoding];
    typeStr=[typeStr substringWithRange:NSMakeRange(2, typeStr.length-3)];
    Class expectedClass = NSClassFromString (typeStr);
    
    NSString *resposeString=[self dataToString:responseData];
    
    if(resposeString){
        o=[expectedClass fromJsonString:resposeString];
    }

    if(responseCode==200){
        [callbackQueue addOperationWithBlock:^(){
            self.onOk(o);
        }];
    }else{
        if(self.onError){
            [callbackQueue addOperationWithBlock:^(){
                self.onError(responseCode,resposeString,nil);
            }];
        }
    }
}

-(void) connectionError:(int) responseCode
                   data:(NSData*) responseData
                headers:(NSDictionary*) headers
                  error:(NSError*) error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if(self.onError){
        NSString *content=[self dataToString:responseData];

        [callbackQueue addOperationWithBlock:^(){
            self.onError(responseCode,content,error);
        }];
    }
}



@end
