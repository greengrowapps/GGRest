

#import "GGHeaders.h"

@interface GGHeaders ()
@property (nonatomic , strong) NSMutableArray *keys;
@property (nonatomic , strong) NSMutableArray *values;
@end

@implementation GGHeaders

-(id) initWitNSHTTPURLResponseHeaders:(NSDictionary*) headers{
    self=[super init];
    if(self){
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.keys=[[NSMutableArray alloc] init];
        self.values=[[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithInitialKey:(NSString *) key andValue:(NSString*) value
{
    self = [super init];
    if (self) {
        self.keys=[[NSMutableArray alloc] initWithObjects:key, nil];
        self.values=[[NSMutableArray alloc] initWithObjects:value, nil];
    }
    return self;
}

-(int) count{
    return [self.keys count];
}
-(NSString*) getKeyAtIndex:(int) index{
    return [self.keys objectAtIndex:index];
}
-(NSString*) getValueAtIndex:(int) index{
    return [self.values objectAtIndex:index];
}
-(void) addHeaderWith:(NSString *) key andValue:(NSString *) value{
    [self.keys addObject:key];
    [self.values addObject:value];
}



@end
