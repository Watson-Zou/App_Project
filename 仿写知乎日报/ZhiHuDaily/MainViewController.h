//
//  MainViewController.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : BaseViewController

- (instancetype)initWithLeftMenuViewController:(UIViewController *)leftMenuVC andHomeViewController:(UIViewController *) homeVC;

- (void)showHomeView;
- (void)showMenuView;

@end
