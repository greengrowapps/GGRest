

#import "GGHeaders.h"

@interface GGHeaders ()
@property (nonatomic , strong) NSMutableDictionary *headers;
@end

@implementation GGHeaders

-(id) init{
    self=[super init];
    if(self){
        self.headers=[[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id) initWitNSHTTPURLResponseHeaders:(NSDictionary*) httpHeaders{
    self=[super init];
    if(self){
        self.headers=[[NSMutableDictionary alloc] init];
        
        for(NSString *key in httpHeaders.allKeys){
            NSString *valuesString=[httpHeaders objectForKey:key];
            NSArray *values=[valuesString componentsSeparatedByString:@"; "];
            NSMutableArray *valuesToadd=[[NSMutableArray alloc] initWithArray:values];
            [self.headers setObject:valuesToadd forKey:key];
        }
        
    }
    return self;
}



- (id)initWithInitialKey:(NSString *) key andValue:(NSString*) value
{
    self = [super init];
    if (self) {
        self.headers=[[NSMutableDictionary alloc] init];
        
        NSMutableArray *values=[[NSMutableArray alloc] initWithObjects:value, nil];
        [self.headers setObject:values forKey:key];

    }
    return self;
}





@end
