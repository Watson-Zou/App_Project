//
//  DetailStoryModel.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DetailStoryModel : JSONModel

@property(strong,nonatomic)NSString *body;
@property(strong,nonatomic)NSString *image_source;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *image;
@property(strong,nonatomic)NSString *storyID;
//@property(strong,nonatomic)NSArray *css;

@end
