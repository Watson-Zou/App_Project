//
//  StoryModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/4.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"storyID"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"multipic"]) {
        return YES;
    }
    if ([propertyName isEqualToString:@"images"]) {
        return YES;
    }
    return NO;
}

@end
