//
//  GGWs.h
//  Pods
//
//  Created by piro on 10/1/16.
//
//

#import <Foundation/Foundation.h>
#import "GGJsoneableObject.h"
#import "GGHttpClientWraper.h"



@interface GGWs : NSObject

typedef void (^ObjectResponseBlock)(id<GGJsoneableObject> o);
typedef void (^ErrorBlock)(int code , NSString *content ,NSError *error);


@property(nonatomic) GGRequestType method;
@property(nonatomic) NSString* url;
@property(nonatomic) id<GGJsoneableObject> bodyData;
@property(nonatomic) NSArray *serializationViews;

@property(readwrite, copy) ObjectResponseBlock onOk;
@property(readwrite, copy) ErrorBlock onError;


-(void) execute;

@end
