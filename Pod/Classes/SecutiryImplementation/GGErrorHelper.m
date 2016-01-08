

#import "GGErrorHelper.h"
#import "GGReachability.h"

@implementation GGErrorHelper

+ (void)networkErrorsForHost:(NSString *)host error:(NSError **)error
{
   
    *error = nil;
    GGReachability *reachability = [GGReachability reachabilityForInternetConnection];
    
    /** No internet
     */
    if ([reachability currentReachabilityStatus] == NotReachable)
    {
        NSLog(@"Sorry, no internet");
        NSDictionary *details = [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"NOINTERNET", @"No internet"), NSLocalizedDescriptionKey, nil];
        *error = [NSError errorWithDomain:@"network"
                                     code:GGCoreErrorNoNetwork
                                 userInfo:details];
    }
    
    /** We got interent
     */
    else
    {
        NSLog(@"We got internet!");
        reachability = [GGReachability reachabilityWithHostName:host];
        
        /** Host not reachable
         */
        if ([reachability currentReachabilityStatus] == NotReachable)
        {
            NSLog(@"Oooooops! %@ is not reachable", host);
            NSDictionary *details = [NSDictionary dictionaryWithObjectsAndKeys:
                                     NSLocalizedString(@"SERVERERROR", @"Server Error"), NSLocalizedDescriptionKey, nil];
            *error = [NSError errorWithDomain:@"network"
                                         code:GGCoreErrorServer
                                     userInfo:details];
        }
    }
}

@end
