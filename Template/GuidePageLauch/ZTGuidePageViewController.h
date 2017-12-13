//
//  ZTGuidePageViewController.h
//  AppleMobileBusinessHall
//
//  Created by 赵方正 on 16/12/14.
//  Copyright (c) 2016年 网达. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger const ImageCount;

typedef void(^ZTGuidePageViewControllerBlock)();

@interface ZTGuidePageViewController : UIViewController

@property (nonatomic, copy) ZTGuidePageViewControllerBlock block;

@end
