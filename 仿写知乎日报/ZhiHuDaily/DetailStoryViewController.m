//
//  DetailStoryViewController.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//


#import "DetailStoryViewController.h"
#import "ToolBarView.h"
#import "DetailHeaderView.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

@interface DetailStoryViewController ()<UIScrollViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property (strong,nonatomic)DetailStoryViewModel *viewModel;

@property (strong,nonatomic)UIScrollView *mainScrollView;
@property (strong,nonatomic)DetailHeaderView *headerView;
@property (strong,nonatomic)ToolBarView *toolBar;
@property (strong,nonatomic)WKWebView *webView;
@property (assign,nonatomic)BOOL isLightContent;//状态栏风格

@property (strong,nonatomic)UIButton *previousWarnbtn;
@property (strong,nonatomic)UIView *placeHolderView;

@end

@implementation DetailStoryViewController

- (instancetype)initWithViewModel:(DetailStoryViewModel *)vm {
    self = [super init];
    if (self) {
        self.isLightContent = YES;
        self.viewModel = vm;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    [self configAllObservers];
    [self.viewModel getStoryContentWithStoryID:self.viewModel.tagStroyID];
}

- (void)configAllObservers {
    [self.viewModel addObserver:self forKeyPath:@"detailStory" options:NSKeyValueObservingOptionOld context:nil];
    [self.viewModel addObserver:self forKeyPath:@"extraDic" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers {
    [self.viewModel removeObserver:self forKeyPath:@"detailStory"];
    [self.viewModel removeObserver:self forKeyPath:@"extraDic"];
}


- (void)dealloc {
    [self removeAllObservers];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"detailStory"]) {
        _webView.height = _mainScrollView.height;
        [self.view addSubview:_placeHolderView];
        [self.webView loadHTMLString:self.viewModel.htmlStr baseURL:[[NSBundle mainBundle]bundleURL]];
        [self.headerView setHeaderContent:self.viewModel.imageURL title:self.viewModel.titleAttText imageSourceText:self.viewModel.imageSourceText];
    }
    
    if ([keyPath isEqualToString:@"extraDic"]) {
        self.toolBar.update(self.viewModel.extraDic);
    }

}



- (void)initSubViews {
    
    _toolBar = ({
        ToolBarView *view = [[ToolBarView alloc] initWithFrame:CGRectMake(0, kScreenHeight-43.f, kScreenWidth, 43.f)];
        [self.view addSubview:view];
        __weak typeof(self) weakSelf = self;
        view.back = ^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        };
        view.next = ^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.mainScrollView setContentOffset:CGPointZero animated:NO];
            strongSelf.mainScrollView.clipsToBounds = NO;
            [strongSelf.viewModel getNextStory];
        };
        view.update = ^(NSDictionary *info){
            __strong typeof(self) strongSelf = weakSelf;
            UIButton *votebtn = (UIButton *)[strongSelf.toolBar viewWithTag:2];
            [votebtn setTitle:[info[@"popularity"] stringValue] forState:UIControlStateNormal];
            [votebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            UIButton *commentsbtn = (UIButton *)[strongSelf.toolBar viewWithTag:4];
            [commentsbtn setTitle:[info[@"comments"] stringValue]forState:UIControlStateNormal];
            [commentsbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        };
        view;
    });
    
    _mainScrollView = ({
        UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20.f, kScreenWidth, kScreenHeight-20.f-self.toolBar.height)];
        [self.view insertSubview:view atIndex:0];
        view.delegate = self;
        view.clipsToBounds = NO;
        view;
    });
    
    _headerView = ({
        DetailHeaderView *view = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0.f, -((kScreenWidth-220.f)/2+20.f), kScreenWidth, kScreenWidth) mindisplayHeight:220.f];
        [self.mainScrollView addSubview:view];
        view;
    });
    
    
    _webView = ({
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"news_qa.min" ofType:@"css"];
//        NSString *path = @"http:\/\/news-at.zhihu.com\/css\/news_qa.auto.css?v=4b3e3";
//        NSString *js = [NSString stringWithFormat:
//                        @"document.getElementsByClassName('img-place-holder')[0].style.display = 'none';\
//                        var link = document.createElement('link');\
//                        link.setAttribute('rel','stylesheet');\
//                        link.setAttribute('type','text/css');\
//                        link.setAttribute('href','%@');\
//                        document.getElementsByTagName('head')[0].appendChild(link);",path];
        NSString *js = @"document.getElementsByClassName('img-place-holder')[0].style.display = 'none'";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:script];
        WKWebView *view = [[WKWebView alloc] initWithFrame:CGRectMake(0, 200.f, kScreenWidth, self.mainScrollView.height-200.f) configuration:config];
        [self.mainScrollView addSubview:view];
        view.navigationDelegate = self;
        [view setBackgroundColor:[UIColor clearColor]];
        [view.scrollView setScrollEnabled:NO];
        [view.scrollView setBackgroundColor:[UIColor clearColor]];
        view;
    });

    
    _placeHolderView = [[UIView alloc] initWithFrame:CGRectMake(0, 220.f, kScreenWidth, self.view.height-220.f-43.f)];
    _placeHolderView.backgroundColor = [UIColor whiteColor];
    
    
    _previousWarnbtn = ({
        UIButton *btn = [UIButton new];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_top).offset(-12);
            make.centerX.equalTo(self.view);
        }];
        btn.enabled = NO;
        [btn setTitle:@"载入上一篇" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:[UIImage imageNamed:@"ZHAnswerViewBackIcon"] forState:UIControlStateNormal];
        btn;
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (offSetY<=0.f&&offSetY>= -40.f) {
        [_webView.scrollView setContentOffset:CGPointMake(0, offSetY)];
        _headerView.displayHeight = _headerView.minDisplayHeight - offSetY*2;
    }else if (offSetY<-40.f) {
        [_mainScrollView setContentOffset:CGPointMake(0, -40.f)];
    }else if (offSetY>0&&offSetY<220.f) {
        _mainScrollView.clipsToBounds = NO;
    }else {
        _mainScrollView.clipsToBounds = YES;
    }
 
    {
    self.isLightContent = offSetY < 220.f;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    
    if (offSetY <= 0.f && offSetY >= -40.f ) {
        if (offSetY > -20.f) {
            self.previousWarnbtn.imageView.transform = CGAffineTransformIdentity;
            [self.previousWarnbtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.view.mas_top).offset(-12-offSetY*2);
            }];
            [super updateViewConstraints];

        }else {
            self.previousWarnbtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            if (!self.mainScrollView.dragging&&!self.viewModel.isLoading) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.viewModel getPreviousStory];
                });
            }
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        [self presentViewController:[[SFSafariViewController alloc] initWithURL:url] animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        _webView.height = [data floatValue];
        _mainScrollView.contentSize = CGSizeMake(kScreenWidth, _webView.height+200.f);
        [_placeHolderView removeFromSuperview];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (!self.isLightContent) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

@end
