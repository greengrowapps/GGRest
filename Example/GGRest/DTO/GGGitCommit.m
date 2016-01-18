//
//  GGCommit.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGGitCommit.h"
#import <GGRest/GGJsonHelper.h>

#define jskSha @"sha"
#define jskCommiter @"committer"
#define jskCommitItem @"commit"


@implementation GGGitCommit

-(instancetype)initWithJsonDic:(NSDictionary *)json{
    self=[super init];

    if(self){
        self.sha = [json getStringForKey:jskSha];
        self.commiter = [json getObjectForKey:jskCommiter ofType:[GGGitUser class]];
        self.commitItem = [json getObjectForKey:jskCommitItem ofType:[GGCommitItem class]];

        
    }
    
    return self;
}


@end
