

#import <Foundation/Foundation.h>
#import "GGJsoneableObject.h"

@interface NSMutableDictionary(GGJson)

-(void) setString:(NSString*)s forKey:(NSString*)key;
-(void) setInt:(int)v forKey:(NSString*)key;
-(void) setFloat:(float)v forKey:(NSString*)key;
-(void) setDate:(NSDate*)d forKey:(NSString*)key;
-(void) setBoolean:(BOOL)v forKey:(NSString*)key;
-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key;
-(void) setJsoneableObject:(id<GGJsoneableObject>) obj forKey:(NSString*) key;
-(void) setObjectArray:(NSArray*) v forKey:(NSString*) key withWiews:(NSArray*)views;
-(void) setJsoneableObject:(id<GGJsoneableObject>) obj forKey:(NSString*) key withWiews:(NSArray*)views;
+(instancetype) create;

@end
