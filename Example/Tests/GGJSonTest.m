//
//  GGJSonTest.m
//  GGRest
//
//  Created by piro on 13/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GGRest/GGJsonHelper.h>
#import "GGTestObject.h"


@interface GGJSonTest : XCTestCase{
    NSString *objectJson;
}
@end

@implementation GGJSonTest

- (void)setUp {
    [super setUp];
    NSString *filePath=[[NSBundle bundleForClass:[self class]] pathForResource:@"TestObject" ofType:@"json"];
    objectJson=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testSingleObjectSerialization{
    GGTestObject *o= [GGTestObject fromJsonString:objectJson];
    [self validateObject:o];

}
-(void) validateObject:(GGTestObject *) obj{
    XCTAssertNotNil(obj);
    XCTAssertEqual(obj.intField, 12);
    XCTAssertEqualWithAccuracy(obj.floatField, 12.4, 0.01);
    XCTAssertEqualObjects(obj.stringField, @"hello");
}

-(void) testArraySerialization{
    NSString *json=[NSString stringWithFormat:@"[%@,%@,%@,%@,%@]",objectJson,objectJson,objectJson,objectJson,objectJson];
    NSArray *a= [NSMutableArray fromJsonString:json ofClass:[GGTestObject class]];
    for(GGTestObject *o in a){
        [self validateObject:o];
    }
    
}



@end
