//
//  GGBase64.m
//  Pods
//
//  Created by piro on 18/1/16.
//
//

#import "GGBase64.h"
#import "NSData+Base64.h"


@implementation GGBase64

+(NSString*) encode:(NSString*) toEncode{
    NSData *data=[toEncode dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedString];
}


@end
