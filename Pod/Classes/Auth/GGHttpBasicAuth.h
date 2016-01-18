//
//  GGHttpBasicAuth.h
//  Pods
//
//  Created by piro on 18/1/16.
//
//

#import "GGAuthentication.h"

@interface GGHttpBasicAuth : GGAuthentication

- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
