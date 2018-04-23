//
//  CheckNumber.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CheckNumber.h"

@implementation CheckNumber

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber

{
    
    NSString*pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    
    return isMatch;
    
}
#pragma 正则匹配用户密码6-18位数字和字母组合

+ (BOOL)checkPassword:(NSString*) password

{
    
    NSString*pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}
@end
