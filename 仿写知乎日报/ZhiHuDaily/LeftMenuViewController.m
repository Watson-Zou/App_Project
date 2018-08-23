//
//  LeftMenuViewController.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/21.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MenuItem.h"
#import "ThemeViewController.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong,nonatomic) NSMutableArray *subscribedList;
@property (strong,nonatomic) NSMutableArray *othersList;
@property (strong,nonatomic) NSMutableArray *menuItems;

@end

@implementation LeftMenuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor darkGrayColor];
    _mainTableView.backgroundColor =[UIColor clearColor];
    _mainTableView.rowHeight = 44.f;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ThemeItem"];
    _menuItems = [NSMutableArray array];
    MenuItem *homeMenuItem = [[MenuItem alloc] initWithDictionary:@{@"name":@"首页",@"imageName":@"Menu_Icon_Home"}];
    [_menuItems addObject:homeMenuItem];
    [self getThemeList];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getThemeList {
    [NetOperation getRequestWithURL:@"themes" parameters:nil success:^(id responseObject) {
        NSDictionary *jsonDic = (NSDictionary*)responseObject;
        NSArray *subArr = jsonDic[@"subscribed"];
        for (NSDictionary *dic in subArr) {
            MenuItem *model = [[MenuItem alloc] initWithDictionary:dic];
            [_menuItems addObject:model];
        }
        NSArray *othArr = jsonDic[@"others"];
        for (NSDictionary *dic in othArr) {
            MenuItem *model = [[MenuItem alloc] initWithDictionary:dic];
            [_menuItems addObject:model];
        }
        [_mainTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThemeItem"];
    MenuItem *item = [_menuItems objectAtIndex:indexPath.row];
    if (item.imageName) {
        cell.imageView.image = [UIImage imageNamed:item.imageName];
    }else {
        cell.imageView.image = nil;
    }
    cell.textLabel.text = item.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainViewController *mainVC = (MainViewController *)self.view.window.rootViewController;
        [mainVC showHomeView];
    }else {
        MenuItem *item = [_menuItems objectAtIndex:indexPath.row];
        ThemeViewModel *tvm = [ThemeViewModel new];
        tvm.themeID = item.themeID;
        ThemeViewController *themeVC = [[ThemeViewController alloc] initWithViewModel:tvm];
        UINavigationController *subNavC = [[UINavigationController alloc] initWithRootViewController:themeVC];
        subNavC.transitioningDelegate = (MainViewController *) self.view.window.rootViewController;
        [self.view.window.rootViewController presentViewController:subNavC animated:YES completion:nil];
    }
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end
