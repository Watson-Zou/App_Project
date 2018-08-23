//
//  RecommenderView.m
//  ZhiHuDaily
//
//  Created by 洪鹏宇 on 16/3/8.
//  Copyright © 2016年 洪鹏宇. All rights reserved.
//

#import "RecommenderView.h"

@implementation RecommenderView

- (void)setContentWithCommanders:(NSArray *)commanders {

    if (commanders.count>0) {
        UIImage *image;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.width, self.height), NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"推荐者" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor grayColor]}];
        CGSize strSize =[str boundingRectWithSize:CGSizeMake(100, 44) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        CGFloat strW = strSize.width;
        CGFloat strH = strSize.height;
        CGRect strFrame = CGRectMake(0, (self.height-strH)/2, strW, strH);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:strFrame];
        for (int i = 0 ; i<commanders.count; i++) {
            [path moveToPoint:CGPointMake(strW+24+40*i, self.height/2)];
            [path addArcWithCenter:CGPointMake(strW+24+40*i, self.height/2) radius:16 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        }
        [path closePath];
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        [str drawInRect:CGRectMake(0, (self.height-strH)/2, strW, strH)];
        for (int i = 0 ; i<commanders.count; i++) {
            NSDictionary *dic = commanders[i];
            NSURL *imaURL = [NSURL URLWithString:dic[@"avatar"]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imaURL]];
            [image drawInRect:CGRectMake(strW+8+40*i, (self.height-32)/2, 32, 32)];
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.layer.contents = (__bridge id _Nullable)(image.CGImage);
    }
}

@end
