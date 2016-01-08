

#import <Foundation/Foundation.h>
@protocol GGJsoneableObject <NSObject>

-(NSString*) toJsonStringWithViews:(NSArray*)views;

@required
- (instancetype)initWithJsonDic:(NSDictionary*) json;
-(NSMutableDictionary *) toJsonDicWithViews:(NSArray*)views;


@end