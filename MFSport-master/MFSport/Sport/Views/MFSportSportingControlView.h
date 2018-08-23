//
//  MFSportSportingControlView.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/15.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFSportSportingControlView;
@protocol MFSportSportingControlViewDelegate <NSObject>

- (void)sportSportingControlView:(MFSportSportingControlView *)controlView controlButton:(UIButton *)btn;

@end

@interface MFSportSportingControlView : UIView

@property(nonatomic, weak) id<MFSportSportingControlViewDelegate> delegate;

@property (nonatomic, weak) UIButton *stopButton;
@property (nonatomic, weak) UIButton *continueButton;
@property (nonatomic, weak) UIButton *pauseButton;

@end
