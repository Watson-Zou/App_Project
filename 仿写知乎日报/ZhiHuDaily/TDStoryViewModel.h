//
//  TDStoryViewModel.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/6.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDStoryViewModel : NSObject

@property (strong,nonatomic)NSString *tagStroyID;
@property (strong,nonatomic)NSArray *allStoriesID;
@property (strong,nonatomic)NSString *htmlStr;
@property (strong,nonatomic)NSURL *imageURL;
@property (strong,nonatomic)NSAttributedString *titleAttText;
@property (strong,nonatomic)NSString *imageSourceText;
@property(assign,readonly,nonatomic)BOOL isLoading;
@property (strong,nonatomic)NSString *type;
@property (strong,nonatomic)NSURL *share_url;
@property (strong,nonatomic)NSArray *recommander;
@property (strong,readonly,nonatomic)NSDictionary *extraDic;

- (instancetype)initWithStoryID:(NSString *)sid;

- (void)getStoryContentWithStoryID:(NSString *)storyID;
- (void)getPreviousStory;
- (void)getNextStory;
- (void)getExtraInfo;

@end
