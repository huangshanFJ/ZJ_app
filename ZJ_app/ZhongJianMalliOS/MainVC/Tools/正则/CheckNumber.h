//
//  CheckNumber.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNumber : NSObject

/**  正则匹配手机号  */
+ (BOOL)checkTelNumber:(nonnull NSString* )telNumber;
/**  正则匹配6-20位数字和字母组合密码  */
+ (BOOL)checkPassword:(nonnull NSString*) password;

@end
