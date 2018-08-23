//
//  CarouselView.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/24.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlock)(NSIndexPath *);

@interface CarouselView : UIView

@property (strong,nonatomic)NSArray *stroies;
@property (strong,nonatomic)tapBlock tap;
@property (assign,nonatomic)CGFloat displayHeight;

@end
