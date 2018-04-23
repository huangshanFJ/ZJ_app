//
//  CDIntroductionMainLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDIntroductionMainModel;
@protocol CDIntroductionMainLogicDelegate <NSObject>
@optional
- (void)requestIntroductionMainDataCompleted:(BDIntroductionMainModel *)model;

@end

@interface CDIntroductionMainLogic : NSObject

@property (nonatomic, weak) id <CDIntroductionMainLogicDelegate> delegate;

- (void)requestIntroductionMainDataWithCourseid:(NSString *)couresid;

@end
