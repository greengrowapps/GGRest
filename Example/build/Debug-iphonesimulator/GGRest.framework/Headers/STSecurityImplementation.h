//
//  STSecurityImplementation.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 2/6/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class STJsonResponse;
@protocol STSecurityImplementation <NSObject>


@required
-(NSString *) processPostContent:(NSString *) postContent;
-(NSString *) getSignature:(NSURL *) url;
-(void) addExtraHeaders:(NSMutableURLRequest *)request;

-(STJsonResponse *)processResponse:(int)responseCode
                           content:(NSString *)responsecontent
                         signature:(NSString *)responseSignature
                      signatureLen:(NSString*)signatureLen;

@end
