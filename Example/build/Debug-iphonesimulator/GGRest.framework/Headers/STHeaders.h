//
//  STHeaders.h
//  ParanoidSecurity
//
//  Created by AdriLocal on 4/10/14.
//  Copyright (c) 2014 SMARD transactions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STHeaders : NSObject

- (id)initWithInitialKey:(NSString *) key andValue:(NSString*) value;
-(int) count;
-(NSString*) getKeyAtIndex:(int) index;
-(NSString*) getValueAtIndex:(int) index;
-(void) addHeaderWith:(NSString *) key andValue:(NSString *) value;

@end
