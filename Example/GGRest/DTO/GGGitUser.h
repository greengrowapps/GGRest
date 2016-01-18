//
//  GGGitUser.h
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GGRest/GGJsoneableObject.h>

@interface GGGitUser : NSObject <GGJsoneableObject>
@property(nonatomic) NSString* username;

@end
