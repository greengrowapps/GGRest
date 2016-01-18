

#import "GGSha1.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonDigest.h>


@implementation GGSha1

+(NSString *) caluclate:(NSString *) toHash{

    NSData *data = [toHash dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSData *result=[NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    
    return [result base64EncodedString];
}

@end
