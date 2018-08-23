//
//  MFSportTrackingLineModel.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/10.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "MFSportPolylineModel.h"

@interface MFSportTrackingLineModel : NSObject

/**
 起始点
 */
@property (nonatomic, readonly) CLLocation *startLocation;
/**
 结束点
 */
@property (nonatomic, readonly) CLLocation *endLocation;
/**
 折线模型
 */
@property (nonatomic, readonly) MFSportPolylineModel *polyline;
/**
 速度，单位是 km/h
 */
@property (nonatomic, readonly) double speed;
/**
 起点和终点的时间差值
 */
@property (nonatomic, readonly) NSTimeInterval time;
/**
 起点和终点的距离
 */
@property (nonatomic, readonly) double distance;

- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation;

@end
