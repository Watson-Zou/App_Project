//
//  ThemeItem.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/4.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (strong,nonatomic)NSString *themeID;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
