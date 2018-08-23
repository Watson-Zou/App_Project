//
//  StoryModel.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/4.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface StoryModel : JSONModel

@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSArray *images;
@property (strong,nonatomic)NSString *storyID;
@property (assign,nonatomic)BOOL multipic;

@end
