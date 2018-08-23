//
//  ManongContent.h
//  manongweekly
//
//  Created by xiangwenwen on 15/6/5.
//  Copyright (c) 2015年 xiangwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ManongTitle;

@interface ManongContent : NSManagedObject

@property (nonatomic, retain) NSString * wkContrsationKey;
@property (nonatomic, retain) NSNumber * wkCount;
@property (nonatomic, retain) NSString * wkName;
@property (nonatomic, retain) NSString * wkOriginContent;
@property (nonatomic, retain) NSString * wkOriginUrl;
@property (nonatomic, retain) NSNumber * wkStatus;
@property (nonatomic, retain) NSString * wkStringTime;
@property (nonatomic, retain) NSDate * wkTime;
@property (nonatomic, retain) NSString * wkUrl;
@property (nonatomic, retain) ManongTitle *mnwwTitle;

@end
