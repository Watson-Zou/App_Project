//
//  MFSportTrackingLineModel.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/10.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportTrackingLineModel.h"

@implementation MFSportTrackingLineModel

- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation {
    if (self = [super init]) {
        _startLocation = startLocation;
        _endLocation = endLocation;
    }
    return self;
}

- (MFSportPolylineModel *)polyline {
    CLLocationCoordinate2D coords[2];
    coords[0] = _startLocation.coordinate;
    coords[1] = _endLocation.coordinate;
    CGFloat factor = 8;
    CGFloat red = self.speed * factor / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:1-red blue:0 alpha:1];
    MFSportPolylineModel *polyline = [MFSportPolylineModel polylineWithCoordinates:coords count:2 color:color];
    return polyline;
}

- (double)speed {
    return (_startLocation.speed + _endLocation.speed) * 0.5 * 3.6;
}

- (NSTimeInterval)time {
    return [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

- (double)distance {
    return [_endLocation distanceFromLocation:_startLocation];
}

@end
