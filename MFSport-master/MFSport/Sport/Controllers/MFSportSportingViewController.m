//
//  MFSportSportingViewController.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportSportingViewController.h"
#import "MFSportMapViewController.h"
#import <Masonry.h>
#import "MFSportTrackingModel.h"
#import "MFSportGPSButton.h"
#import "MFSportSportingDateShowView.h"
#import "MFSportSportingControlView.h"
#import "UIColor+CZAddition.h"
#import "MFSportSpeaker.h"

@interface MFSportSportingViewController () <MFSportSportingControlViewDelegate, MFSportMapViewControllerDelegate>
/**
 地图控制器
 */
@property(nonatomic, strong) MFSportMapViewController *mapViewController;

@end

@implementation MFSportSportingViewController {
    /// 展现地图的按钮
    UIButton *_mapBtn;
    /// 展现 GPS 信号的按钮
    MFSportGPSButton *_GPSButton;
    /// 数据展示视图
    MFSportSportingDateShowView *_dataShowView;
    /// 控制视图
    MFSportSportingControlView *_controlView;
    /// 播报对象
    MFSportSpeaker *_speaker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    _speaker = [MFSportSpeaker new];
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 设置罗盘位置
    CGFloat compassOriginX = _mapBtn.center.x - _mapViewController.mapView.compassSize.width * 0.5;
    CGFloat compassOriginY = _mapBtn.center.y - _mapViewController.mapView.compassSize.height * 0.5;
    _mapViewController.mapView.compassOrigin = CGPointMake(compassOriginX, compassOriginY);
}

#pragma mark - MFSportSportingControlViewDelegate
- (void)sportSportingControlView:(MFSportSportingControlView *)controlView controlButton:(UIButton *)btn {
    MFSportState state = btn.tag;
    [_speaker sportStateChanged:state];
    _mapViewController.trackingModel.sportState = state;
    [self changeControlViewLayout:state];
}

- (void)changeControlViewLayout:(MFSportState)state {
    CGFloat offsetX = (state == MFSportStatePause) ? -80 : 0;
    CGFloat alpha = (state == MFSportStatePause) ? 0 : 1;
    [_controlView.pauseButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_controlView).offset(offsetX);
    }];
    [_controlView.continueButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_controlView).offset(offsetX);
    }];
    [_controlView.stopButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_controlView).offset(-offsetX);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [_controlView layoutIfNeeded];
        _controlView.pauseButton.alpha = alpha;
    }];
}

#pragma mark - MFSportMapViewControllerDelegate
- (void)sportMapViewController:(MFSportMapViewController *)mapVc sportState:(MFSportState)state {
    MFSportTrackingModel *model = mapVc.trackingModel;
    _dataShowView.showDistanceLabel.text = [NSString stringWithFormat:@"%.02f", model.totalDistance];
    _dataShowView.showTimeLable.text = model.totalTimeStr;
    _dataShowView.showAvgSpeedLabel.text = [NSString stringWithFormat:@"%.02f", model.avgSpeed];
    
    CGFloat btnAlpha = _controlView.pauseButton.alpha;
    if (state == MFSportStateContinue && btnAlpha == 0) {
        [self changeControlViewLayout:state];
        [_speaker sportStateChanged:state];
    } else if (state == MFSportStatePause && btnAlpha == 1) {
        [self changeControlViewLayout:state];
        [_speaker sportStateChanged:state];
    }
    
    [_speaker reportWithDistance:model.totalDistance time:model.totalTime speed:model.avgSpeed];
}

#pragma mark - 监听方法
- (void)showMapBtnClick {
    [self presentViewController:_mapViewController animated:YES completion:nil];
}

#pragma mark - 搭建界面
- (void)setupUI {
    [self setupMapViewController];
    [self setupShowMapBtn];
    [self setupGPSButton];
    [self setupDataShowView];
    [self setupControlView];
    [self setupBackgroundLayer];
}

- (void)setupBackgroundLayer {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    CGColorRef color1 = [UIColor cz_colorWithHex:0x0e1428].CGColor;
    CGColorRef color2 = [UIColor cz_colorWithHex:0x406479].CGColor;
    CGColorRef color3 = [UIColor cz_colorWithHex:0x406578].CGColor;
    layer.colors = @[(__bridge UIColor *)color1, (__bridge UIColor *)color2, (__bridge UIColor *)color3];
    layer.locations = @[@0, @0.6, @1];
    
    [self.view.layer insertSublayer:layer atIndex:0];
}

- (void)setupControlView {
    MFSportSportingControlView *controlView = [[MFSportSportingControlView alloc] init];
    [self.view addSubview:controlView];
    controlView.delegate = self;
    
    [controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_dataShowView.mas_bottom);
    }];
    
    _controlView = controlView;
}

- (void)setupDataShowView {
    MFSportSportingDateShowView *dataShowView = [[MFSportSportingDateShowView alloc] init];
    [self.view insertSubview:dataShowView atIndex:0];
    
    [dataShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.6);
    }];
    
    _dataShowView = dataShowView;
}

- (void)setupGPSButton {
    MFSportGPSButton *GPSButton = [[MFSportGPSButton alloc] initWithImageName:@"ic_sport_gps_connect_1"];
    [self.view addSubview:GPSButton];
    GPSButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    GPSButton.isMapButton = NO;
    
    [GPSButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.equalTo(_mapBtn);
    }];
    
    _GPSButton = GPSButton;
}

- (void)setupShowMapBtn {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"ic_sport_map"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMapBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _mapBtn = btn;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.offset(23);
        make.right.offset(-11);
    }];
}

- (void)setupMapViewController {
    MFSportMapViewController *mapVC = [[MFSportMapViewController alloc] init];
    mapVC.trackingModel = [[MFSportTrackingModel alloc] initWithSportType:_sportType sportState:MFSportStateContinue];
    mapVC.delegate = self;
    [_speaker startSportType:_sportType];
    _mapViewController = mapVC;
}
@end
