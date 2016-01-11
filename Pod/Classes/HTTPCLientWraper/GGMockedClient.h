//
//  GGMockedClient.h
//  Pods
//
//  Created by piro on 11/1/16.
//
//

#import <Foundation/Foundation.h>
#import "GGHttpClientWraper.h"


@interface GGMockedClient : NSObject <GGHttpClientWraper>
- (instancetype)initWithDelayTime:(int) ms;

-(void) addResponeCode:(int) code andContent:(NSString*)content forUrl:(NSString*) url;

@end
