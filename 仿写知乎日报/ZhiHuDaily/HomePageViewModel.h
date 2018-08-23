//
//  HomePageViewModel.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/4.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryCellViewModel.h"

@interface HomePageViewModel : NSObject

@property(strong,readonly,nonatomic)NSMutableArray *sectionViewModels;
@property(strong,readonly,nonatomic)NSMutableArray *top_stories;
@property(assign,nonatomic)BOOL isLoading;
@property(strong,readonly,nonatomic)NSMutableArray *allStoriesID;
@property(strong,nonatomic)NSString *currentLoadDayStr; //已加载最靠前那一天的日期字符串


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSAttributedString *)titleForSection:(NSInteger)section;
- (StoryCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)getLatestStories;
- (void)getPreviousStories;

@end
