//
//  MFSportPopoverViewController.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/14.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface MFSportPopoverViewController : UIViewController

/**
 当前展示的地图类型
 */
@property(nonatomic, assign) MAMapType currentType;

/**
 选中的地图类型
 */
@property(nonatomic, copy) void (^didSelectedMapMode)(MAMapType);

- (instancetype)initWithSourceView:(UIView *)sourceView;

@end
