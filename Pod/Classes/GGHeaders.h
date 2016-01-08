

#import <Foundation/Foundation.h>

@interface GGHeaders : NSObject

- (id)initWithInitialKey:(NSString *) key andValue:(NSString*) value;
-(int) count;
-(NSString*) getKeyAtIndex:(int) index;
-(NSString*) getValueAtIndex:(int) index;
-(void) addHeaderWith:(NSString *) key andValue:(NSString *) value;

@end
