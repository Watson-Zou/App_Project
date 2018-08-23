//
//  MFSportPolylineModel.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/10.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MFSportPolylineModel : MAPolyline

/**
 线条颜色
 */
@property(nonatomic, strong) UIColor *color;

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;

@end
