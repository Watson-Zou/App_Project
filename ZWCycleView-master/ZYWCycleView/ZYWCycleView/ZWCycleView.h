//
//  ZWCycleView.h
//  ZYWCycleView
//
//  Created by 郑亚伟 on 2017/1/19.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"
@interface ZWCycleView : UIView
@property(nonatomic,strong)NSArray<CycleModel *> *cycleModels;


- (instancetype)initWithFrame:(CGRect)frame withCycleModels:(NSArray *)cycleModels;
@end
