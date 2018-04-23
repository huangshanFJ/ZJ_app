//
//  ZJServices.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZJ_SVC_SUCC_BLOCK)(id _Nullable responseObject);
typedef void(^ZJ_SVC_ERR_BLOCK)(NSError *_Nullable error);

@interface ZJServices : NSObject

/*
+ (void)verifyPassWord:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock;

+ (void)syncHandleOrderC:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock;

 */
@end
