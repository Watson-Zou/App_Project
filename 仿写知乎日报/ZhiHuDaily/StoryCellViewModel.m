//
//  StoryCellViewModel.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/2/20.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "StoryCellViewModel.h"
#import "StoryModel.h"

static const CGFloat kMainTableViewRowHeight = 95.f;
static const CGFloat kSpacing = 18.f;
static const CGFloat kNormalImageW = 75.f;
static const CGFloat kNormalImageH = 75.f;


@implementation StoryCellViewModel {
    CGRect imageViewFrame;
    CGRect titleLabFrame;
    StoryModel *story;
    NSAttributedString *title;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        story = [[StoryModel alloc] initWithDictionary:dic error:nil];
        _storyID = story.storyID;
        imageViewFrame = story.images.count>0?CGRectMake(kScreenWidth-kNormalImageW-kSpacing, 10.f, kNormalImageH, kNormalImageW):CGRectZero;
        title =[[NSAttributedString alloc] initWithString:story.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
        CGFloat width = story.images.count>0?(kScreenWidth - kSpacing*3 - kNormalImageW):(kScreenWidth - kSpacing*2);
        CGFloat height = [title boundingRectWithSize:CGSizeMake(width, kMainTableViewRowHeight - kSpacing*2) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        titleLabFrame = CGRectMake(kSpacing, kSpacing, width, height);
    }
    return self;
}

- (UIImage *)preImage {
    
    if (!_preImage) {
        UIImage *image = [UIImage imageNamed:@"Image_Preview"];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kMainTableViewRowHeight), NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddRect(context, CGRectMake(kSpacing, kSpacing, kScreenWidth-kSpacing*2, kMainTableViewRowHeight-kSpacing*2));
        CGContextClip(context);
        if (story.images.count>0) {
            [image drawInRect:imageViewFrame];
        }
        [title drawInRect:titleLabFrame];
        _preImage  = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return _preImage;
}

- (void)dowmloadImage {
    if (!_displayImage) {
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.images[0]]]];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kMainTableViewRowHeight), NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddRect(context, CGRectMake(kSpacing, kSpacing, kScreenWidth-kSpacing*2, kMainTableViewRowHeight-kSpacing*2));
        CGContextClip(context);
        [image drawInRect:imageViewFrame];
        [title drawInRect:titleLabFrame];
        if (story.multipic) {
            UIImage *warnImage = [UIImage imageNamed:@"Home_Morepic"];
            [warnImage drawInRect:CGRectMake(kScreenWidth-warnImage.size.width-kSpacing, kMainTableViewRowHeight-kSpacing-warnImage.size.height, warnImage.size.width, warnImage.size.height)];
        }
        _displayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}


- (void)relesaeInvalidObjects {
    _preImage = nil;
    story = nil;
}

@end
