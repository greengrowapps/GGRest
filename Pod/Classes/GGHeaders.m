

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

-(void) addValue:(NSString *)value forKey:(NSString*) key{
    NSMutableArray *values=[self getValuesForKey:key];
    [values addObject:value];
}

-(void) addValues:(NSArray *)values forKey:(NSString*) key{
    for(NSString *v in values){
        [self addValue:v forKey:key];
    }
}
-(void) printHeadersInRequest:(NSMutableURLRequest*)r{
    [r setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    for(NSString *key in self.headers){
        NSArray *values = [self getValuesForKey:key];
        
        if(values.count == 1){
            [r setValue:values[0] forHTTPHeaderField:key];
        }
        
    }
    
}

-(NSMutableArray *) getValuesForKey:(NSString*) key{
   NSMutableArray *values= [self.headers objectForKey:key];
    if(!values){
        values=[[NSMutableArray alloc] init];
        [self.headers setObject:values forKey:key];
    }
    
    return values;
}





@end
