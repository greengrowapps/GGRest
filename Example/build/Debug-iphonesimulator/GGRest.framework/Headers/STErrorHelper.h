//
//  STErrorHelper.h
//  SMARDCore
//
//  Created by AdriLocal on 10/30/13.
//  Copyright (c) 2013 SMARD Transactions GmbH & Co. KG. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    STCoreErrorNoNetwork    = 10000,
    STCoreErrorServer       = 10001,
    STCoreErrorRegistration = 10002,
    STCoreErrorNoContent    = 10003,
    STCoreErrorAlreadyResyncked    = 10004
} STCoreError;

@interface STErrorHelper : NSObject

+ (void)networkErrorsForHost:(NSString *)host error:(NSError **)error;

@end
