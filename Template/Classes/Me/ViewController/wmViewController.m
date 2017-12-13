//
//  wmViewController.m
//  Template
//
//  Created by 森度 on 2017/8/29.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "wmViewController.h"
@interface wmViewController ()
@end

@implementation wmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //title = @[@"二狗",@"三巡",@"四杀"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titleA[index];
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleA.count;
}
//导航栏上的按钮对应的界面
-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    ZLog(@"%ld",(long)index);

    UIViewController *vc=[[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.9];
    if (index == 0 ) {
        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 80, 30)];
        field.placeholder = @"**********";
        field.tag = 10;
        field.backgroundColor = [UIColor whiteColor];
        [vc.view addSubview:field];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 60, 60)];
        [button setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
       // button.backgroundColor = [UIColor lightTextColor];
        [button setTitle:@"按 钮" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chuanzhi:) forControlEvents:UIControlEventTouchUpInside];
        [vc.view addSubview:button];
        [button setImagePositionWithType:SSImagePositionTypeTop spacing:8];
    }
    return vc;
}

-(void)chuanzhi:(UIButton *)sender{
    UITextField * f = (UITextField *)[sender.superview viewWithTag:10];
    ZLog(@"%@",f.text);
    if ([self.delegates respondsToSelector:@selector(chuangzhi:)]) {
        [self.delegates chuangzhi:f.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//画导航上的文字frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
   // CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, 0, self.view.frame.size.width - 2*leftMargin, 44);
}
//画导航下面的frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {

    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
   
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}
//
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
//    return width + 60;
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
