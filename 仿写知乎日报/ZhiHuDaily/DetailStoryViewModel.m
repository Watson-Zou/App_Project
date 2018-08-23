//
//  DetailStoryViewModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "DetailStoryViewModel.h"
#import "DetailStoryModel.h"

@interface DetailStoryViewModel()

@property(strong,nonatomic)DetailStoryModel *detailStory;

@end

@implementation DetailStoryViewModel

- (instancetype)initWithStoryID:(NSString *)sid {
    self = [super init];
    if (self) {
        self.tagStroyID = sid;
    }
    return self;
}

- (NSString *)htmlStr {
    return [NSString stringWithFormat:@"<html><head><meta name='viewport' content='initial-scale=1.0,user-scalable=no' /><link type='text/css' rel='stylesheet' href = 'http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3' ></link></head><body>%@</body></html>",_detailStory.body];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:_detailStory.image];
}

-(NSAttributedString *)titleAttText {
    
    return [[NSAttributedString alloc] initWithString:_detailStory.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSString *)imageSourceText {
    return [NSString stringWithFormat:@"图片: %@",_detailStory.image_source];
}

- (void)getStoryContentWithStoryID:(NSString *)storyID{
    _isLoading = YES;
    [NetOperation getRequestWithURL:[NSString stringWithFormat:@"story/%@",storyID] parameters:nil success:^(id responseObject) {
        DetailStoryModel *model = [[DetailStoryModel alloc] initWithDictionary:responseObject error:nil];
        self.tagStroyID = storyID;
        [self setValue:model forKey:@"detailStory"];
        [self getExtraInfo];
        _isLoading = NO;
    } failure:^(NSError *error) {
        
    }];
}

- (void)getPreviousStory {
    NSInteger index = [self.allStoriesID indexOfObject:self.tagStroyID];
    if (--index >= 0) {
        NSString* nextStoryID = [self.allStoriesID objectAtIndex:index];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

- (void)getNextStory {
    NSUInteger index = [self.allStoriesID indexOfObject:self.tagStroyID];
    if (++index < self.allStoriesID.count) {
        NSString* nextStoryID = [self.allStoriesID objectAtIndex:index];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

- (void)getExtraInfo {
    [NetOperation getRequestWithURL:[NSString stringWithFormat:@"story-extra/%@",self.tagStroyID] parameters:nil success:^(id responseObject) {
        [self setValue:responseObject forKey:@"extraDic"];
    } failure:^(NSError *error) {
        
    }];
}

@end
