//
//  GGHttpClientWraper.h
//  Pods
//
//  Created by piro on 10/1/16.
//
//

#import <Foundation/Foundation.h>
#import "GGHeaders.h"
#import "GGHttpResponse.h"



typedef NS_ENUM(NSInteger, GGRequestType)
{
    GET=0,
    POST=1,
    PUT=2,
    DELETE=3,
};
@protocol GGJsoneableObject;

@protocol GGHttpClientWraperDelegate <NSObject>

@required

-(void)connectionFinish:(GGHttpResponse*) fullResponse;
-(void) connectionError:(GGHttpResponse*) fullResponse error:(NSError*) error;

@end

@protocol GGHttpClientWraper <NSObject>


@required
-(void) doRequestWithUrl:(NSString*) url
                  metdod:(GGRequestType) method
                 headers:(GGHeaders*) h
                    body:(NSData*)body
                delegate:(id<GGHttpClientWraperDelegate>) delegate;
@end