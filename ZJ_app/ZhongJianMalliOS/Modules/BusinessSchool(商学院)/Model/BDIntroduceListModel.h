//
//  BDIntroduceListModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroduceList : NSObject

@property (nonatomic, copy) NSString *classday;
@property (nonatomic, copy) NSString *numofclass;
@property (nonatomic, copy) NSString *catalogue;

@end


@interface BDIntroduceListModel : NSObject

@property (nonatomic, strong) NSArray *lists;

@end
