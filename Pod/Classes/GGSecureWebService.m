

#import "GGSecureWebService.h"
#import "GGJsonResponse.h"
#import "GGNoSecurity.h"
#import "GGJsoneableObject.h"
#import "GGJsoneableString.h"
#import "GGHeaders.h"
#import "GGErrorHelper.h"

typedef enum requestTypesValues{
    GET=0,
    POST=1,
    PUT=2,
    DELETE=3,
}GGRequestType;

static GGHeaders *fixedHeaders;

@implementation GGSecureWebService


+(void)addFixedheaders:(GGHeaders *)headers{
    fixedHeaders=headers;
}

#pragma mark -no secure methods

+(GGJsonResponse *) doGet:(NSString *)url
{
    return [self doGet:url headers:Nil];
}

+(GGJsonResponse *)doGet:(NSString *)url headers:(GGHeaders *)headers{
    id<GGSecurityImplementation> sec=[[GGNoSecurity alloc] init];
    return [self doRequest:GET url:url content:nil headers:headers security:sec jsonViews:nil];
}


+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
{
    return [self doPost:url postCosntent:content headers:nil];
}

+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
                 withJsonViews:(NSArray*) views{
    return [self doRequest:POST url:url content:content headers:nil security:[[GGNoSecurity alloc] init] jsonViews:views];
    
}

+(GGJsonResponse *) doPost:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
                   headers:(GGHeaders *)headers{
    
    id<GGSecurityImplementation> sec=[[GGNoSecurity alloc] init];
    return [self doRequest:POST url:url content:content headers:headers security:sec jsonViews:nil];
}

+(GGJsonResponse *) doPut:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
{
    return [self doPut:url postCosntent:content headers:nil];
}

+(GGJsonResponse *) doPut:(NSString *)url
              postCosntent:(id<GGJsoneableObject>)content
                   headers:(GGHeaders *)headers{
    
    id<GGSecurityImplementation> sec=[[GGNoSecurity alloc] init];
    return [self doRequest:PUT url:url content:content headers:headers security:sec jsonViews:nil];
}


#pragma mark -secureMethods

+(GGJsonResponse *) doSecureGet:(NSString *)url
                       security:(id<GGSecurityImplementation>) sec
{
    return [self doSecureGet:url  headers:nil security:sec];
}

+(GGJsonResponse *) doSecureGet:(NSString *)url
                        headers:(GGHeaders *)headers
                       security:(id<GGSecurityImplementation>) sec
{
    return [self doRequest:GET url:url content:nil headers:headers security:sec jsonViews:nil];
    
}

+(GGJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<GGJsoneableObject>)content
                        security:(id<GGSecurityImplementation>) sec
{
    return [self doSecurePost:url postCosntent:content headers:nil security:sec];
}

+(GGJsonResponse *) doSecurePost:(NSString *)url
                    postCosntent:(id<GGJsoneableObject>)content
                         headers:(GGHeaders *)headers
                        security:(id<GGSecurityImplementation>) sec
{
    return [self doRequest:POST url:url content:content headers:headers security:sec jsonViews:nil];
}


+(GGJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<GGJsoneableObject>)content
                       security:(id<GGSecurityImplementation>) sec {
    return [self doSecurePut:url postCosntent:content headers:nil security:sec];
}

+(GGJsonResponse *) doSecurePut:(NSString *)url
                   postCosntent:(id<GGJsoneableObject>)content
                        headers:(GGHeaders *) headers
                       security:(id<GGSecurityImplementation>) sec {
    return [self doRequest:PUT url:url content:content headers:headers security:sec jsonViews:nil];
}



+(GGJsonResponse *) doRequest:(GGRequestType)type
                          url:(NSString *)urlString
                      content:(id<GGJsoneableObject>) postContent
                      headers:(GGHeaders *)extraHeaders
                     security:(id<GGSecurityImplementation>) sec
                    jsonViews:(NSArray*)views

{
    NSURL *url = [NSURL URLWithString:urlString];

    NSError *error = nil;
    [GGErrorHelper networkErrorsForHost:[url host]
                                  error:&error];
    
    if (error)
    {
        return [[GGJsonResponse alloc] initWithResponseCode:-1
                                                 andError:error];
    }
    
    
    NSLog(@"Request %d url:%@",type , urlString);

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    if(type == GET){
        [request setHTTPMethod:@"GET"];
    }else{
        if (type == PUT) {
            [request setHTTPMethod:@"PUT"];
        }
        else {
            [request setHTTPMethod:@"POST"];
        }
        NSString *processedCOntent=[sec processPostContent:[postContent toJsonStringWithViews:views]];
        [self addBodyData:processedCOntent toRequest:request];
    }
    [request setValue:[sec getSignature:url] forHTTPHeaderField:@"SIGNATURE"];
    [sec addExtraHeaders:request];
    
    if(fixedHeaders){
        for (int i =0 ; i< [fixedHeaders count]; i++) {
            [request setValue:[fixedHeaders getValueAtIndex:i]  forHTTPHeaderField:[fixedHeaders getKeyAtIndex:i]];
        }
    }
    if(extraHeaders){
        for (int i =0 ; i< [extraHeaders count]; i++) {
            [request setValue:[extraHeaders getValueAtIndex:i]  forHTTPHeaderField:[extraHeaders getKeyAtIndex:i]];
        }
    }
    
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
   
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSHTTPURLResponse *resp=nil;
    NSError *err;
    
    NSData *responseData= [NSURLConnection sendSynchronousRequest:request
                                                returningResponse:&resp
                                                            error:&err];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData
                                                     encoding:NSUTF8StringEncoding];
    
    NSString *responseString2 = [[NSString alloc] initWithData:responseData
                                                     encoding:NSWindowsCP1252StringEncoding];
    
   // responseString=responseString2;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    int statusCode;
    statusCode=resp.statusCode;
    NSLog(@"Response code: %d",statusCode );
    if(!resp){
        NSLog(@"TE TENGO!!");
        //ESTO ES UNA GRAN CAGADA DE APPLE
        if (err && err.code == -1012) {
            statusCode = 401;
            NSLog(@"Forced response 401");
        }
    }
    NSLog(@"Response content utf8: %@",responseString );
    NSLog(@"Response content windows: %@",responseString );


    NSDictionary* headers=resp.allHeaderFields;
    NSString *signature=[headers objectForKey:@"SIGNATURE"];
    NSString *signatureLen=[headers objectForKey:@"SL"];

    
    return [sec processResponse:statusCode
                        content:responseString
                      signature:signature
            signatureLen:signatureLen];    
}


+(void) addBodyData:(NSString*) postContent toRequest:(NSMutableURLRequest*) request{
     NSLog(@"Content %@ ", postContent);
    NSData * bodyData=[postContent dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
}


@end
