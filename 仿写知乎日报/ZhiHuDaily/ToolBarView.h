//
//  ToolBarView.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)(void);
typedef void(^nextBlock)(void);
typedef void(^updateBlock)(NSDictionary *);

@interface ToolBarView : UIView

@property(strong,nonatomic)backBlock back;
@property(strong,nonatomic)nextBlock next;
@property(strong,nonatomic)updateBlock update;

@end
