//
//  HomeViewController.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"

@interface HomeViewController : BaseViewController

- (instancetype)initWithHomePageViewModel:(HomePageViewModel *)viewmodel;

@end
