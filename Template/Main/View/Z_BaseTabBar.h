//
//  Z_BaseTabBar.h
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didClickCenterBtn)();
@interface Z_BaseTabBar : UITabBar

//@property(nonatomic, copy)void(^didClickCenterBtn)();///1
@property(nonatomic, copy)didClickCenterBtn block;
@end
