//
//  RefreshView.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/28.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView


@property(assign,nonatomic)BOOL refresh;

- (void)redrawFromProgress:(CGFloat)progress;

@end
