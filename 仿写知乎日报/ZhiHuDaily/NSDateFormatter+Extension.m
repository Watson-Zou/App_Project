//
//  NSDateFormatter+Extension.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/22.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

@end
