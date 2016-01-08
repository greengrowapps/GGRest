

#import "GGNoSecurity.h"
#import "GGJsonResponse.h"

@implementation GGNoSecurity


-(NSString *)processPostContent:(NSString *)postContent{
    return postContent;
}

-(NSString *)getSignature:(NSURL *)url{
    return @"";
}

-(GGJsonResponse *)processResponse:(int)responseCode content:(NSString *)responsecontent signature:(NSString *)responseSignature signatureLen:(NSString *)signatureLen{
    return [[GGJsonResponse alloc] initWithResponseCode:responseCode andContent:responsecontent];
}

-(void)addExtraHeaders:(NSMutableURLRequest *)request{
}

@end
