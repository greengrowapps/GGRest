//
//  GGDateConverter.m
//  Pods
//
//  Created by piro on 18/1/16.
//
//

#import "GGDateConverter.h"

@interface GGDateConverter(){
    
}
@property(nonatomic) NSString *formatString;
@property(nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation GGDateConverter

- (instancetype)initWithFormat:(NSString *) formatString
{
    self = [super init];
    if (self) {
        self.formatString=formatString;
    }
    return self;
}


-(NSDate *) fromString:(NSString *)strDate{
    return [[self formatter] dateFromString:strDate];
}

-(NSString *) toString:(NSDate *) date{
    return [[self formatter] stringFromDate:date];
}

-(NSDateFormatter *) formatter{
    
    if(!self.dateFormatter){
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = self.formatString;
    }
    
    return self.dateFormatter;
}

@end
