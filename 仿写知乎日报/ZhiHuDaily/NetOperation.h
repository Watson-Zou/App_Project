//
//  NetOperation.h
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/1.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetOperation : NSObject

typedef void (^success)(id responseObject);
typedef void (^failure)(NSError *error);

+ (void)getRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(success)success failure:(failure)failure;

@end
