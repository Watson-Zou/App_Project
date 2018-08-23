//
//  UITableView+Extension.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/25.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "UITableView+Extension.h"
#import <objc/runtime.h>

static char disableTableHeaderViewKey;

@implementation UITableView (Extension)


- (BOOL)disableTableHeaderView {
    
    return objc_getAssociatedObject(self, &disableTableHeaderViewKey);
}

- (void)setDisableTableHeaderView:(BOOL)disable {
    objc_setAssociatedObject(self, &disableTableHeaderViewKey, @(disable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.disableTableHeaderView) {
        CGRect frame = self.tableHeaderView.frame;
        if (CGRectContainsPoint(frame, point)) {
            return NO;
        }
    }
    return YES;
}

@end
