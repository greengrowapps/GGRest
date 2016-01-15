//
//  GGWsTest.m
//  GGRest
//
//  Created by piro on 10/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#include <GGRest/GGWs.h>
#include <GGRest/GGJsonHelper.h>
#include <GGRest/GGMockedClient.h>
#include "GGTestObject.h"
#include <GGRest/GGHttpResponse.h>




#define okUrl @"Http://ok.com"
#define arrayUrl @"Http://array.com"
#define url501 @"Http://Url501.com"


SpecBegin(GGWS)

GGMockedClient *client=[[GGMockedClient alloc] initWithDelayTime:0];
[client addResponeCode:501 andContent:@"\"string\"" forUrl:url501];
[client addResponeCode:200 andContent:@"\"string\"" forUrl:okUrl];
[client addResponeCode:200 andContent:@"[{},{},{}]" forUrl:arrayUrl];

describe(@"Response codes", ^{
    it(@"ok response detected with onOk", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=okUrl;
            ws.method=GET;
                ws.onOk=^(NSString *s){
                    expect(s).to.equal(@"string");
                done();
            };
            [ws execute];
        });
    });
    
    it(@"ok response detected with on 200", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=okUrl;
            ws.method=GET;
            [ws onResponse:200 objectCallBack:^(NSString *s){
                expect(s).to.equal(@"string");
                done();
            }];
            [ws execute];
        });
    });
    
    it(@"error response detected", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=@"incorrect url";
            ws.method=GET;
            ws.onError=^(GGHttpResponse *fullResponse ,NSError *error){
                done();
            };
            [ws execute];
        });
    });
    
    it(@"501 detected", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=url501;
            ws.method=GET;
            [ws onResponse:501 objectCallBack:^(NSString *s){
                expect(s).to.equal(@"string");
                done();
            }];
            [ws execute];
        });
    });
    
    it(@"ok response detected with onOkArray", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=arrayUrl;
            ws.method=GET;
            ws.onOkArray=^(NSArray *array,GGTestObject *nill){
                expect(array.count).to.equal(3);
                done();
            };
            [ws execute];
        });
    });
    
    it(@"ok response detected with on 200 array", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=arrayUrl;
            ws.method=GET;
            [ws onResponse:200 arrayCallBack:^(NSArray *array,GGTestObject *nill){
                expect(array.count).to.equal(3);
                done();
            }];
            [ws execute];
        });
    });
    
    it(@"ok full response ", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=okUrl;
            ws.method=GET;
            [ws onResponse:200 objectCallBack:^(GGHttpResponse *fullResponse){
                expect(fullResponse.code).to.equal(200);
                expect([fullResponse getContentString]).to.equal(@"\"string\"");
                done();
            }];
            [ws execute];
        });
    });
    
    it(@"ok response detected with onOk", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=okUrl;
            ws.method=GET;
            ws.onOk=^(NSString *s){
                GGHttpResponse *fullResponse= ws.response;
                expect(fullResponse).toNot.beNil();
                done();
            };
            [ws execute];
        });
    });
    
    it(@"real request", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] init];
            ws.url=@"https://google.es";
            ws.method=GET;
            [ws onResponse:200 objectCallBack:^(GGHttpResponse *fullResponse){
                expect(fullResponse.code).to.equal(200);
                done();
            }];
            [ws execute];
        });
    });
});

describe(@"serializations", ^(){
    it(@"Serialize array", ^(){
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] initWithClient:client];
            ws.url=arrayUrl;
            ws.method=GET;
            [ws onResponse:200 arrayCallBack:^(NSArray *array,GGTestObject *nill){
                for(GGTestObject *obj in array){
                    NSLog(@"object: %@",obj);
                }
                done();
            }];
            [ws execute];
        });
    });
});

describe(@"threading", ^(){
    it(@"execute and wait", ^(){
        __block BOOL succes=false;
        GGWs *ws=[[GGWs alloc] initWithClient:client];
        ws.url=okUrl;
        ws.method=GET;
        ws.onOk=^(GGHttpResponse *res){
            succes=true;
        };
        ws.onError=^(GGHttpResponse *res, NSError *error){
            succes=true;
        };
        
        [ws executeAndWait];
        expect(succes).to.equal(true);
    });
});

SpecEnd