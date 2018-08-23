//
//  DetailStoryModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/29.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "DetailStoryModel.h"

@implementation DetailStoryModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"storyID"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"image_source"]) {
        return YES;
    }
    return NO;
}

@end
