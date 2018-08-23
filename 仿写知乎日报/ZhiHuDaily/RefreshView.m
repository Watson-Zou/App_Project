//
//  RefreshView.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/28.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView()

@property (strong,nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) CAShapeLayer *whiteCircleLayer;
@property (strong,nonatomic) CAShapeLayer *grayCircleLayer;

@end

@implementation RefreshView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_indicatorView stopAnimating];
        [self addSubview:_indicatorView];

        CGFloat radius = MIN(frame.size.width, frame.size.height)/2-3;
        _grayCircleLayer = [[CAShapeLayer alloc] init];
        _grayCircleLayer.lineWidth = 0.5f;
        _grayCircleLayer.strokeColor = [UIColor grayColor].CGColor;
        _grayCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _grayCircleLayer.opacity = 0.f;
        _grayCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.width/2-radius, self.height/2-radius, 2*radius, 2*radius)].CGPath;
        [self.layer addSublayer:_grayCircleLayer];
    
        _whiteCircleLayer = [[CAShapeLayer alloc] init];
        _whiteCircleLayer.lineWidth = 1.f;
        _whiteCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _whiteCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _whiteCircleLayer.strokeEnd = 0.f;
        _whiteCircleLayer.opacity = 0.f;
        _whiteCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.height/2) radius:radius startAngle:M_PI_2 endAngle:M_PI*5/2 clockwise:YES].CGPath;
        [self.layer addSublayer:_whiteCircleLayer];
    }
    return self;
}


- (void)redrawFromProgress:(CGFloat)progress {
    if (_refresh) return;
    
    if (progress > 0.05) {
        _whiteCircleLayer.opacity = 1.f;
        _grayCircleLayer.opacity = 1.f;
    }else {
        _whiteCircleLayer.opacity = 0.f;
        _grayCircleLayer.opacity = 0.f;
    }
    _whiteCircleLayer.strokeEnd = progress;
 
}

- (void)setRefresh:(BOOL)refresh {
    _refresh = refresh;
    if (_refresh) {
        [self startAnimation];
    }else {
        [self stopAnimation];
    }
}

- (void)startAnimation {
    _whiteCircleLayer.opacity = 0.f;
    _grayCircleLayer.opacity = 0.f;
    [_indicatorView startAnimating];
}

- (void)stopAnimation {
    [_indicatorView stopAnimating];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20.f, 20.f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
