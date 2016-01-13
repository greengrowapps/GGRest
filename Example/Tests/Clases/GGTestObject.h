//
//  GGTestObject.h
//  GGRest
//
//  Created by piro on 11/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GGRest/GGJsoneableObject.h>


@interface GGTestObject : NSObject <GGJsoneableObject>
@property(nonatomic) int intField;
@property(nonatomic) float floatField;
@property(nonatomic) NSString* stringField;

@end
