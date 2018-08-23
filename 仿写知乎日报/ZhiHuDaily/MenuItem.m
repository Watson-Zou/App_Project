//
//  ThemeItem.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/4.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"themeID"];
    }
}

@end
