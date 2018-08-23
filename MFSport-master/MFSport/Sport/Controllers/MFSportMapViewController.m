//
//  MFSportMapViewController.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportMapViewController.h"
#import "MFSportTrackingLineModel.h"
#import "MFSportPolylineModel.h"
#import "MFCircleAnimator.h"
#import <Masonry.h>
#import "MFSportMapEffectView.h"
#import "MFSportPopoverViewController.h"
#import "MFSportGPSButton.h"

@interface MFSportMapViewController () <MAMapViewDelegate, UIPopoverPresentationControllerDelegate>

@end

@implementation MFSportMapViewController {
    MFCircleAnimator *_circleAnimator;
    BOOL _isSetStartLocation;
    /// 模糊视图
    MFSportMapEffectView *_effectView;
    /// 关闭按钮
    UIButton *_closeBtn;
    /// 展现 GPS 信号的按钮
    MFSportGPSButton *_gpsButton;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        _circleAnimator = [[MFCircleAnimator alloc] init];
        self.transitioningDelegate = _circleAnimator;
        [self setupUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 监听事件
- (void)closeMapView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - popover
- (void)popover:(UIButton *)sender {
    MFSportPopoverViewController *vc = [[MFSportPopoverViewController alloc] initWithSourceView:sender];
    vc.popoverPresentationController.delegate = self;
    vc.popoverPresentationController.passthroughViews = @[_closeBtn];
    [self presentViewController:vc animated:YES completion:nil];
    
    [vc setDidSelectedMapMode:^(MAMapType type) {
        self.mapView.mapType = type;
    }];
    
    vc.currentType = self.mapView.mapType;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - 代理方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (!updatingLocation) {
        return;
    }
    
    if (!_isSetStartLocation && _trackingModel.sportStartLocation != nil) {
        _isSetStartLocation = YES;
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = _trackingModel.sportStartLocation.coordinate;
        [mapView addAnnotation:annotation];
    }
    
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
    [mapView addOverlay:[_trackingModel appendLocation:userLocation.location]];
    // 利用block进行反向传值
    [_delegate sportMapViewController:self sportState:_trackingModel.sportState];
    [self updateUIDisplay];
}

- (void)updateUIDisplay {
    _effectView.timeDigitLabel.text = _trackingModel.totalTimeStr;
    _effectView.distanceDigitLabel.text = [NSString stringWithFormat:@"%.02f", _trackingModel.totalDistance];
}

// 自定义大头针图片
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if (![annotation isKindOfClass:[MAPointAnnotation class]]) {
        return nil;
    }
    static NSString *annotaionId = @"annotaionId";
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotaionId];
    if (annotationView == nil) {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotaionId];
    }
    annotationView.image = _trackingModel.sportImage;
    annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height * 0.5);
    return annotationView;
}

// 设置折现的属性
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if (![overlay isKindOfClass:[MAPolyline class]]) {
        return nil;
    }
    MFSportPolylineModel *polyline = (MFSportPolylineModel *)overlay;
    MAPolylineRenderer *plr = [[MAPolylineRenderer alloc] initWithOverlay:polyline];
    plr.lineWidth = 5;
    plr.strokeColor = polyline.color;
    return plr;
}


#pragma mark - 搭建界面
- (void)setupUI {
    [self setupMapView];
    [self setupEffectView];
    [self setupButton];
}

- (void)setupMapView {
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:mapView atIndex:0];
    mapView.rotateCameraEnabled = NO;
    mapView.showsScale = NO;
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    mapView.allowsBackgroundLocationUpdates = YES;
    mapView.pausesLocationUpdatesAutomatically = NO;
    mapView.delegate = self;
    _mapView = mapView;
}

- (void)setupEffectView {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    MFSportMapEffectView *effectView = [[MFSportMapEffectView alloc] initWithEffect:effect];
    [self.view addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
    
    _effectView = effectView;
}

- (void)setupButton {
    // 关闭按钮
    UIButton *closeBtn = [self makeBtnWithImageName:@"ic_sport_gps_map_close"];
    [closeBtn addTarget:self action:@selector(closeMapView) forControlEvents:UIControlEventTouchUpInside];
    // 地图模式按钮
    UIButton *modeBtn = [self makeBtnWithImageName:@"ic_sport_gps_map_mode"];
    [modeBtn addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    // GPS信号展示按钮
    MFSportGPSButton *gpsButton = [[MFSportGPSButton alloc] initWithImageName:@"ic_sport_gps_map_connect_1"];
    [self.view addSubview:gpsButton];
    [gpsButton setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
    gpsButton.isMapButton = YES;
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(_effectView.mas_top).offset(-22);
    }];
    [modeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.centerY.equalTo(closeBtn);
    }];
    [gpsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(27);
    }];
    
    _closeBtn = closeBtn;
    _gpsButton = gpsButton;
}

- (UIButton *)makeBtnWithImageName:(NSString *)imageName {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    return btn;
}

@end
