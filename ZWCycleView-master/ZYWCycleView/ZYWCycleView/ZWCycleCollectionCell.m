//
//  ZWCycleCollectionCell.m
//  ZYWCycleView
//
//  Created by 郑亚伟 on 2017/1/19.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWCycleCollectionCell.h"

@implementation ZWCycleCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        //创建对象，添加到contentView上
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _myImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_myImageView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.alpha = 0.5;
        [self.myImageView addSubview:_label];
    }
    return self;
}

@end
