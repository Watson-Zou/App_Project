//
//  LoginViewController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/27/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkManager.h"
#import <UIImageView+AFNetworking.h>
@interface LoginViewController (){
    NSMutableString *captchaID;
    NetworkManager *networkManager;
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UIImageView *captchaImageview;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *captcha;
- (IBAction)submitButtonTapped:(UIButton *)sender;
- (IBAction)cancelButtonTapped:(UIButton *)sender;
- (IBAction)backgroundTap:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view from its nib.
    networkManager = [[NetworkManager alloc]init];
    networkManager.delegate = (id)self;
    //初始化图片点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
    [singleTap setNumberOfTapsRequired:1];
    self.captchaImageview.userInteractionEnabled = YES;
    [self.captchaImageview addGestureRecognizer:singleTap];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadCaptchaImage];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCaptchaImageWithURLInString:(NSString *)url{
    [self.captchaImageview setImageWithURL:[NSURL URLWithString:url]];

}

- (IBAction)submitButtonTapped:(UIButton *)sender{
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *captcha = _captcha.text;
    [networkManager LoginwithUsername:username Password:password Captcha:captcha RememberOnorOff:@"off"];
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//验证码图片点击刷新验证码事件
-(void)loadCaptchaImage{
    [networkManager loadCaptchaImage];
}

-(void)loginSuccess{
    [_delegate setUserInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backgroundTap:(id)sender{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_captcha resignFirstResponder];
}

@end
