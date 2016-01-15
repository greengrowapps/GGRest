

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#define kDatetimeFormat @"dd-MM-yyyy HH:mm:ss"
#define kDatetimeUtc @"dd/MM/yyyy"
#define kOnlyDateFormat @"dd-MM-yyyy";

#import "GGJsonHelper.h"

@implementation GGJsonHelper

+(NSString *) JsonDicToString:(NSDictionary *)jsonDic{
    if (jsonDic == nil)
    {
        return nil;
    }
    
    NSError *jsonError = nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:jsonDic
                                                     options:-1
                                                       error:&jsonError];
    
    if(jsonError){
        NSLog(@"jsonError: %@", jsonError.description);
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
}







+(NSDictionary *) JsonStringToDic:(NSString *) jsonString{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&jsonError];
    if(jsonError){
        NSLog(@"jsonError: %@", jsonError.description);
    }
    return jsonDictionary;
}

+(NSArray*) JsonStringArrayToArray:(NSString *) jsonArrayString{
    if (jsonArrayString == nil)
    {
        return nil;
    }
    
    NSData *jsonData=[jsonArrayString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError = nil;
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:kNilOptions
                                                             error:&jsonError];
    if(jsonError){
        NSLog(@"jsonError: %@", jsonError.description);
    }
    return jsonArray;
}









@end
