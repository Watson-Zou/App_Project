//
//  TDStoryViewModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/6.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "TDStoryViewModel.h"
#import "TDStoryContentModel.h"

@interface TDStoryViewModel()

@property(strong,nonatomic)TDStoryContentModel *tdStory;

@end

@implementation TDStoryViewModel

- (instancetype)initWithStoryID:(NSString *)sid {
    self = [super init];
    if (self) {
        self.tagStroyID = sid;
    }
    return self;
}

- (NSString *)htmlStr {
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_tdStory.css[0],_tdStory.body];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:_tdStory.image];
}

-(NSAttributedString *)titleAttText {
    
    return [[NSAttributedString alloc] initWithString:_tdStory.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSString *)imageSourceText {
    return [NSString stringWithFormat:@"图片: %@",_tdStory.image_source];
}

- (NSString *)type {
    return _tdStory.type;
}

- (NSURL *)share_url {
    return [NSURL URLWithString:_tdStory.share_url];
}

- (NSArray *)recommander {
    return _tdStory.recommenders;
}

- (void)getStoryContentWithStoryID:(NSString *)storyID{
    _isLoading = YES;
    [NetOperation getRequestWithURL:[NSString stringWithFormat:@"story/%@",storyID] parameters:nil success:^(id responseObject) {
        TDStoryContentModel *model = [[TDStoryContentModel alloc] initWithDictionary:responseObject error:nil];
        self.tagStroyID = storyID;
        [self setValue:model forKey:@"tdStory"];
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
