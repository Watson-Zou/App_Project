//
//  TPStoryViewController.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/6.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "TPStoryViewController.h"
#import "ToolBarView.h"
#import "RecommenderView.h"


@interface TPStoryViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic)UIWebView *webView;
@property (strong,nonatomic)ToolBarView *toolBar;
@property (strong,nonatomic)UIButton *previousWarnbtn;
@property (strong,nonatomic)UIButton *nextWarnBtn;

@property (strong,nonatomic)TDStoryViewModel *viewModel;

@end

@implementation TPStoryViewController

- (instancetype)initWithViewModel:(TDStoryViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewModel = vm;
        [self configAllObservers];
    }
    return self;
}

- (void)configAllObservers {
    [self.viewModel addObserver:self forKeyPath:@"tdStory" options:NSKeyValueObservingOptionOld context:nil];
    [self.viewModel addObserver:self forKeyPath:@"extraDic" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers {
    [self.viewModel removeObserver:self forKeyPath:@"tdStory"];
    [self.viewModel removeObserver:self forKeyPath:@"extraDic"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self.viewModel getStoryContentWithStoryID:self.viewModel.tagStroyID];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tdStory"]) {
        if ([self.viewModel.type isEqualToString:@"1"]) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:self.viewModel.share_url]];
        }else {
            [self.webView loadHTMLString:self.viewModel.htmlStr baseURL:nil];
        }
        RecommenderView *rcd = (RecommenderView *)self.navigationItem.leftBarButtonItem.customView;
        [rcd setContentWithCommanders:self.viewModel.recommander];
    }
    if ([keyPath isEqualToString:@"extraDic"]) {
        self.toolBar.update(self.viewModel.extraDic);
    }

}

- (void)dealloc {
    [self removeAllObservers];
}
- (void)initSubViews {
    
    _toolBar = ({
        ToolBarView *view = [ToolBarView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.equalTo(self.view);
            make.height.mas_equalTo(43.f);
        }];
        
        __weak typeof(self) weakself = self;
        view.back = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
        
        view.next = ^{
            [weakself.viewModel getNextStory];
        };
        
        view.update = ^(NSDictionary *info){
            UIButton *votebtn = (UIButton *)[self.toolBar viewWithTag:2];
            [votebtn setTitle:[info[@"popularity"] stringValue] forState:UIControlStateNormal];
            [votebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            UIButton *commentsbtn = (UIButton *)[self.toolBar viewWithTag:4];
            [commentsbtn setTitle:[info[@"comments"] stringValue]forState:UIControlStateNormal];
            [commentsbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        };

        view;
    });
    
    _webView = ({
        UIWebView *view = [UIWebView new];
        [self.view insertSubview:view belowSubview:self.toolBar];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.width.equalTo(self.view);
            make.bottom.equalTo(self.toolBar.mas_top);
            make.left.equalTo(self.view);
        }];
        view.scrollView.backgroundColor = [UIColor whiteColor];
        view.scrollView.delegate = self;
        view;
    });
    
    _previousWarnbtn = ({
        UIButton *btn = [UIButton new];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_top).offset(44);
            make.centerX.equalTo(self.view);
        }];
        btn.enabled = NO;
        [btn setTitle:@"载入上一篇" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:[UIImage imageNamed:@"ZHAnswerViewBackIcon"] forState:UIControlStateNormal];
        btn;
    });
    
    _nextWarnBtn = ({
        UIButton *btn = [UIButton new];
        [self.view insertSubview:btn aboveSubview:self.webView];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolBar.mas_top).offset(10);
            make.centerX.equalTo(self.view);
        }];
        btn.enabled = NO;
        [btn setTitle:@"载入下一篇" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:[UIImage imageNamed:@"ZHAnswerViewPrevIcon"] forState:UIControlStateNormal];
        btn;
    });
    
    RecommenderView *rcdView = [[RecommenderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-32.f, 44.f)];
    rcdView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rcdView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < 0.f && offSetY > - 90.f ) {
        if (offSetY > -45.f) {
            self.previousWarnbtn.imageView.transform = CGAffineTransformIdentity;
            [self.previousWarnbtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.view.mas_top).offset(44-offSetY);
            }];
            [super updateViewConstraints];
            
        }else {
            self.previousWarnbtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            if (!self.webView.scrollView.dragging&&!self.viewModel.isLoading) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.viewModel getPreviousStory];
                });
            }
        }
    }
    
    if (offSetY + scrollView.frame.size.height > scrollView.contentSize.height) {
        if (offSetY + scrollView.frame.size.height < scrollView.contentSize.height + 80.f) {
            self.nextWarnBtn.imageView.transform = CGAffineTransformIdentity;
            [self.nextWarnBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.toolBar.mas_top).offset(10-(offSetY+scrollView.frame.size.height-scrollView.contentSize.height));
            }];
            [super updateViewConstraints];
        }else if (offSetY + scrollView.frame.size.height < scrollView.contentSize.height + 160.f){
            self.nextWarnBtn.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
            if (!self.webView.scrollView.dragging&&!self.viewModel.isLoading) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.viewModel getNextStory];
                });
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
