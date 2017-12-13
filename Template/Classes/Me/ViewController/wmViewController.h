//
//  wmViewController.h
//  Template
//
//  Created by 森度 on 2017/8/29.
//  Copyright © 2017年 森度. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@protocol Z_MeViewDelegate <NSObject>
-(void)chuangzhi:(NSString *)text;
@end

@interface wmViewController : WMPageController

@property(nonatomic,weak)id<Z_MeViewDelegate> delegates;
@property(nonatomic, strong)NSArray *titleA;

@end


