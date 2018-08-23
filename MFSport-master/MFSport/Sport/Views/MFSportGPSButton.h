//
//  MFSportGPSButton.h
//  MFSport
//
//  Created by 彭作青 on 2016/11/14.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFSportGPSButton : UIButton

@property (nonatomic, assign) BOOL isMapButton;

- (instancetype)initWithImageName:(NSString *)imageName;

@end
