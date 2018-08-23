//
//  LaunchViewController.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/7.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *launchView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showAnimation];
}

- (void)showAnimation {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault dataForKey:@"LaunchImageData"]) {
        _imageView.image = [UIImage imageWithData:[userDefault dataForKey:@"LaunchImageData"]];
        _titleLab.text = [userDefault stringForKey:@"LaunchText"];
        [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _launchView.alpha = 0.f;
            _imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            self.view.window.rootViewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainViewController;
            [self backgroundThreadUpdateLaunchData];
        }];
    }else {
        CGFloat scale = [UIScreen mainScreen].scale;
        NSInteger imageWidth = [@(kScreenWidth * scale) integerValue];
        NSInteger imageHeight = [@(kScreenHeight * scale) integerValue];
        [NetOperation getRequestWithURL:[NSString stringWithFormat:@"prefetch-launch-images/%ld*%ld",(long)imageWidth,(long)imageHeight] parameters:nil success:^(id responseObject) {
            NSDictionary *dicData = [responseObject[@"creatives"] firstObject];
            NSString *text = dicData[@"text"];
            NSString *urlString = dicData[@"url"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _titleLab.text = text;
                _imageView.image = [UIImage imageWithData:imageData];
                [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    _launchView.alpha = 0.f;
                    _imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                } completion:^(BOOL finished) {
                    self.view.window.rootViewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainViewController;
                }];
            });
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:text forKey:@"LaunchText"];
            [userDefault setObject:urlString forKey:@"LaunchImageUrlString"];
            [userDefault setObject:imageData forKey:@"LaunchImageData"];
        } failure:nil];
    }
}

- (void)backgroundThreadUpdateLaunchData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        NSInteger imageWidth = [@(kScreenWidth * scale) integerValue];
        NSInteger imageHeight = [@(kScreenHeight * scale) integerValue];
        [NetOperation getRequestWithURL:[NSString stringWithFormat:@"prefetch-launch-images/%ld*%ld",(long)imageWidth,(long)imageHeight] parameters:nil success:^(id responseObject) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSDictionary *dicData = [responseObject[@"creatives"] firstObject];
            NSString *urlString = dicData[@"url"];
            if (![urlString isEqualToString:[userDefault stringForKey:@"LaunchImageUrlString"]]) {
                NSString *text = dicData[@"text"];
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                [userDefault setObject:text forKey:@"LaunchText"];
                [userDefault setObject:imageData forKey:@"LaunchImageData"];
                [userDefault setObject:urlString forKey:@"LaunchImageUrlString"];
                
            }
        } failure:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
