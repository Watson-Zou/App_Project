//
//  ZWCycleView.m
//  ZYWCycleView
//
//  Created by 郑亚伟 on 2017/1/19.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWCycleView.h"
#import "ZWCycleCollectionCell.h"


@interface ZWCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ZWCycleView



- (instancetype)initWithFrame:(CGRect)frame withCycleModels:(NSArray *)cycleModels
{
    self = [super initWithFrame:frame];
    if (self) {
        _cycleModels = cycleModels;
        self.backgroundColor = [UIColor lightGrayColor];
        self.pageControl.numberOfPages = _cycleModels.count;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        //开启定时器
        [self addTimer];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    /*********无限轮播关键点1****************/
    return self.cycleModels.count * 10000;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWCycleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWCycleCollectionCell" forIndexPath:indexPath];
     /*********无限轮播关键点2****************/
    //实际使用的时候用SDWebImage设置一下就可以
     cell.myImageView.image = [UIImage imageNamed:self.cycleModels[indexPath.row % self.cycleModels.count].imageUrl];
    cell.label.text =self.cycleModels[indexPath.row % self.cycleModels.count].des;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 1.获取滚动的偏移量
    CGFloat offsetX = scrollView.contentOffset.x + scrollView.frame.size.width * 0.5;
    // 2.计算pageControl的currentIndex
    /*********无限轮播关键点3****************/
    self.pageControl.currentPage = (int)(offsetX/scrollView.frame.size.width) % (_cycleModels.count);
}
//开始拖动的时候销毁定时器，结束拖动时开启定时器。使用[NSDate distantFuture]和[NSDate distancePast]会有Bug
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
- (void)onTimer:(NSTimer *)timer{
    // 1.获取滚动的偏移量
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    CGFloat offsetX = currentOffsetX + self.collectionView.frame.size.width;
    // 2.滚动该位置
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
-(void)addTimer{
     _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}



- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZWCycleCollectionCell class] forCellWithReuseIdentifier:@"ZWCycleCollectionCell"];
    }
    return _collectionView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //如果想居中，只开启这一句就可以
//    [_pageControl sizeToFit];
    _pageControl.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 40, _pageControl.frame.size.width, 40);
    
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}

-(void)dealloc{
    if (_timer.isValid) {
        [_timer invalidate];
    }
}
@end
