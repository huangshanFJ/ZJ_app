//
//  ZJPaymentPswLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VerfyPaymentPswStatus) {
    VerfyPaymentPswUnkwon = 0,
    VerfyPaymentPswCorrect,
    VerfyPaymentPswError,
    VerfyPaymentPswNoSet,
};

@protocol VerifyPaymentPswDelegate <NSObject>
@optional
- (void)verfyPaymentPswCompleted:(VerfyPaymentPswStatus)status;
- (void)verfyPaymentPswCompleted:(VerfyPaymentPswStatus)status orderNoc:(NSString *)orderNoc;

@end

@interface ZJPaymentPswLogic : NSObject

@property (nonatomic, weak) id <VerifyPaymentPswDelegate> delegate;

- (void)verifyPaymentPassWord:(NSString *)psw;

@end
