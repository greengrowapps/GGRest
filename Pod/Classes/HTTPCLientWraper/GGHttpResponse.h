//
//  GGHttpResponse.h
//  Pods
//
//  Created by piro on 11/1/16.
//
//

#import <Foundation/Foundation.h>

@class GGHeaders;
@interface GGHttpResponse : NSObject

@property(nonatomic,readonly) int code;
@property(nonatomic,readonly) GGHeaders *headers;
@property(nonatomic,readonly) NSData *data;

- (instancetype)initWithCode:(int) code
                        data:(NSData*) data
                     headers:(GGHeaders*) h;


-(NSString*) getContentString;
-(id) getObject:(Class)targetClass;
-(NSArray *) getObjectsArray:(Class)targetClass;


@end
