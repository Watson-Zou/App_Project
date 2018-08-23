//
//  MFSportPopoverViewController.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/14.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportPopoverViewController.h"
#import <Masonry.h>

@interface MFSportPopoverViewController ()

@end

@implementation MFSportPopoverViewController {
    NSMutableArray *_btnArr;
    MAMapType _currentType;
}

- (instancetype)initWithSourceView:(UIView *)sourceView {
    MFSportPopoverViewController *vc = [[MFSportPopoverViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = CGSizeMake(0, 120);
    vc.popoverPresentationController.sourceView = sourceView;
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    vc.popoverPresentationController.sourceRect = CGRectMake(sourceView.bounds.size.width * 0.5, 0, 0, 0);

    [vc setupUI];
    
    return vc;
}

#pragma mark - 监听事件
- (void)chooseMapType:(UIButton *)sender {
    if (sender.tag == _currentType) {
        return;
    }
    _currentType = sender.tag;
    for (UIButton *btn in _btnArr) {
        btn.selected = (btn == sender);
    }
    if (self.didSelectedMapMode != nil) {
        self.didSelectedMapMode(sender.tag);
    }
}

#pragma mark - 搭建界面
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _btnArr = [[NSMutableArray alloc] init];
    UIButton *flatmodeMapBtn = [self makeBtnWithImageName:@"ic_sport_gps_map_flatmode" mapType:MAMapTypeStandard];
    UIButton *realmodeMapBtn = [self makeBtnWithImageName:@"ic_sport_gps_map_realmode" mapType:MAMapTypeSatellite];
    UIButton *mixmodeMapBtn = [self makeBtnWithImageName:@"ic_sport_gps_map_mixmode" mapType:MAMapTypeStandardNight];
    
    [flatmodeMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
        make.left.offset(16);
    }];
    
    [realmodeMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(flatmodeMapBtn);
    }];
    
    [mixmodeMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(realmodeMapBtn);
        make.right.offset(-16);
    }];
}

- (UIButton *)makeBtnWithImageName:(NSString *)imageName mapType:(MAMapType)mapType {
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = mapType;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"_selected"]] forState:UIControlStateSelected];
    [btn sizeToFit];
    [self.view addSubview:btn];
    [_btnArr addObject:btn];
    [btn addTarget:self action:@selector(chooseMapType:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setCurrentType:(MAMapType)currentType {
    _currentType = currentType;
    // 设置按钮的初始选中状态
    for (UIButton *btn in _btnArr) {
        btn.selected = (btn.tag == currentType);
    }
}

@end
