//
//  Foundation+Log.m
//  YiQiWanPai
//
//  Created by 王文丙 on 2017/9/4.
//  Copyright © 2017年 jbenjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [str appendFormat:@"\t%@ = %@,\n", key ,obj];
    }];
    
    [str appendString:@"}"];
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [str appendFormat:@"%@,\n",obj];
    }];
    
    [str appendString:@"]"];
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.length != 0) {
        
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end
