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
#include <GGRest/GGSecureWebService.h>
#include <GGRest/GGJsonHelper.h>



SpecBegin(Cell)
describe(@"Cell", ^{
    it(@"is dead on creation", ^{
        waitUntil(^(DoneCallback done) {
            GGWs *ws=[[GGWs alloc] init];
            ws.url=@"Https://google.es";
            ws.method=GET;
            ws.onOk=^(NSString *s){
                NSLog(@"String is %@",s);
                 done();
            };
            ws.onError=^(int code , NSString *content , NSError *error){
                expect(1).to.equal(2);
                done();
            };
            [ws execute];
        });
        
        

    });
});
SpecEnd