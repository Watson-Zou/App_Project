//
//  ZHDismissAnimationController.m
//  ZHTransition
//
//  Created by 洪鹏宇 on 16/8/21.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "ZHDismissAnimationController.h"

@implementation ZHDismissAnimationController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *containView = transitionContext.containerView;
    [containView insertSubview:toView atIndex:0];
    [UIView animateWithDuration:self.animationDuration animations:^{
        fromView.frame = CGRectOffset(fromView.frame, screenWidth , 0);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
