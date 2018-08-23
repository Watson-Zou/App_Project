//
//  MFSportMapViewController.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSportTrackingModel.h"
#import <MAMapKit/MAMapKit.h>

@class MFSportMapViewController;
@protocol MFSportMapViewControllerDelegate <NSObject>

- (void)sportMapViewController:(MFSportMapViewController *)mapVc sportState:(MFSportState)state;

@end

@interface MFSportMapViewController : UIViewController

/**
 运动轨迹模型
 */
@property (nonatomic, strong) MFSportTrackingModel *trackingModel;
/**
 地图视图
 */
@property (nonatomic, weak, readonly) MAMapView *mapView;
@property(nonatomic, weak) id<MFSportMapViewControllerDelegate> delegate;
@end
