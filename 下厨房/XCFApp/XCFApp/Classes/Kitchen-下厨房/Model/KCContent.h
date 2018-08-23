//
//  KCContent.h
//  travelInter
//
//  Created by rkxt_ios on 15/12/10
//  Copyright (c) leowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KCCursor,KCIssues,KCItems,KCContents,KCImage;

@interface KCContent : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<KCIssues *> *issues;

@property (nonatomic, strong) KCCursor *cursor;

@end