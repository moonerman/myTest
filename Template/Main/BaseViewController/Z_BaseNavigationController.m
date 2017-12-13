//
//  Z_BaseNavigationController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_BaseNavigationController.h"

@interface Z_BaseNavigationController ()

@end

@implementation Z_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * dic=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes=dic;

    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        if (iOS7) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios7.png"] forBarMetrics:UIBarMetricsDefault];
        } else {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        }
        
    }
    
    
    
}

//这里可以封装成一个分类
- (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 40, 40);
    button.imageView.contentMode = UIViewContentModeLeft;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断一下页面是否是初始页面，如果不是则显示返回按钮，隐藏下面的uitabbar
    if (self.viewControllers.count > 0) {
        //隐藏uitabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *popToLeftButton = [self barButtonItemWithImage:@"back" highImage:nil target:self action:@selector(popToBack)];
        viewController.navigationItem.leftBarButtonItem = popToLeftButton;
    }
    [super pushViewController:viewController animated:animated];
    
}


- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
