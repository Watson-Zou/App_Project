//
//  MFSportTrackingModel.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportTrackingModel.h"
#import "MFSportTrackingLineModel.h"

NSString *const MFSportGPSSignalChangedNotifictaion = @"MFSportGPSSignalChangedNotifictaion";

@implementation MFSportTrackingModel {
    CLLocation *_startLocation;
    // 保存折线
    NSMutableArray<MFSportTrackingLineModel *> *_trackingLines;
    // GPS 之前定位的点
    CLLocation *_gpsPreLocation;
}

- (instancetype)initWithSportType:(MFSportType)type sportState:(MFSportState)sportState {
    if (self = [super init]) {
        _sportType = type;
        self.sportState = sportState;
        _trackingLines = [NSMutableArray new];
    }
    return self;
}

- (UIImage *)sportImage {
    UIImage *image;
    switch (_sportType) {
        case MFSportTypeWalk:
            image = [UIImage imageNamed:@"map_annotation_walk"];
            break;
        case MFSportTypeRun:
            image = [UIImage imageNamed:@"map_annotation_run"];
            break;
        case MFSportTypeBike:
            image = [UIImage imageNamed:@"map_annotation_bike"];
            break;
    }
    return image;
}

- (MFSportGPSSignalState)gpsSignalWithLocation:(CLLocation *)location {
    MFSportGPSSignalState state = MFSportGPSSignalStateBad;
    
    if (location.speed < 0) {
        [self postNotification:state];
        return state;
    }
    if (_gpsPreLocation == nil) {
        _gpsPreLocation = location;
        [self postNotification:state];
        return state;
    }
    NSTimeInterval delta = ABS([location.timestamp timeIntervalSinceDate:_gpsPreLocation.timestamp]);
    delta = ABS(delta - 1);
    if (delta < 0.1) {
        state = MFSportGPSSignalStateGood;
    } else if (delta < 1) {
        state = MFSportGPSSignalStateNormal;
    }
    [self postNotification:state];
    _gpsPreLocation = location;
    return state;
}
// 发送通知
- (void)postNotification:(MFSportGPSSignalState)state {
    [[NSNotificationCenter defaultCenter] postNotificationName:MFSportGPSSignalChangedNotifictaion object:@(state)];
}

- (void)checkSportStateChange:(CLLocation *)location {
    if (self.sportStartLocation == nil) {
        return;
    }
    if (location.speed < 0.1 && _sportState == MFSportStateContinue) {
        _sportState = MFSportStatePause;
    }
    if (location.speed >= 0.1 && _sportState == MFSportStatePause) {
        _sportState = MFSportStateContinue;
    }
}

- (MFSportPolylineModel *)appendLocation:(CLLocation *)location {
    // 判断 GPS 信号强度
    if ([self gpsSignalWithLocation:location] < MFSportGPSSignalStateNormal) {
        return nil;
    }
    // 判断用户是不是第一次定位
    if (_startLocation == nil) {
        _startLocation = location;
        return nil;
    }
    [self checkSportStateChange:location];
    
    if (_sportState != MFSportStateContinue) {
        return nil;
    }
    
    MFSportTrackingLineModel *trackingLine = [[MFSportTrackingLineModel alloc] initWithStartLocation:_startLocation endLocation:location];
    _startLocation = location;
    
    [_trackingLines addObject:trackingLine];
    
    return trackingLine.polyline;
}

- (double)avgSpeed {
    return [[_trackingLines valueForKeyPath:@"@avg.speed"] doubleValue];
}

- (double)maxSpeed {
    return [[_trackingLines valueForKeyPath:@"@max.speed"] doubleValue];
}

- (double)totalDistance {
    return  [[_trackingLines valueForKeyPath:@"@sum.distance"] doubleValue] / 1000;
}

- (double)totalTime {
    double time = [[_trackingLines valueForKeyPath:@"@sum.time"] doubleValue];
    return time;
}

- (NSString *)totalTimeStr {
    NSInteger time = (NSInteger)self.totalTime;
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd", time / 3600, (time % 3600 ) / 60, time % 60];
}

- (void)setSportState:(MFSportState)sportState {
    _sportState = sportState;
    if (sportState != MFSportStateContinue) {
        _startLocation = nil;
    }
}

- (CLLocation *)sportStartLocation {
    return  _trackingLines.firstObject.startLocation;
}

@end
