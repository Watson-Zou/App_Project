//
//  MFSportSportingDateShowView.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/15.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportSportingDateShowView.h"
#import <Masonry.h>

@implementation MFSportSportingDateShowView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建界面
- (void)setupUI {
    UILabel *distanceLabel = [self makeLabelWithTitle:@"距离(公里)" font:17 isSystemFont:YES];
    UILabel *showDistanceLabel = [self makeLabelWithTitle:@"0.00" font:90 isSystemFont:NO];
    UILabel *timeLable = [self makeLabelWithTitle:@"时长" font:15 isSystemFont:YES];
    UILabel *showTimeLable = [self makeLabelWithTitle:@"00:00:00" font:28 isSystemFont:NO];
    UILabel *avgSpeedLabel = [self makeLabelWithTitle:@"平均速度(公里/小时)" font:15 isSystemFont:YES];
    UILabel *showAvgSpeedLabel = [self makeLabelWithTitle:@"0" font:28 isSystemFont:NO];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).multipliedBy(1.2);
        make.centerX.equalTo(self);
    }];
    
    [showDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(distanceLabel.mas_top);
        make.centerX.equalTo(distanceLabel);
    }];
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(0.5);
        make.centerY.equalTo(self).multipliedBy(1.8);
    }];
    
    [showTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(timeLable.mas_top);
        make.centerX.equalTo(timeLable);
    }];
    
    [avgSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLable);
        make.centerX.equalTo(self).multipliedBy(1.5);
    }];
    
    [showAvgSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(avgSpeedLabel.mas_top);
        make.centerX.equalTo(avgSpeedLabel);
    }];
    
    _showDistanceLabel = showDistanceLabel;
    _showTimeLable = showTimeLable;
    _showAvgSpeedLabel = showAvgSpeedLabel;
}

- (UILabel *)makeLabelWithTitle:(NSString *)title font:(CGFloat)font isSystemFont:(BOOL)isSystemFont {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    [self addSubview:label];
    if (isSystemFont) {
        label.font = [UIFont systemFontOfSize:font];
        label.textColor = [UIColor lightGrayColor];
    } else {
        label.font = [UIFont fontWithName:@"DINCond-Bold" size:font];
        label.textColor = [UIColor whiteColor];
    }
    return label;
}

@end
