//
//  DetailHeaderView.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/8/20.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "DetailHeaderView.h"
#import "CoverView.h"

@interface DetailHeaderView()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)CoverView *cover;
@property (nonatomic,strong)UILabel *imgSrcLab;
@property (nonatomic,strong)UILabel *titleLab;


@end

@implementation DetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame mindisplayHeight:(CGFloat)minHeight {
    self = [super initWithFrame:frame];
    if (self) {
        _minDisplayHeight = minHeight;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        _cover = [[CoverView alloc]initWithFrame:CGRectMake(0.f, (self.width-_minDisplayHeight)/2, self.width, _minDisplayHeight)];
        [self addSubview:_cover];
        
        _imgSrcLab = [UILabel new];
        _imgSrcLab.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        _imgSrcLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_imgSrcLab];
        
        _titleLab = [UILabel new];
        _titleLab.numberOfLines = 0;
        [self addSubview:_titleLab];
        [self addObserver:self forKeyPath:@"displayHeight" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"displayHeight"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"displayHeight"]) {
        self.cover.frame = CGRectMake(0.f, (self.width - self.displayHeight)/2, self.width,self.displayHeight);
        self.imgSrcLab.bottom = self.cover.bottom - 5.f;
        self.titleLab.bottom = self.imgSrcLab.top - 5.f;
    }
}

- (void)setHeaderContent:(NSURL *)imgURL title:(NSAttributedString *)title imageSourceText:(NSString *)srcText {
    _imgSrcLab.text = srcText;
    [_imgSrcLab sizeToFit];
    _imgSrcLab.right = self.width - 10.f;
    _imgSrcLab.bottom = _cover.bottom - 5.f;
    CGSize attstrSize = [title boundingRectWithSize:CGSizeMake(self.width-20.f, 300.f) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _titleLab.size = attstrSize;
    _titleLab.left = 10.f;
    _titleLab.bottom = _imgSrcLab.top - 5.f;
    _titleLab.attributedText = title;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *ima = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = ima;
        });
    });
}

- (void)layoutSubviews {
    
}



@end
