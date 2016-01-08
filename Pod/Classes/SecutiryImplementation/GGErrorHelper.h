

#import <Foundation/Foundation.h>
typedef enum {
    GGCoreErrorNoNetwork    = 10000,
    GGCoreErrorServer       = 10001,
    GGCoreErrorRegistration = 10002,
    GGCoreErrorNoContent    = 10003,
    GGCoreErrorAlreadyResyncked    = 10004
} GGCoreError;

@interface GGErrorHelper : NSObject

+ (void)networkErrorsForHost:(NSString *)host error:(NSError **)error;

@end
