//
//  Z_BaseTabBarController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_BaseTabBarController.h"
#import "Z_FindViewController.h"
#import "Z_HomeViewController.h"
#import "Z_CardViewController.h"
#import "Z_MeViewController.h"
#import "Z_BaseNavigationController.h"
#import "Z_BaseTabBar.h"
#import "Z_CenterViewController.h"
#import "UITabBar+TBBadge.h"
#import "HWScanViewController.h"
@interface Z_BaseTabBarController ()<ZBarReaderDelegate,QRCodeReaderDelegate>

@end

@implementation Z_BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化所有控制器
    [self setUpChildVC];
    //初始化中间的button
    [self setUpMidelTabbarItem];
}

#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
    Z_BaseTabBar *tabBar = [[Z_BaseTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    //方法1
  /*  ZBarReaderViewController * reader = [ZBarReaderViewController new];//初始化相机控制器
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;//基本适配
    reader.showsHelpOnFail = YES;
    reader.scanCrop = CGRectMake(0, 0, 1, 1);
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:2 config:0 to:0];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    reader.cameraOverlayView = view;*/
    //方法二
//    NSArray *types = @[AVMetadataObjectTypeQRCode];
//    QRCodeReaderViewController* reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
//    
//    // Set the presentation style
//    reader.modalPresentationStyle = UIModalPresentationFormSheet;
//    
//    // Using delegate methods
//    reader.delegate = self;

    __weak typeof(self) weakSelf = self;
   /// [tabBar setDidClickCenterBtn:^{
    ///    Z_CenterViewController *center = [[Z_CenterViewController alloc] init];//1
    ///   Z_BaseNavigationController *nav = [[Z_BaseNavigationController alloc] initWithRootViewController:/*reader*/center];
         // center.navigationItem.title = @"扫一扫";
//        reader.navigationItem.title = @"扫一扫";
      //  nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     ///   [weakSelf presentViewController:nav animated:YES completion:nil];
    ///}];
    
    tabBar.block  = ^{
        ZLog(@"点击中间按钮");
        HWScanViewController *vc = [[HWScanViewController alloc] init];
        Z_BaseNavigationController *nav = [[Z_BaseNavigationController alloc] initWithRootViewController:vc];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    };
}

//方法一的
#pragma mark -代理事件
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"消息" message:symbol.data delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
}
//方法二
#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        ZLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    Z_HomeViewController *homeVC = [[Z_HomeViewController alloc] init];
    //  homeVC.tabBarItem.badgeValue = @"1111";
    [self setChildVC:homeVC title:@"首页" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select"];
    
    Z_FindViewController *fishpidVC = [[Z_FindViewController alloc] init];
    [self setChildVC:fishpidVC title:@"发现" image:@"tabbar_find_normal" selectedImage:@"tabbar_find_select"];
    
    Z_CardViewController *messageVC = [[Z_CardViewController alloc] init];
    [self setChildVC:messageVC title:@"卡券" image:@"tabbar_voucher_normal" selectedImage:@"tabbar_voucher_select"];
    
    Z_MeViewController *myVC = [[Z_MeViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select"];
    
}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Z_BaseNavigationController *nav = [[Z_BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    ZLog(@"item name = %@", item.title);
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    if([item.title isEqualToString:@"发现"])
    {
        
       // [tabBar showBadgeOnItemIndex:index];//小红点
        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
    }
}
//动态图
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
