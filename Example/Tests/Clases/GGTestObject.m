//
//  GGTestObject.m
//  GGRest
//
//  Created by piro on 11/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGTestObject.h"
#import <GGRest/GGJsonHelper.h>

#define jskIntValue @"intValue"
#define jskFloatValue @"floatValue"
#define jskStringValue @"stringValue"
#define jskDateValue @"dateValue"
#define jskDateTimeValue @"dateTimeValue"
#define jskDateFromTimestampValue @"dateFromTimestampValue"
#define jskBooleanValue @"booleanValue"
#define jskchild @"child"
#define jskchildArray @"childArray"




@implementation GGTestObject


-(NSMutableDictionary *)toJsonDicWithViews:(NSArray *)views{
    NSMutableDictionary *ret=[super toJsonDicWithViews:views];
    
    [ret setInt:self.intField forKey:jskIntValue];
    [ret setFloat:self.floatField forKey:jskFloatValue];
    [ret setString:self.stringField forKey:jskStringValue];
    [ret setDate:self.dateField forKey:jskDateValue];
    [ret setDate:self.dateTimeField forKey:jskDateTimeValue];
    [ret setDateInTimestampFormat:self.dateFromTimestampField forKey:jskDateFromTimestampValue];
    [ret setBoolean:self.booleanField forKey:jskBooleanValue];
    [ret setJsoneableObject:self.child forKey:jskchild withWiews:views];
    [ret setObjectArray:self.childArray forKey:jskchildArray withWiews:views];
    return ret;
}
-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self = [super init];
    if(self){
        self.intField=[json getIntForKey:jskIntValue];
        self.floatField=[json getFloatForKey:jskFloatValue];
        self.stringField=[json getStringForKey:jskStringValue];
        self.dateField=[json getDateForKey:jskDateValue];
        self.dateTimeField=[json getDateForKey:jskDateTimeValue];
        self.dateFromTimestampField=[json getDateForKey:jskDateFromTimestampValue];
        self.booleanField=[json getBooleanForKey:jskBooleanValue];
        self.child=[json getObjectForKey:jskchild ofType:[GGTestObject class]];
        self.childArray=[json getObjectArrayForKey:jskchildArray ofType:[GGTestObject class]];
    }
    return self;
}

@end
