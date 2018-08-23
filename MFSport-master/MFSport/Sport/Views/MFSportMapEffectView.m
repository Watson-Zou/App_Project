//
//  MFSportMapEffectView.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/12.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportMapEffectView.h"
#import <Masonry.h>

@implementation MFSportMapEffectView

- (instancetype)initWithEffect:(UIVisualEffect *)effect {
    if (self = [super initWithEffect:effect]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建界面
- (void)setupUI {
    UILabel *distanceLabel = [self makeLabelWithTitle:@"距离(公里)"];
    UILabel *timeLabel = [self makeLabelWithTitle:@"时长"];
    UILabel *distanceDigitLabel = [self makeLabelWithTitle:@"0.00"];
    distanceDigitLabel.font = [UIFont fontWithName:@"DINCond-Bold" size:30];
    UILabel *timeDigitLabel = [self makeLabelWithTitle:@"00:00:00"];
    timeDigitLabel.font = [UIFont fontWithName:@"DINCond-Bold" size:30];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-18);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(0.5);
    }];
    [distanceDigitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(distanceLabel);
        make.bottom.equalTo(distanceLabel.mas_top);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distanceLabel);
        make.centerX.equalTo(self.mas_centerX).multipliedBy(1.5);
    }];
    [timeDigitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(timeLabel.mas_top);
        make.centerX.equalTo(timeLabel);
    }];
    
    _distanceDigitLabel = distanceDigitLabel;
    _timeDigitLabel = timeDigitLabel;
}

- (UILabel *)makeLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    [self addSubview:label];
    return label;
}

@end
