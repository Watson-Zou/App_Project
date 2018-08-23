//
//  PanInteractionController.h
//  ZHTransition
//
//  Created by 洪鹏宇 on 16/8/21.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanInteractionController : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign)BOOL active;

- (void)attachToViewController:(UIViewController *)vc;

@end
