//
//  NSDictionary+logUTF8.m
//  MaShaQi
//
//  Created by zhaoqiqi on 16/12/27.
//  Copyright © 2016年 PXY. All rights reserved.
//

#import "NSDictionary+logUTF8.h"

@implementation NSDictionary (logUTF8)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *string = [NSMutableString stringWithCapacity:self.count];
    
    [string appendString:@"{\n"];
    
    for (id key in self) {
        
        NSString *value=[self objectForKey:key];
        
        [string appendFormat:@"\t%@ = \"%@\";\n",key,value];
    }
    [string appendString:@"}"];
    
    return string;
}
- (NSDictionary *)deleteAllNullValue{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
@end
