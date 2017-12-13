//
//  AppDelegate+Launch.m
//  Template
//
//  Created by 森度 on 2017/8/31.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "AppDelegate+Launch.h"
#import "Z_BaseTabBarController.h"
#import "ZTGuidePageViewController.h"

@implementation AppDelegate (Launch)

- (void)initGuideLaunchView
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([self isFirstLauch]) {
        //显示引导页
       [self initGuidePage];
    }else{
        //[self enterHomePage];
        //显示启动页
        [self initLaunchView];
        //异步请求广告
        
    }
}

//判断是否为第一次启动
- (BOOL)isFirstLauch
{
    // 判断是否第一次使用这个版本
    NSString *key =   @"CFBundleShortVersionString";
    // 先去沙盒中取出上次使用的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 加载程序中info.plist文件(获得当前软件的版本号)
    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDictionary[key];
    if (lastVersion == nil || ![lastVersion isEqualToString:currentVersion]) {
        //保存版本
        [self saveAppVersion];
        return YES;
    }else{
        return NO;
    }
}

//保存版本
- (void)saveAppVersion
{
    NSString *key =   @"CFBundleShortVersionString";

    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDictionary[key];
    //保存当前版本号
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - 启动页
#pragma mark 初始化启动页
- (void)initLaunchView
{
    UIView *launchView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    launchView.backgroundColor = [UIColor whiteColor];
    [self.window.rootViewController.view addSubview:launchView];
    //广告页
    UIImageView *picView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    picView.tag = 10;
    picView.userInteractionEnabled = YES;
    [launchView addSubview:picView];
    //广告的点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [picView addGestureRecognizer:tap];
    // 跳过按钮
    UIButton *button = UIButton.new;
    [launchView addSubview:button];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 * WidthPersent - 15 * WidthPersent, 20 * HeightPersent, 40 * WidthPersent, 40 * WidthPersent);
    [button setBackgroundImage:[UIImage imageNamed:@"tgan"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10.0 * WidthPersent];
    button.titleLabel.numberOfLines = 0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    self.startupButton = button;
    self.startupButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //从本地取出广告数据
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[self getLauchFilePath]];
    if (!dic || dic.count <1) {//本地无数据
        [picView setImage:[UIImage imageNamed:@"欢迎页1"]];
    }
//    else{//数据过时
//        if (![self advertisementIsStartOrOverWithParameter:dic]) {//广告过时
//            [picView setImage:[UIImage imageNamed:@"Start_Life.jpg"]];
//        }else{
//            NSString *displayTime = dic[@"disPlayTime"];//倒数时间
//            self.countDownNumber = [displayTime integerValue];
//            NSString *images = dic[@"images"];
//            [picView sd_setImageWithURL:[NSURL URLWithString:images]];
//        }
//    }
//    
    if (!self.countDownNumber || self.countDownNumber == 0) {
        self.countDownNumber = 3;
    }
    [self.startupButton setTitle:[NSString stringWithFormat:@"%ld\n跳过", (long)self.countDownNumber] forState:UIControlStateNormal];
    // 开始倒计时
    if (!self.countDownTimer) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
}

-(void)tapAction:(UITapGestureRecognizer *)sender{
    ZLog(@"点击图片");
}

- (void)initGuidePage
{
    // 显示引导页
    ZTGuidePageViewController *guidePageViewController = [[ZTGuidePageViewController alloc] init];
    __unsafe_unretained AppDelegate *selfV = self;
    guidePageViewController.block = ^{
        // 进入首页
        [selfV enterHomePage];
    };
    self.window.rootViewController = guidePageViewController;
}

//获取路径
- (NSString *)getLauchFilePath
{
    NSString *path = @"lauchFile";
    return path;
}
#pragma mark 跳过启动广告页
- (void)skipAction:(UIButton *)button
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    [self enterHomePage];
}
#pragma mark 倒计时
- (void)countDown:(id)sender
{
    self.countDownNumber --;
    [self.startupButton setTitle:[NSString stringWithFormat:@"%ld\n跳过", (long)self.countDownNumber] forState:UIControlStateNormal];
    if (self.countDownNumber <= 0) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        [self enterHomePage];
    }
}

//进入首页
- (void)enterHomePage
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    self.isFirstStart = NO;
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[Z_BaseTabBarController alloc] init]];
    [navVC setNavigationBarHidden:YES];
    self.window.rootViewController = navVC;
}

@end
