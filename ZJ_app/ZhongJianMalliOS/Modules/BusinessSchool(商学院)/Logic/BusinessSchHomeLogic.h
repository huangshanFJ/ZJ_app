//
//  BusinessSchHomeLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessSchHomeLogicDelegate <NSObject>
@optional
- (void)requestBusinessSchHomepageDataCompletedSegment:(NSArray *)segments picture:(NSString *)picurl;

@end

@interface BusinessSchHomeLogic : NSObject

@property (nonatomic, weak) id <BusinessSchHomeLogicDelegate> delegate;

- (void)requestBusinessSchHomepageData;

@end
