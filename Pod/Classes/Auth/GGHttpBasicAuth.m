//
//  GGHttpBasicAuth.m
//  Pods
//
//  Created by piro on 18/1/16.
//
//

#import "GGHttpBasicAuth.h"
#import "GGSha1.h"
#import "GGBase64.h"
#import "GGHeaders.h"

@interface GGHttpBasicAuth(){
    
}
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *password;

@end

@implementation GGHttpBasicAuth
- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.username=username;
        self.password=password;
    }
    return self;
}
-(void)processHeaders:(GGHeaders *)h{
    //NSString *userPass=[NSString stringWithFormat:@"%@:%@",self.username,[GGSha1 caluclate:self.password]];
    NSString *userPass=[NSString stringWithFormat:@"%@:%@",self.username,self.password];

    NSString *basicAuth=[NSString stringWithFormat:@"Basic %@" ,[GGBase64 encode:userPass]];
    [h addValue:basicAuth forKey:@"Authorization"];
    
}

@end
