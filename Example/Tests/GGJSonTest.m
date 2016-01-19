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

-(NSDate*) getDateFromTimestamp:(long long) timestamp{
    return [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
}

-(NSDate*) getDateWithYear:(int) year month:(int) month day:(int) day hour:(int)hour minutes:(int)minutes seconds:(int)seconds{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Combine date and time into components3
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    
    [components3 setYear:year];
    [components3 setMonth:month];
    [components3 setDay:day];
    
    [components3 setHour:hour];
    [components3 setMinute:minutes];
    [components3 setSecond:seconds];
    
    // Generate a new NSDate from components3.
    NSDate *date = [gregorianCalendar dateFromComponents:components3];
    
    return date;
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
    XCTAssertEqual(obj.booleanField, true);

    
    NSDate *fullDate=[self getDateWithYear:1987 month:5 day:7 hour:07 minutes:13 seconds:15];
    XCTAssertEqualObjects(obj.dateTimeField, fullDate);
    
    
    NSDate *dateWithouttime=[self getDateWithYear:1987 month:5 day:7 hour:0 minutes:0 seconds:0];
    XCTAssertEqualObjects(obj.dateField, dateWithouttime);
    
    
    NSDate *fromTimestamp=[self getDateFromTimestamp:547387994000];
    XCTAssertEqualObjects(obj.dateFromTimestampField, fromTimestamp);

    
    [self validateObjectChild:obj.child];
    
    XCTAssertNotNil(obj.childArray);
    XCTAssertEqual(obj.childArray.count, 3);
    
    for(GGTestObject *child in obj.childArray){
        [self validateObjectChild:child];
    }
    
    
}
-(void) validateObjectChild:(GGTestObject *) obj{
    XCTAssertNotNil(obj);
    XCTAssertEqual(obj.intField, 13);
}

-(void) testArraySerialization{
    NSString *json=[NSString stringWithFormat:@"[%@,%@,%@,%@,%@]",objectJson,objectJson,objectJson,objectJson,objectJson];
    NSArray *a= [NSMutableArray fromJsonString:json ofClass:[GGTestObject class]];
    for(GGTestObject *o in a){
        [self validateObject:o];
    }
}

-(void) testDeserialization{
    
    GGTestObject *o= [GGTestObject fromJsonString:objectJson];
    [self validateObject:o];
    NSString *json=[o toJsonStringWithViews:nil];
    
    XCTAssertNotNil(json);
    
    NSData *jsonData=[json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&jsonError];

    XCTAssertNil(jsonError);
    
    
    GGTestObject *second=[GGTestObject fromJsonObject:jsonDictionary];
    
    [self validateObject:second];
    
}



@end
