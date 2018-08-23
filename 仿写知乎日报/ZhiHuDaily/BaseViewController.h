//
//  BaseViewController.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPresentAnimationController.h"
#import "ZHDismissAnimationController.h"
#import "PanInteractionController.h"

@interface BaseViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property (strong,nonatomic)PanInteractionController *interaction;

@end
