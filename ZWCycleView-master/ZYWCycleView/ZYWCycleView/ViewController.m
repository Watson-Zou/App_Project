//
//  ViewController.m
//  ZYWCycleView
//
//  Created by 郑亚伟 on 2017/1/19.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"
#import "ZWCycleView.h"
#import "CycleModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *models = [NSMutableArray array];
    //实际使用中换位url就行，另外自定次cell设置图像的时候要用SDWebImage
    CycleModel *model1 =[[CycleModel alloc]init];
    model1.imageUrl = @"car02";
    model1.des = @"1111111";
    [models addObject:model1];
    
    CycleModel *model2 =[[CycleModel alloc]init];
    model2.imageUrl = @"car04";
    model2.des = @"22222222";
    [models addObject:model2];
    
    CycleModel *model3 =[[CycleModel alloc]init];
    model3.imageUrl = @"car05";
    model3.des = @"3333333";
    [models addObject:model3];
    
    ZWCycleView *cycle = [[ZWCycleView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200) withCycleModels:models];
    cycle.cycleModels = [NSArray arrayWithArray:models];
    [self.view addSubview:cycle];

    
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"car04.png" ofType:nil];
//    NSLog(@"path ===%@",path);
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
//    UIImageView *i = [[UIImageView alloc]initWithImage:image];
//    i.frame = CGRectMake(0, 0, 300, 500);
//    [self.view addSubview:i];
}





@end
