//
//  UIColor+DjyRGB.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DjyRGB)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
