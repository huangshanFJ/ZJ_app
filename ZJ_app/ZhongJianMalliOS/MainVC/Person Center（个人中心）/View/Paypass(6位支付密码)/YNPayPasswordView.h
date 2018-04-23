//
//  YNPayPasswordView.h
//  O2O
//
//  Created by Abel on 16/11/9.
//  Copyright © 2016年 yunshanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNPayPasswordView;

@protocol YNPayPasswordViewDelegate <NSObject>

@optional
-(void)YNPayPasswordView:(YNPayPasswordView *)view WithPasswordString:(NSString *)Password;

-(void)YNPayPasswordView:(YNPayPasswordView *)view WithPasswordString:(NSString *)Password WithButtonIndex:(NSInteger)buttonIndex;


@end


@interface YNPayPasswordView : UIView <UITextFieldDelegate>

@property (nonatomic,weak)id <YNPayPasswordViewDelegate> payPasswordDelegate;



//带按钮
- (id)initWithFrame:(CGRect)frame
          WithTitle:(NSString *)title
       WithSubTitle:(NSString *)subTitle
         WithButton:(NSArray *)bttonArray;
//不带按钮
- (id)initWithFrame:(CGRect)frame
          WithTitle:(NSString *)title
       WithSubTitle:(NSString *)subTitle;

- (void)hiddenAllPoint;

- (void)removeFromView;

///标题
@property (nonatomic,strong)UILabel *lable_title;
///二级标题
@property (nonatomic,strong)UILabel *lable_subTitle;
///  TF
@property (nonatomic,strong)UITextField *TF;

///  假的输入框
@property (nonatomic,strong)UIView *view_box;
@property (nonatomic,strong)UIView *view_box2;
@property (nonatomic,strong)UIView *view_box3;
@property (nonatomic,strong)UIView *view_box4;
@property (nonatomic,strong)UIView *view_box5;
@property (nonatomic,strong)UIView *view_box6;

///   密码点
@property (nonatomic,strong)UILabel *lable_point;
@property (nonatomic,strong)UILabel *lable_point2;
@property (nonatomic,strong)UILabel *lable_point3;
@property (nonatomic,strong)UILabel *lable_point4;
@property (nonatomic,strong)UILabel *lable_point5;
@property (nonatomic,strong)UILabel *lable_point6;
@end
