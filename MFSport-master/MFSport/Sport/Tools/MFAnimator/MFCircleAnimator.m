//
//  MFCircleAnimator.m
//  测试动画
//
//  Created by 彭作青 on 2016/11/12.
//  Copyright © 2016年 myself. All rights reserved.
//

#import "MFCircleAnimator.h"

@interface MFCircleAnimator () <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@end
@implementation MFCircleAnimator {
    // 转场上下文
    __weak id<UIViewControllerContextTransitioning> _transitionContext;
    // 记录是否展现
    BOOL _isPresented;
}

#pragma mark - 代理方法
// 告诉控制器谁负责展现
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresented = YES;
    return self;
}

// 告诉控制器谁负责dismiss
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresented = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

// 添加动画的方法
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
	
    UIView *view = _isPresented ? toView : fromView;
    if (_isPresented) {
        [containView addSubview:view];
    }
    
    [self circleAnimationWithView:view];
    
    _transitionContext = transitionContext;
}

// 动画结束后要做的事
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // 一定要告诉控制器转场完毕，否则控制器会一直等待转场完成，无法进行交互
    [_transitionContext completeTransition:YES];
}

// 动画的具体实现方法
- (void)circleAnimationWithView:(UIView *)view {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGFloat rightMargin = 16;
    CGFloat topMargin = 28;
    CGFloat diameter = 30;
    CGFloat viewW = view.bounds.size.width;
    CGFloat viewH = view.bounds.size.height;
    CGRect rect = CGRectMake(viewW - rightMargin - diameter, topMargin, diameter, diameter);
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    layer.path = beginPath.CGPath;
    CGFloat endDiameter = sqrt(viewW * viewW + viewH * viewH);
    CGRect endRect = CGRectInset(rect, -endDiameter, -endDiameter);
    UIBezierPath *endPaht = [UIBezierPath bezierPathWithOvalInRect:endRect];
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"path"];
    if (_isPresented) {
        basic.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
        basic.toValue = (__bridge id _Nullable)(endPaht.CGPath);
    } else {
        basic.fromValue = (__bridge id _Nullable)(endPaht.CGPath);
        basic.toValue = (__bridge id _Nullable)(beginPath.CGPath);
    }
    basic.duration = [self transitionDuration:_transitionContext];
    
    view.layer.mask = layer;
    basic.fillMode = kCAFillModeForwards;
    basic.removedOnCompletion = NO;
    basic.delegate = self;
    [layer addAnimation:basic forKey:nil];
}
@end
