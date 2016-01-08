

#import <Foundation/Foundation.h>


@interface GGJsonResponse : NSObject
@property (nonatomic , readonly) int responseCode;
@property (nonatomic , readonly) NSString * content;
@property (nonatomic, readonly) NSError *error;

- (id)initWithResponseCode:(int) code andContent:(NSString *) content;
- (id)initWithResponseCode:(int)code andError:(NSError *)error;
-(id) getObject:(Class)targetClass;
-(NSArray *) getObjectsArray:(Class)targetClass;

@end
