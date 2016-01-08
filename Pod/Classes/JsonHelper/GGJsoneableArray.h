

#import <Foundation/Foundation.h>
#import "GGJsoneableObject.h"


@interface NSMutableArray(GGJsoneableObject) <GGJsoneableObject>
-(NSArray*) toJsonArrayWithViews:(NSArray*)views;
+(id) fromJsonString:(NSString *) json ofClass:(Class) claz;
+(id) fromJsonArray:(NSArray *) jsonA ofClass:(Class) claz;

@end
