
#import <Foundation/Foundation.h>
#import "GGSecurityImplementation.h"
#import "GGJsoneableObject.h"
#import "GGJsoneableString.h"
#import "GGJsoneableArray.h"
#import "GGJsonResponse.h"

@class GGHeaders;
@interface GGSecureWebService : NSObject

+(void) addFixedheaders:(GGHeaders *)fixedHeaders;

+(GGJsonResponse *) doGet:(NSString *)url;



+(GGJsonResponse *) doGet:(NSString *)url
                  headers:(GGHeaders*) headers;


+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content;

+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
                 withJsonViews:(NSArray*) views;

+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
                   headers:(GGHeaders *) headers;

+(GGJsonResponse *) doPut:(NSString *)url
             postCosntent:(id<GGJsoneableObject>)content;

+(GGJsonResponse *) doPut:(NSString *)url
             postCosntent:(id<GGJsoneableObject>)content
                  headers:(GGHeaders *)headers;

+(GGJsonResponse *) doSecureGet:(NSString *)url
                       security:(id<GGSecurityImplementation>) sec;

+(GGJsonResponse *) doSecureGet:(NSString *)url
                        headers:(GGHeaders *) headers
                       security:(id<GGSecurityImplementation>) sec;



+(GGJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<GGJsoneableObject>)content
                        security:(id<GGSecurityImplementation>) sec;

+(GGJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<GGJsoneableObject>)content
                         headers:(GGHeaders *) headers
                        security:(id<GGSecurityImplementation>) sec;

+(GGJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<GGJsoneableObject>)content
                       security:(id<GGSecurityImplementation>) sec;

+(GGJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<GGJsoneableObject>)content
                        headers:(GGHeaders *) headers
                       security:(id<GGSecurityImplementation>) sec;



@end
