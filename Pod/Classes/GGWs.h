//
//  GGWs.h
//  Pods
//
//  Created by piro on 10/1/16.
//
//

#import <Foundation/Foundation.h>
#import "GGJsoneableObject.h"
#import "GGHttpClientWraper.h"
#import "GGHeaders.h"
#import "GGHttpBasicAuth.h"
#import "GGHttpResponse.h"



@interface GGWs : NSObject

typedef void (^ObjectResponseBlock)(id<GGJsoneableObject> o);
typedef void (^ArrayResponseBlock)(NSArray *array, id<GGJsoneableObject> o);

typedef void (^ErrorBlock)(GGHttpResponse* fullResponse ,NSError *error);


@property(nonatomic) GGRequestType method;
@property(nonatomic) NSString* url;
@property(nonatomic) id<GGJsoneableObject> bodyData;
@property(nonatomic) NSArray *serializationViews;
@property(nonatomic) GGHeaders *headers;
@property(nonatomic) GGAuthentication *authentication;

@property(nonatomic, copy) ObjectResponseBlock onOk;
@property(nonatomic, copy) ArrayResponseBlock onOkArray;
@property(nonatomic, copy) ErrorBlock onError;

@property(nonatomic,readonly) GGHttpResponse *response;


-(instancetype)initWithClient:(id<GGHttpClientWraper>) client;




-(void) onResponse:(int) code objectCallBack:(ObjectResponseBlock) b;
-(void) onResponse:(int) code arrayCallBack:(ArrayResponseBlock) b;

-(void) execute;
-(void) executeAndWait;


@end
