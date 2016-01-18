//
//  GGCommitItem.h
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GGRest/GGJsoneableObject.h>
#import "GGAuthor.h"


@interface GGCommitItem : NSObject <GGJsoneableObject>
@property(nonatomic) NSString *comment;
@property(nonatomic) GGAuthor *author;

@end
