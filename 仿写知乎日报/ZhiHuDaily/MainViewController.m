//
//  MainViewController.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "MainViewController.h"

//打开抽屉动画参数初始值
#define AnimateDuration             0.2
#define HomeViewOriginXFromValue    0
#define HomeViewOriginXEndValue     kScreenWidth*0.6
#define HomeViewMoveXMaxValue       (HomeViewOriginXEndValue - HomeViewOriginXFromValue)
#define HomeViewWidthScaleFromValue     1
#define HomeViewWidthScaleEndValue      1
#define HomeViewHeightScaleFromValue     1
#define HomeViewHeightScaleEndValue      1
#define HomeViewWidthScaleMaxValue       (HomeViewWidthScaleEndValue - HomeViewWidthScaleFromValue)
#define HomeViewHeightScaleMaxValue      (HomeViewHeightScaleEndValue - HomeViewHeightScaleFromValue)
#define LeftViewOriginXFromValue    -kScreenWidth*0.6
#define LeftViewOriginXEndValue     0
#define LeftViewMoveXMaxValue       (LeftViewOriginXEndValue - LeftViewOriginXFromValue)
#define LeftViewWidthScaleFromValue      1
#define LeftViewWidthScaleEndValue       1
#define LeftViewHeightScaleFromValue      1
#define LeftViewHeightScaleEndValue       1
#define LeftViewWidthScaleMaxValue       (LeftViewWidthScaleEndValue - LeftViewWidthScaleFromValue)
#define LeftViewHeightScaleMaxValue       (LeftViewHeightScaleEndValue - LeftViewHeightScaleFromValue)
@interface MainViewController ()

@property (strong,nonatomic)UIViewController *leftMenuViewController;
@property (strong,nonatomic)UIViewController *homeViewController;
@property (strong,nonatomic)UIView *homeView;
@property (strong,nonatomic)UIView *menuView;
@property (assign,nonatomic)CGFloat distance;
@property (strong,nonatomic)UITapGestureRecognizer *tapGesture;

@end

@implementation MainViewController

- (instancetype)initWithLeftMenuViewController:(UIViewController *)leftMenuVC andHomeViewController:(UIViewController *)homeVC {
    self = [super init];
    if (self) {
        self.homeViewController = homeVC;
        self.leftMenuViewController = leftMenuVC;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:_leftMenuViewController];
    _menuView = _leftMenuViewController.view;
    _menuView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftViewWidthScaleFromValue, LeftViewHeightScaleFromValue), CGAffineTransformMakeTranslation(LeftViewOriginXFromValue, 0));
    [self.view addSubview:_menuView];
    [_leftMenuViewController didMoveToParentViewController:self];

    
    [self addChildViewController:_homeViewController];
    _homeView = _homeViewController.view;
    _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeViewWidthScaleFromValue, HomeViewHeightScaleFromValue), CGAffineTransformMakeTranslation(HomeViewOriginXFromValue, 0));
    [self.view addSubview:_homeView];
    [_homeViewController didMoveToParentViewController:self];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.homeView addGestureRecognizer:pan];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
    [self showHomeView];
}

- (void)pan:(UIPanGestureRecognizer *)recongizer {
    CGFloat moveX = [recongizer translationInView:self.homeView].x;
    _distance = _distance + moveX;
    CGFloat percent = _distance/HomeViewMoveXMaxValue;
    if (percent >= 0 && percent <= 1) {
        _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeViewWidthScaleFromValue +HomeViewWidthScaleMaxValue * percent, HomeViewHeightScaleFromValue + HomeViewHeightScaleMaxValue * percent), CGAffineTransformMakeTranslation(HomeViewOriginXFromValue + _distance, 0));
        _menuView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftViewWidthScaleFromValue + LeftViewWidthScaleMaxValue * percent, LeftViewHeightScaleFromValue + LeftViewHeightScaleMaxValue * percent), CGAffineTransformMakeTranslation(LeftViewOriginXFromValue + _distance, 0));
    }
    
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        if (percent < 0.5) {
            [self showHomeView];
        }else {
            [self showMenuView];
        }
    }
    
    [recongizer setTranslation:CGPointZero inView:self.view];
    
}

- (void)showMenuView {
    [UIView animateWithDuration:AnimateDuration animations:^{
        _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeViewWidthScaleEndValue, HomeViewHeightScaleEndValue), CGAffineTransformMakeTranslation(HomeViewOriginXEndValue, 0));
        _menuView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftViewWidthScaleEndValue, LeftViewHeightScaleEndValue), CGAffineTransformMakeTranslation(LeftViewOriginXEndValue, 0));
    } completion:^(BOOL finished) {
        _distance = HomeViewOriginXEndValue;
        [_homeView addGestureRecognizer:_tapGesture];
        
    }];
}

- (void)showHomeView {
    [UIView animateWithDuration:AnimateDuration animations:^{
        _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeViewWidthScaleFromValue, HomeViewHeightScaleFromValue), CGAffineTransformMakeTranslation(HomeViewOriginXFromValue, 0));
        _menuView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftViewWidthScaleFromValue, LeftViewHeightScaleFromValue), CGAffineTransformMakeTranslation(LeftViewOriginXFromValue, 0));
    } completion:^(BOOL finished) {
        _distance = HomeViewOriginXFromValue;
        [_homeView removeGestureRecognizer:_tapGesture];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
