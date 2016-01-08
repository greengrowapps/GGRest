//
//  STSecureWebService.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 2/6/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STSecurityImplementation.h"
#import "STJsoneableObject.h"
#import "STJsoneableString.h"
#import "STJsoneableArray.h"
@class STJsonResponse;
@class STHeaders;
@interface GGSecureWebService : NSObject

+(void) addFixedheaders:(STHeaders *)fixedHeaders;

+(STJsonResponse *) doGet:(NSString *)url;



+(STJsonResponse *) doGet:(NSString *)url
                  headers:(STHeaders*) headers;


+(STJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<STJsoneableObject>)content;

+(STJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<STJsoneableObject>)content
                 withJsonViews:(NSArray*) views;

+(STJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<STJsoneableObject>)content
                   headers:(STHeaders *) headers;

+(STJsonResponse *) doPut:(NSString *)url
             postCosntent:(id<STJsoneableObject>)content;

+(STJsonResponse *) doPut:(NSString *)url
             postCosntent:(id<STJsoneableObject>)content
                  headers:(STHeaders *)headers;

+(STJsonResponse *) doSecureGet:(NSString *)url
                       security:(id<STSecurityImplementation>) sec;

+(STJsonResponse *) doSecureGet:(NSString *)url
                        headers:(STHeaders *) headers
                       security:(id<STSecurityImplementation>) sec;



+(STJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<STJsoneableObject>)content
                        security:(id<STSecurityImplementation>) sec;

+(STJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<STJsoneableObject>)content
                         headers:(STHeaders *) headers
                        security:(id<STSecurityImplementation>) sec;

+(STJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<STJsoneableObject>)content
                       security:(id<STSecurityImplementation>) sec;

+(STJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<STJsoneableObject>)content
                        headers:(STHeaders *) headers
                       security:(id<STSecurityImplementation>) sec;



@end
