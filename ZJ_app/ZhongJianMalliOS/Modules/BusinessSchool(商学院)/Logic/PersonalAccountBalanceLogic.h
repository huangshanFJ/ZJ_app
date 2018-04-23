//
//  PersonalAccountBalanceLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonalAccountBalanceLogicDelegate <NSObject>
@optional
- (void)getPersonalAccountBalanceCompletedWithRemainElecNum:(NSString *)elecNum;
- (void)getPersonalAccountCompletedWithErrorMessage:(NSString *)message;

@end

@interface PersonalAccountBalanceLogic : NSObject

@property (nonatomic, weak) id <PersonalAccountBalanceLogicDelegate> delegate;

- (void)getPersonalAccountBalance;

@end
