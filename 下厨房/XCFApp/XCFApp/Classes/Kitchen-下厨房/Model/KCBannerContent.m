//
//  KCBannerContent.m
//  xiachufang
//
//  Created by rkxt_ios on 15/12/21
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "KCBannerContent.h"
#import "KCBannerNavs.h"

@implementation KCBannerContent
MJLogAllIvars
+ (NSDictionary *)objectClassInArray{
    return @{@"navs" : [KCBannerNavs class]};
}

@end
