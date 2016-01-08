

#import <Foundation/Foundation.h>
@class GGJsonResponse;
@protocol GGSecurityImplementation <NSObject>


@required
-(NSString *) processPostContent:(NSString *) postContent;
-(NSString *) getSignature:(NSURL *) url;
-(void) addExtraHeaders:(NSMutableURLRequest *)request;

-(GGJsonResponse *)processResponse:(int)responseCode
                           content:(NSString *)responsecontent
                         signature:(NSString *)responseSignature
                      signatureLen:(NSString*)signatureLen;

@end
