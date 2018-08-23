//
//  CounterfeitNavBarView.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/28.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "CounterfeitNavBarView.h"

@implementation CounterfeitNavBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(56.f);
                make.top.left.right.equalTo(self);
            }];
            
            view;
        });
        
        _titleLab = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(10.f);
            }];
            label;
        });
        
        _leftBtn = ({
            UIButton *btn = [UIButton new];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self).offset(10.f);
                make.left.mas_equalTo(self.left).offset(16.f);
                make.size.mas_equalTo(CGSizeMake(19.f, 19.f));
            }];
            [btn addTarget:self action:@selector(tapLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return self;
}



- (void)tapLeftBtn:(id)sender {
    if (_leftBtnTapAction) {
        _leftBtnTapAction();
    }
}


@end
