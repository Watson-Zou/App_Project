//
//  MFSportTrackingModel.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSportTrackingLineModel.h"

// 通知名
extern NSString *const MFSportGPSSignalChangedNotifictaion;

typedef enum: NSInteger {
    MFSportTypeWalk,
    MFSportTypeRun,
    MFSportTypeBike
}MFSportType;

typedef enum: NSInteger {
    MFSportStatePause = 200,
    MFSportStateContinue,
    MFSportStateEnd
}MFSportState;
// GPS信号枚举
typedef enum: NSInteger {
    MFSportGPSSignalStateDisconnect,
    MFSportGPSSignalStateBad,
    MFSportGPSSignalStateNormal,
    MFSportGPSSignalStateGood
}MFSportGPSSignalState;

@interface MFSportTrackingModel : NSObject

/**
 运动类型
 */
@property (nonatomic, assign, readonly) MFSportType sportType;
/**
 和运动类型对应的图片
 */
@property (nonatomic, assign, readonly) UIImage *sportImage;
/**
 平均速度
 */
@property (nonatomic, readonly) double avgSpeed;
/**
 总的时间
 */
@property (nonatomic, readonly) double totalTime;
/**
 总的时间的字符串
 */
@property (nonatomic, readonly) NSString *totalTimeStr;
/**
 最大速度
 */
@property (nonatomic, readonly) double maxSpeed;
/**
 总距离, 单位为 公里
 */
@property (nonatomic, readonly) double totalDistance;

/**
 运动状态
 */
@property (nonatomic, assign) MFSportState sportState;

/**
 运动开始位置
 */
@property (nonatomic, readonly) CLLocation *sportStartLocation;

- (instancetype)initWithSportType:(MFSportType)type sportState:(MFSportState)sportState;

/**
 绘制折现

 @param location 用户的位置
 @return 折现模型
 */
- (MFSportPolylineModel *)appendLocation:(CLLocation *)location;

@end
