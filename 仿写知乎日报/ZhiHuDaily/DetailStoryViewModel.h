//
//  DetailStoryViewModel.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailStoryViewModel : NSObject


@property (strong,nonatomic)NSString *tagStroyID;
@property (strong,nonatomic)NSArray *allStoriesID;
@property (strong,nonatomic)NSString *htmlStr;
@property (strong,nonatomic)NSURL *imageURL;
@property (strong,nonatomic)NSAttributedString *titleAttText;
@property (strong,nonatomic)NSString *imageSourceText;
@property(assign,readonly,nonatomic)BOOL isLoading;
@property (strong,readonly,nonatomic)NSDictionary *extraDic;


- (instancetype)initWithStoryID:(NSString *)sid;

- (void)getStoryContentWithStoryID:(NSString *)storyID;
- (void)getPreviousStory;
- (void)getNextStory;
- (void)getExtraInfo;

@end
