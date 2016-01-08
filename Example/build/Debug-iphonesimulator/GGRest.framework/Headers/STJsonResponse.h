//
//  STJsonResponse.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 2/6/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>


@class STWsException;
@interface STJsonResponse : NSObject
@property (nonatomic , readonly) int responseCode;
@property (nonatomic , readonly) NSString * content;
@property (nonatomic, readonly) NSError *error;

- (id)initWithResponseCode:(int) code andContent:(NSString *) content;
- (id)initWithResponseCode:(int)code andError:(NSError *)error;
-(id) getObject:(Class)targetClass;
-(NSArray *) getObjectsArray:(Class)targetClass;

@end
