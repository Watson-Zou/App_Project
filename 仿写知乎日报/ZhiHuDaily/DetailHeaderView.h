//
//  DetailHeaderView.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/8/20.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderView : UIView

@property(nonatomic,assign)CGFloat displayHeight;
@property (nonatomic,assign)CGFloat minDisplayHeight;


- (instancetype)initWithFrame:(CGRect)frame mindisplayHeight:(CGFloat)minHeight;
- (void) setHeaderContent:(NSURL *)imgURL title:(NSAttributedString *)title imageSourceText:(NSString *)srcText;

@end
