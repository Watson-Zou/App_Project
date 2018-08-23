//
//  MFSportSportingControlView.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/15.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportSportingControlView.h"
#import <Masonry.h>

@implementation MFSportSportingControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 监听事件
- (void)controlButtonClick:(UIButton *)sender {
    [_delegate sportSportingControlView:self controlButton:sender];
}

#pragma mark - 搭建界面
- (void)setupUI {
    UIButton *stopButton = [self makeButtonWithImageName:@"ic_sport_finish" isControlButton:YES];
    stopButton.backgroundColor = [UIColor colorWithRed:187/255.0 green:99/255.0 blue:75/255.0 alpha:1];
    stopButton.tag = 202;
    UIButton *continueButton = [self makeButtonWithImageName:@"ic_sport_continue" isControlButton:YES];
    continueButton.backgroundColor = [UIColor colorWithRed:46/255.0 green:228/255.0 blue:76/255.0 alpha:1];
    continueButton.tag = 201;
    UIButton *pauseButton = [self makeButtonWithImageName:@"ic_sport_pause" isControlButton:YES];
    pauseButton.backgroundColor = [UIColor colorWithRed:46/255.0 green:228/255.0 blue:76/255.0 alpha:1];
    pauseButton.tag = 200;
    
    UIButton *cameraButton = [self makeButtonWithImageName:@"ic_sport_camera" isControlButton:NO];
    UIButton *lockButton = [self makeButtonWithImageName:@"ic_sport_lock_1" isControlButton:NO];
    UIButton *settingButton = [self makeButtonWithImageName:@"ic_sport_settings" isControlButton:NO];
    
    [stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.8);
    }];
    
    [continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.8);
    }];
    
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.8);
    }];
    
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.bottom.equalTo(self).offset(-12);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cameraButton);
        make.centerX.equalTo(self);
        make.size.equalTo(cameraButton);
    }];
    
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.centerY.equalTo(lockButton);
        make.size.equalTo(cameraButton);
    }];
    
    _stopButton = stopButton;
    _continueButton = continueButton;
    _pauseButton = pauseButton;
}

- (UIButton *)makeButtonWithImageName:(NSString *)imageName isControlButton:(BOOL)isControlButton {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn sizeToFit];
    if (isControlButton) {
        btn.layer.cornerRadius = 50;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(controlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:btn];
    return btn;
}

@end
