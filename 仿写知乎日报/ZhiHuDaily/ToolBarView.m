//
//  ToolBarView.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "ToolBarView.h"

@interface HPYButton : UIButton

@end

@implementation HPYButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.center = CGPointMake(self.width/2, self.height/2);
    self.titleLabel.center = CGPointMake(self.width/2+10.f, self.height/2-8.f);
    self.titleLabel.bounds = CGRectMake(0, 0, 30, 10);
    self.titleLabel.font = [UIFont systemFontOfSize:8];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation ToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *lineLayer = [CALayer new];
        lineLayer.frame = CGRectMake(0.f, 0.f, self.width, 1.f);
        lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.layer addSublayer:lineLayer];
        
        self.backgroundColor = [UIColor whiteColor];
        HPYButton *backBtn = [[HPYButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 43)];
        [backBtn setTag:0];
        [backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow_Highlight"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        HPYButton *nextBtn = [[HPYButton alloc] initWithFrame:CGRectMake(kScreenWidth/5,0 ,kScreenWidth/5 , 43)];
        [nextBtn setTag:1];
        [nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
        [nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next_Highlight"] forState:UIControlStateHighlighted];
        [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        
        HPYButton *votedBtn = [[HPYButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*2, 0 ,kScreenWidth/5 , 43)];
        [votedBtn setTag:2];
        [votedBtn setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
        [votedBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateHighlighted];
        [self addSubview:votedBtn];
        
        HPYButton *sharedBtn = [[HPYButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*3, 0 ,kScreenWidth/5 , 43)];
        [sharedBtn setTag:3];
        [sharedBtn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
        [sharedBtn setImage:[UIImage imageNamed:@"News_Navigation_Share_Highlight"] forState:UIControlStateHighlighted];
        [self addSubview:sharedBtn];
        
        HPYButton *commentdBtn = [[HPYButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*4, 0 ,kScreenWidth/5 , 43)];
        [commentdBtn setTag:4];
        [commentdBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
        [commentdBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment_Highlight"] forState:UIControlStateHighlighted];
        [self addSubview:commentdBtn];
    }
    
    return self;
}

- (void)backAction:(id)sender {
    !_back ? :_back();
}


- (void)nextAction:(id)sender {
    !_next ? :_next();
}
@end
