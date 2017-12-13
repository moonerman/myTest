//
//  AppDelegate.h
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSTimer *countDownTimer;//启动页倒计时
@property (nonatomic, strong) UIButton *startupButton;//启动跳过按钮
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, assign) NSInteger countDownNumber;//记时
@property (nonatomic, unsafe_unretained)BOOL isFirstStart;

- (void)saveContext;


@end

