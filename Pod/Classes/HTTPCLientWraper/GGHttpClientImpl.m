//
//  GGHttpClientImple.m
//  Pods
//
//  Created by piro on 11/1/16.
//
//

#import "GGHttpClientImpl.h"
#import "GGJsonHelper.h"

@interface GGHttpClientImpl() <NSURLConnectionDelegate>{
    NSMutableData *_responseData;
    NSURLConnection *conn;
    int responseCode;
    NSDictionary *responseHeaders;
    id<GGHttpClientWraperDelegate> delegate;
}

@end

@implementation GGHttpClientImpl


-(void)doRequestWithUrl:(NSString *)url
                 metdod:(GGRequestType)method
                headers:(GGHeaders *)h
                   body:(NSData*) body
               delegate:(id<GGHttpClientWraperDelegate>)mdelegate{
    
    delegate=mdelegate;
    //    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    switch (method) {
        case GET:
            [request setHTTPMethod:@"GET"];
            break;
        case DELETE:
            [request setHTTPMethod:@"DELETE"];
            break;
        case POST:
            [request setHTTPMethod:@"POST"];
            break;
        case PUT:
            [request setHTTPMethod:@"PUT"];
            break;
        default:
            break;
    }
    
    if(body){
        [self addBodyData:body toRequest:request];
    }

    
    
    conn= [[NSURLConnection alloc] initWithRequest:request
                                          delegate:self
                                  startImmediately:NO];
    [conn setDelegateQueue:[[NSOperationQueue alloc] init]];
    [conn start];

    
}

-(void) addBodyData:(NSData*) bodyData toRequest:(NSMutableURLRequest*) request{
   // NSLog(@"Content %@ ", postContent);
   // NSData * bodyData=[postContent dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
}

#pragma mark NSURLConnection Delegate Methods


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    responseCode = [httpResponse statusCode];
    responseHeaders=httpResponse.allHeaderFields;
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [delegate connectionFinish:responseCode
                          data:_responseData
                       headers:responseHeaders];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [delegate connectionError:responseCode
                         data:_responseData
                      headers:responseHeaders
                        error:error];
}


@end
