//
//  MFSportSpeaker.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/16.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFSportTrackingModel.h"

@interface MFSportSpeaker : NSObject

/**
 播报运动类型

 @param type 运动类型
 */
- (void)startSportType:(MFSportType)type;

/**
 播报运动状态

 @param state 运动状态
 */
- (void)sportStateChanged:(MFSportState)state;

/**
 整距离播报 距离 时间 速度

 @param distance 距离
 @param time 时间
 @param avgSpeed 速度
 */
- (void)reportWithDistance:(double)distance time:(NSTimeInterval)time speed:(double)avgSpeed;

@end
