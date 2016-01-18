

#import <Foundation/Foundation.h>

@interface GGHeaders : NSObject

-(id) initWitNSHTTPURLResponseHeaders:(NSDictionary*) headers;
- (id)initWithInitialKey:(NSString *) key andValue:(NSString*) value;
-(void) addValue:(NSString *)value forKey:(NSString*) key;
-(void) addValues:(NSArray *)values forKey:(NSString*) key;
-(void) printHeadersInRequest:(NSMutableURLRequest*)r;



@end
