//
//  MFSportMainViewController.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/9.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportMainViewController.h"
#import <Masonry.h>
#import "MFSportTrackingModel.h"
#import "MFSportSportingViewController.h"

@interface MFSportMainViewController ()
@property(nonatomic, weak) UIButton *walkBtn;
@property(nonatomic, weak) UIButton *runBtn;
@property(nonatomic, weak) UIButton *bikeBtn;

@end

@implementation MFSportMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
}

- (void)setupUI {
    _walkBtn = [self makeBtn:@"我要走走" sportType:MFSportTypeWalk];
    [_walkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-30);
        make.centerX.equalTo(self.view);
    }];
	
    _runBtn = [self makeBtn:@"我要跑跑" sportType:MFSportTypeRun];
    [_runBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_walkBtn);
        make.top.equalTo(_walkBtn.mas_bottom).offset(10);
    }];
    
    _bikeBtn = [self makeBtn:@"我要骑行" sportType:MFSportTypeBike];
    [_bikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_runBtn);
        make.top.equalTo(_runBtn.mas_bottom).offset(10);
    }];
}

- (UIButton *)makeBtn:(NSString *)title sportType:(MFSportType)type {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = type;
    [btn addTarget:self action:@selector(startSport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

- (void)startSport:(UIButton *)btn {
    MFSportSportingViewController *vc = [[MFSportSportingViewController alloc] init];
    vc.sportType = btn.tag;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
