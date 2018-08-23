//
//  PanInteractionController.m
//  ZHTransition
//
//  Created by 洪鹏宇 on 16/8/21.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "PanInteractionController.h"

@interface PanInteractionController()

@property(weak,nonatomic)UIViewController *viewController;
@property(assign,nonatomic)BOOL complete;

@end

@implementation PanInteractionController

- (void)attachToViewController:(UIViewController *)vc {
    self.viewController = vc;
    [self.viewController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGFloat translationX = [gesture translationInView:gesture.view.superview].x;
    CGFloat progress = fminf(1, fmax(0, translationX/300.f));
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.active = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            self.complete = progress > 0.5f;
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
            self.active = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
            self.active = NO;
            if (self.complete) {
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
