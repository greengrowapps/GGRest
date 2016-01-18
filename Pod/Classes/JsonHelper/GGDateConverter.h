//
//  GGDateConverter.h
//  Pods
//
//  Created by piro on 18/1/16.
//
//

#import <Foundation/Foundation.h>

@interface GGDateConverter : NSObject

- (NSDate *) fromString:(NSString *)strDate;
- (NSString *) toString:(NSDate *) date;
- (instancetype)initWithFormat:(NSString *) formatString;

@end
