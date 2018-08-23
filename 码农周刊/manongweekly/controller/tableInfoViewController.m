//
//  tableInfoViewController.m
//  manongweekly
//
//  Created by xiangwenwen on 15/4/20.
//  Copyright (c) 2015年 xiangwenwen. All rights reserved.
//

#import "tableInfoViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "modelManager.h"
#import "MNContentCell.h"
#import "ManongTitle.h"
#import "ManongContent.h"
#import "webPageViewController.h"

@interface tableInfoViewController()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) NSIndexPath *updateIndexPath;
@property (weak, nonatomic) IBOutlet UITableView *contentCategoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *tableInfoLoading;

@end

@implementation tableInfoViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"table view controller Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    self.contentCategoryTable.dataSource = self;
    self.contentCategoryTable.delegate = self;
    self.navigationItem.title = self.tagToInfoParameter;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.contentCategoryTable && self.updateIndexPath) {
        [self updateUI];
    }
}

-(void)updateUI
{
    __weak tableInfoViewController *weakSelf = self;
    self.tableInfoLoading.hidden = NO;
    self.contentCategoryTable.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *arr = [weakSelf.manager fetchAllManongContent:[NSString stringWithFormat:@"user-content-%@",weakSelf.tagToInfoParameter]];
        [weakSelf.dataSource removeAllObjects];
        weakSelf.dataSource = [[NSMutableArray alloc] initWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.tableInfoLoading.hidden = YES;
            weakSelf.contentCategoryTable.hidden = NO;
            [weakSelf.contentCategoryTable reloadData];
        });
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MNContentsCell" forIndexPath:indexPath];
    cell.manongContent = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"table view controller Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    if ([segue.identifier isEqualToString:@"gotoWebPage"]) {
        __weak tableInfoViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *navC = (UINavigationController *)segue.destinationViewController;
            weakSelf.updateIndexPath = [weakSelf.contentCategoryTable indexPathForSelectedRow];
            ManongContent *content = weakSelf.dataSource[weakSelf.updateIndexPath.row];
            NSDate *date = [NSDate date];
            NSString *readTime = [weakSelf.manager createDateNowString:date];
            ManongContent *mncontent = [weakSelf.manager fetchManong:@"ManongContent" fetchKey:@"wkName" fetchValue:content.wkName];
            if (mncontent) {
                mncontent.wkTime = date;
                mncontent.wkStringTime = readTime;
                mncontent.wkStatus = @YES;
                mncontent.wkCount = [NSNumber numberWithInteger:[mncontent.wkCount integerValue] + 1];
                [weakSelf.manager saveData];
            }
            NSURL *url = [NSURL URLWithString:mncontent.wkUrl];
            webPageViewController *webPage = (webPageViewController *)navC.topViewController;
            webPage.requestURL = url;
            webPage.requestTitle = mncontent.wkName;
            webPage.dataSource = weakSelf.dataSource;
            webPage.currentMC = mncontent;
            webPage.manager = weakSelf.manager;
        });
    }
}
- (IBAction)backForIndex:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"table info view controller 销毁");
}

@end
