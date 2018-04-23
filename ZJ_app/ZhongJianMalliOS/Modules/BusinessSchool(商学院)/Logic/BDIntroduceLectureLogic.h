//
//  BDIntroduceLectureLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDIntroduceLectureModel;
@protocol BDIntroduceLectureLogicDelegate <NSObject>
@optional
- (void)requsetIntroduceLectureDataCompletedWithLecture:(BDIntroduceLectureModel *)model;

@end

@interface BDIntroduceLectureLogic : NSObject

@property (nonatomic, weak) id <BDIntroduceLectureLogicDelegate> delegate;

- (void)requsetIntroduceLectureDataWithCourseid:(NSString *)courseid;

@end
