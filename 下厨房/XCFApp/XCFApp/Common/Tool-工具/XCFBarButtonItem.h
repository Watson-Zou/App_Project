//
//  XCFBarButtonItem.h
//  XCFApp
//
//  Created by rkxt_ios on 15/12/1.
//  Copyright © 2015年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFBarButtonItem : UIBarButtonItem
+ (XCFBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName
                                          target:(id)target
                                          action:(SEL)action;

+ (XCFBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                      target:(id)target
                                      action:(SEL)action;
@end
