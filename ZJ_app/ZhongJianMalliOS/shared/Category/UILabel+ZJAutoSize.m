//
//  UILabel+ZJAutoSize.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UILabel+ZJAutoSize.h"

@implementation UILabel (ZJAutoSize)

- (NSString *)changeTextWithFontSize:(CGFloat)fontSize OfLabel:(UILabel *)label ToColor:(UIColor *)color withLocation:(NSInteger)location andLength:(NSInteger)length {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text];
    //改变label某一部分字体颜色
    [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, length)];
    //改变label某一个部分文字大小
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(location, length)];
    self.attributedText = string;
    return (NSString *)string;
}

- (CGSize)sizeForTextFont:(UIFont *)font {
    return [self.text length] > 0 ? [self.text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
}

- (CGSize)sizeForTextFontMaxSize:(CGSize)size font:(UIFont *)font {
    return [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
