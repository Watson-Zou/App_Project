//
//  UIView+Extension.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@property (nonatomic, readonly) UIViewController *viewController;

@end
