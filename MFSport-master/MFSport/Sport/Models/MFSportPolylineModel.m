//
//  MFSportPolylineModel.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/10.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportPolylineModel.h"

@implementation MFSportPolylineModel

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color {
    MFSportPolylineModel *polyline = [MFSportPolylineModel polylineWithCoordinates:coords count:count];
    polyline.color = color;
    return polyline;
}

@end
