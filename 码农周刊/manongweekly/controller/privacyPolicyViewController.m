//
//  privacyPolicyViewController.m
//  manongweekly
//
//  Created by xiangwenwen on 15/6/4.
//  Copyright (c) 2015年 xiangwenwen. All rights reserved.
//

#import "GStaticDataSource.h"
#import "privacyPolicyViewController.h"
#import "webPageViewController.h"

@interface privacyPolicyViewController ()<UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSURL *policyURL;
@property (strong,nonatomic) UIApplication *application;

@end

@implementation privacyPolicyViewController

-(NSURL *)policyURL
{
    if (!_policyURL) {
        _policyURL = [NSURL URLWithString:@"http://"];
    }
    return _policyURL;
}

-(UIApplication *)application
{
    if (!_application) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.policyTitle;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, MANNAVHEIGHT-20, MANSCREENWIDTH-10, 200)];
    textview.text = @"申明 \n\n《猿已阅》不会存留你的（用户）任何信息，包括Email，若你需要订阅《码农周刊》，可以在［订阅《码农周刊》快捷通道］中输入你的Email进行订阅。若你（用户）确认订阅，一切事宜与此应用作者无关，请详细阅读《码农周刊》的隐私政策以及服务条款。";
    textview.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    textview.font = [UIFont systemFontOfSize:14.0];
    textview.editable = NO;
    [self.view addSubview:textview];
    
    UIButton *gotoManong = [[UIButton alloc] initWithFrame:CGRectMake(10,(MANNAVHEIGHT - 20)+200, MANSCREENWIDTH-10, 30)];
    [gotoManong setTitle:@"《码农周刊》隐私政策与订阅" forState:UIControlStateNormal];
    [gotoManong setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000] forState:UIControlStateNormal];
    [gotoManong setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [gotoManong addTarget:self action:@selector(gotoManongWeeklyPolicy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotoManong];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackImage"] style:UIBarButtonItemStylePlain target:self action:@selector(backForSetting)];
    self.navigationItem.leftBarButtonItem = back;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)gotoManongWeeklyPolicy
{
    UINavigationController *navC= (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"manongwebpage"];
    webPageViewController *webPage = (webPageViewController *)navC.topViewController;
    webPage.requestURL = [NSURL URLWithString:@"http://weekly.manong.io/"];
    webPage.requestTitle = @"码农周刊订阅隐私政策";
    [self presentViewController:navC animated:YES completion:nil];
}

-(void)backForSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"privacy policy -- 释放");
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
