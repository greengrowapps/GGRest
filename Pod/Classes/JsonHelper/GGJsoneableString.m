

#import "GGJsoneableString.h"

@implementation NSString (GGJsoneableObject)

-(NSString *) toJsonStringWithViews:(NSArray *)views{
    if(self.length == 0){
        return @"";
    }
    return [NSString stringWithFormat:@"\"%@\"",self];
}

+(id) fromJsonString:(NSString *) json{
    NSRange range =NSMakeRange(1, json.length-2);
    NSString *ret=[[NSString alloc] initWithString:[json substringWithRange:range]];
    return ret;
}



@end
