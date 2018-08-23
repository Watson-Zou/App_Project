//
//  TDStoryContentModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/6.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "TDStoryContentModel.h"

@implementation TDStoryContentModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"storyID"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
