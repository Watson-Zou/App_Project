//
//  ThemeViewModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/5.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "ThemeViewModel.h"
#import "StoryCellViewModel.h"


@implementation ThemeViewModel


- (NSUInteger)numberOfSections {
    return self.sectionViewModels.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    NSArray *cellvms = self.sectionViewModels[section];
    return cellvms.count;
}

- (StoryCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cellvms = self.sectionViewModels[indexPath.section];
    return cellvms[indexPath.row];
}

- (void)getDailyThemesData{
    _sectionViewModels = @[].mutableCopy;
    [NetOperation getRequestWithURL:[NSString stringWithFormat:@"theme/%@",_themeID] parameters:nil success:^(id responseObject) {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSArray *storiesArr = jsonDic[@"stories"];
        NSMutableArray* tempArr = [NSMutableArray array];
        for (NSDictionary *dic in storiesArr) {
            StoryCellViewModel *vm = [[StoryCellViewModel alloc] initWithDictionary:dic];
            [tempArr addObject:vm];
        }
        self.name = jsonDic[@"name"];
        [self.sectionViewModels addObject:tempArr];
        _allStoriesID = [NSMutableArray arrayWithArray:[tempArr valueForKey:@"storyID"]];
        self.imageURLStr = jsonDic[@"background"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getThemeDataSuccss" object:nil userInfo:nil];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getMoreDailyThemesData {
    if (_isLoading) return;
    [NetOperation getRequestWithURL:[NSString stringWithFormat:@"theme/%@/before/%@",_themeID,[_allStoriesID lastObject]] parameters:nil success:^(id responseObject) {
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSArray *storiesArr = jsonDic[@"stories"];
        NSMutableArray* tempArr = [NSMutableArray array];
        for (NSDictionary *dic in storiesArr) {
            StoryCellViewModel *vm = [[StoryCellViewModel alloc] initWithDictionary:dic];
            [tempArr addObject:vm];
        }
        NSMutableArray *temp = [self mutableArrayValueForKey:@"sectionViewModels"];
        [temp addObject:tempArr];
        [_allStoriesID addObjectsFromArray:[tempArr valueForKeyPath:@"storyID"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            for (StoryCellViewModel *vm in tempArr){
                [vm dowmloadImage];
            }
        });
        _isLoading = NO;
    } failure:^(NSError *error) {
        _isLoading = NO;
    }];
}


@end
