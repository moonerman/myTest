//
//  Z_CardViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_CardViewController.h"


@interface Z_CardViewController ()

@end

@implementation Z_CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 70, 40)];
    btn.backgroundColor = [UIColor blueColor];
    // 按住按钮后没有松手的动画
//    [btn addTarget:self
//                action:@selector(scaleToSmall:)
//      forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
//    
    // 按住按钮松手后的动画
    [btn addTarget:self
                action:@selector(scaleAnimation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

//    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    anBasic.toValue = @0;//位移
//    anBasic.duration = 1;//动画间隔
//    anBasic.beginTime = CACurrentMediaTime() + 1.0f;
//    anBasic.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [btn pop_addAnimation:anBasic forKey:@"position"];
//
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 40, 40)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];

     POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
     anSpring.toValue = [NSValue valueWithCGRect:CGRectMake(100,100,40,40)];
     anSpring.beginTime = CACurrentMediaTime() + 1.0f;
     anSpring.springBounciness = 10.0f;
     [view pop_addAnimation:anSpring forKey:@"position"];
     
    
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 100, 50)];
    [self.view addSubview:lable];
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable = (UILabel*)obj;
            lable.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic1 = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic1.property = prop;    //自定义属性
    anBasic1.fromValue = @(0);   //从0开始
    anBasic1.toValue = @(3*60);  //180秒
    anBasic1.duration = 3*60;    //持续3分钟
    anBasic1.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [lable pop_addAnimation:anBasic1 forKey:@"countdown"];
    
  
    // Do any additional setup after loading the view.
    //有自定义图片和文字
    [MBProgressHUD showImage:@"tabbar_find_select" title:@"努力加载中···" toView:self.view];
    //仅有文字
    //[MBProgressHUD showMessage:@"--------" toView:self.view];
    //提示后1s消失
    //[MBProgressHUD show:@"…………" icon:@"tabbar_find_select" view:self.view];
    //隐藏
    //[MBProgressHUD hideHUDForView:self.view];
    ZLog(@"%d",sumOfNumbers(4,5));
}
int (^sumOfNumbers)(int a, int b) = ^(int a, int b) {
    return a + b;
};

- (void)scaleToSmall:(UIButton *)sender
{
    ZLog(@"scaleToSmall");
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [sender.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation:(UIButton *)sender
{
    ZLog(@"scaleAnimation");
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
   // scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.fromValue =  [NSValue valueWithCGSize:CGSizeMake(0.6f, 0.6f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.2f, 1.2f)];
    scaleAnimation.springBounciness = 10.0f;
    [sender.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
    
    POPBasicAnimation *anim = [POPBasicAnimation  animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    float alpha = sender.alpha;
    if (alpha==1.0) {
        anim.toValue = @(0.2);
    }
    else{
        anim.toValue = @(1.0);
    }
    [sender pop_addAnimation:anim forKey:@"alpha"];

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
