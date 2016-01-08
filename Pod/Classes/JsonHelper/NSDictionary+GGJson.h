

#import <Foundation/Foundation.h>

@interface NSDictionary(GGJson)
-(NSString *) getStringForKey:(NSString *) key;
-(int) getIntForKey:(NSString *) key;
-(NSNumber*) getNumberForKey:(NSString *) key;
-(float) getFloatForKey:(NSString*)key;
-(NSDate*) getDateForKey:(NSString*) key;
-(BOOL) getBooleanForKey:(NSString*) key;
-(id) getObjectForKey:(NSString *) key ofType:(Class) claz;
-(NSMutableArray*) getObjectArrayForKey:(NSString *) key ofType:(Class) claz;
@end
