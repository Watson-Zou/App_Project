//
//  TopStoryCollectionViewCell.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/8/22.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverView.h"

@interface TopStoryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet CoverView *cover;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverHeightConstraint;

@end
