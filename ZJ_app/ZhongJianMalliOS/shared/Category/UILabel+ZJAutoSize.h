//
//  UILabel+ZJAutoSize.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZJAutoSize)

- (NSString *)changeTextWithFontSize:(CGFloat)fontSize OfLabel:(UILabel *)label ToColor:(UIColor *)color withLocation:(NSInteger)location andLength:(NSInteger)length;

- (CGSize)sizeForTextFont:(UIFont *)font;

- (CGSize)sizeForTextFontMaxSize:(CGSize)size font:(UIFont *)font;

@end
