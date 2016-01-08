

#import "GGJsonResponse.h"
#import "GGJsoneableObject.h"
#import "GGJsonHelper.h"

@implementation GGJsonResponse

- (id)initWithResponseCode:(int) code andContent:(NSString *) content
{
    self = [super init];
    if (self) {
        _content=content;
        _responseCode=code;
    }
    return self;
}

- (id)initWithResponseCode:(int) code andError:(NSError *)error
{
    self = [super init];
    if (self) {
        _error=error;
        _responseCode=code;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"CODE: %d CONTENT:%@",self.responseCode , self.content];
}

-(id) getObject:(Class)targetClass{
   return [targetClass fromJsonString:self.content];
    
}
-(NSArray *) getObjectsArray:(Class)targetClass{
    NSArray *arrayOfDics=[GGJsonHelper JsonStringArrayToArray:self.content];
    NSMutableArray *ret=[[NSMutableArray alloc] initWithCapacity:arrayOfDics.count];
    for(NSDictionary *jsonDic in arrayOfDics){
        NSString *jsonString=[GGJsonHelper JsonDicToString:jsonDic];
        [ret addObject:[targetClass fromJsonString:jsonString]];
    }
    return ret;
}





@end
