//
//  MFSportGPSButton.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/14.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportGPSButton.h"
#import "MFSportTrackingModel.h"

@implementation MFSportGPSButton

- (instancetype)initWithImageName:(NSString *)imageName {
    MFSportGPSButton *btn = [[MFSportGPSButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.enabled = NO;
    [btn setTitle:@" 请避开高楼大厦" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 16;
    btn.layer.masksToBounds = YES;
    btn.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 8);

    return btn;
}

- (instancetype)init {
    if (self = [super init]) {
    	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsSignalChanged:) name:MFSportGPSSignalChangedNotifictaion object:nil];
    }
    return self;
}

- (void)gpsSignalChanged:(NSNotification *)noti {
    MFSportGPSSignalState state = [noti.object intValue];
    NSString *imageName = _isMapButton ? @"ic_sport_gps_map" : @"ic_sport_gps";
    NSString *title;
    switch (state) {
        case MFSportGPSSignalStateDisconnect:
            imageName = [imageName stringByAppendingString:@"_disconnect"];
            title = @"GPS已断开";
            break;
        case MFSportGPSSignalStateBad:
            imageName = [imageName stringByAppendingString:@"_connect_1"];
            title = @"请绕开高楼大厦";
            break;
        case MFSportGPSSignalStateNormal:
            imageName = [imageName stringByAppendingString:@"_connect_2"];
            break;
        case MFSportGPSSignalStateGood:
            imageName = [imageName stringByAppendingString:@"_connect_3"];
            break;
    }
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIEdgeInsets inset = self.contentEdgeInsets;
    inset.right = (title == nil) ? 4 : 8;
    self.contentEdgeInsets = inset;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
