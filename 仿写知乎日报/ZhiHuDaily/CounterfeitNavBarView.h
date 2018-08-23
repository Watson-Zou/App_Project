//
//  CounterfeitNavBarView.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/28.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^leftBtnTapBlock)(void);

@interface CounterfeitNavBarView : UIView

@property (strong,nonatomic)UIView *backgroundView;
@property (strong,nonatomic)UILabel *titleLab;
@property (strong,nonatomic)UIButton *leftBtn;
@property (strong,nonatomic)leftBtnTapBlock leftBtnTapAction;

@end
