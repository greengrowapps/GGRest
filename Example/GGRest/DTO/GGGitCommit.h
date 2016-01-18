//
//  GGCommit.h
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GGRest/GGJsoneableObject.h>
#import "GGGitUser.h"
#import "GGCommitItem.h"
@interface GGGitCommit : NSObject <GGJsoneableObject>
@property(nonatomic) NSString *sha;
@property(nonatomic) GGGitUser *commiter;
@property(nonatomic) GGCommitItem *commitItem;


@end
