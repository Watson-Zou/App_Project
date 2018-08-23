//
//  ThemeViewController.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/5.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeViewModel.h"

@interface ThemeViewController : BaseViewController

@property (strong,nonatomic)NSString *themeID;

- (instancetype)initWithViewModel:(ThemeViewModel *)viewModel;

@end
