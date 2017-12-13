//
//  Z_MeViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_MeViewController.h"
#import "TBHotViewController.h"
#import "wmViewController.h"
#import "LoginViewController.h"
#import "sys/utsname.h"
@interface Z_MeViewController ()<Z_MeViewDelegate>

@end

@implementation Z_MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(push:)];
    NSDictionary * dic=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:20]};
    [right setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
    
    UITextField *field = [[UITextField alloc] init];
    field.frame = CGRectMake(100, 100, 100, 30);
    field.backgroundColor = [UIColor lightGrayColor];
    field.placeholder = @"*****";
    [self.view addSubview:field];
    // Do any additional setup after loading the view.
    UITextField *field1 = [[UITextField alloc] init];
    field1.frame = CGRectMake(100, 480, 100, 30);
    field1.backgroundColor = [UIColor lightGrayColor];
    field1.placeholder = @"wwww";
    [self.view addSubview:field1];
    
    UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 160, 40)];
    [login setTitle:@"跳转到登录页面" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginpushView) forControlEvents:UIControlEventTouchUpInside];
    login.backgroundColor = [UIColor redColor];
    [self.view addSubview:login];
    
    UICountingLabel *myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(login.frame)+90, 350, 45)];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont fontWithName:@"Avenir Next" size:40];
    myLabel.textColor = [UIColor colorWithRed:236/255.0 green:66/255.0 blue:43/255.0 alpha:1];
    [self.view addSubview:myLabel];
    //设置格式
    myLabel.format = @"%.2f";
    //设置变化范围及动画时间
    [myLabel countFrom:0.00
                         to:310098.29
               withDuration:2.0f];
  
    
    UICountingLabel *myLabel1 = [[UICountingLabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(myLabel.frame)+100, 350, 45)];
    myLabel1.textAlignment = NSTextAlignmentCenter;
    myLabel1.font = [UIFont fontWithName:@"Avenir Next" size:30];
    myLabel1.textColor = [UIColor colorWithRed:236/255.0 green:66/255.0 blue:43/255.0 alpha:1];
    [self.view addSubview:myLabel1];
    myLabel1.method = UILabelCountingMethodLinear;
    //设置格式
    myLabel1.format = @"%.2f";
    //设置分隔符样式
    myLabel1.positiveFormat = @"###,##0.00";
   
    //设置变化范围及动画时间
    [myLabel1 countFromCurrentValueTo:23244231.64
               withDuration:1.0f];
    
    
    
    UICountingLabel* scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 400, 300, 40)];
    [self.view addSubview:scoreLabel];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    scoreLabel.format = @"%.2f";
    scoreLabel.formatBlock = ^NSString* (CGFloat value)
    {
    //    NSString* formatted = [NSString stringWithFormat:@"%f",value];
        NSString* f = [formatter stringFromNumber:@(value)];
        ZLog(@"%@",f);
        return [NSString stringWithFormat:@"Score: %@",f];
    };
    scoreLabel.method = UILabelCountingMethodEaseOut;
    [scoreLabel countFrom:0 to:1087644098.99 withDuration:2.5];
    
    
    /*
     * 一次性获取当前网络状态
     这里延时0.1s再执行是因为程序刚刚启动,可能相关的网络服务还没有初始化完成(也有可能是AFN的BUG),
     导致此demo检测的网络状态不正确,这仅仅只是为了演示demo的功能性, 在实际使用中可直接使用一次性网络判断,不用延时
     */
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ZLog(@"111");
    });
    */
    [self performSelector:@selector(lateAction) withObject:nil afterDelay:2/*时间*/];
    //执行结果：11，44
 /*   dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"11"); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"22"); // 任务2
        });
        NSLog(@"33"); // 任务3
    });*/
    //自定义私有串行队列
    dispatch_queue_t queue=dispatch_queue_create("com.privateQueue", NULL);
    
    //异步任务1加入队列中
    dispatch_async(queue, ^{
        NSLog(@"私有队列任务1");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"私有队列任务1_i:%ld",i);
        }
    });
    //异步任务2加入队列中
    dispatch_async(queue, ^{
        NSLog(@"私有队列任务2");
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"私有队列任务2_i:%ld",i);
        }

    });

   // [self performSelectorOnMainThread:@selector(labelWillDisappeared:) withObject:scoreLabel waitUntilDone:NO];

  

}

-(void)labelWillDisappeared:(UILabel *)label
{
    [self performSelector:@selector(labelDidDisappeared:) withObject:label afterDelay:2];
}

-(void)labelDidDisappeared:(UILabel *)label
{
    ZLog(@"%@",label.text);
}

-(void)lateAction{
    ZLog(@"2s后");
    //手机序列号
    NSUUID* identifierNumber = [[UIDevice currentDevice] identifierForVendor];
    NSLog(@"手机序列号: %@",identifierNumber);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);

    ZLog(@"%@",[self getDeviceName]);
}


- (NSString *)balanceFormatFromStr:(NSString*)string
{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumberFormatter *numFormatter2 = [[NSNumberFormatter alloc] init];
    [numFormatter2 setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *num = [numFormatter2 numberFromString:string];
    NSString *tempStr = [numFormatter stringFromNumber:num];
    NSString *balanceStr = [tempStr substringFromIndex:1];
    if ([tempStr hasPrefix:@"-"]) {
        balanceStr = [NSString stringWithFormat:@"-%@",[tempStr substringFromIndex:2]];
    }
    return balanceStr;
    
}

- (NSString *)getDeviceName
    
    {
        
        struct utsname systemInfo;
        
        uname(&systemInfo);
        
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        if ([deviceString isEqualToString:@"iPhone3,1"])return @"iPhone 4";
        
        if ([deviceString isEqualToString:@"iPhone3,2"])return @"iPhone 4";
        
        if ([deviceString isEqualToString:@"iPhone3,3"])return @"iPhone 4";
        
        if ([deviceString isEqualToString:@"iPhone4,1"])return @"iPhone 4S";
        
        if ([deviceString isEqualToString:@"iPhone5,1"])return @"iPhone 5";
        
        if ([deviceString isEqualToString:@"iPhone5,2"])return @"iPhone 5 (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPhone5,3"])return @"iPhone 5c (GSM)";
        
        if ([deviceString isEqualToString:@"iPhone5,4"])return @"iPhone 5c (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPhone6,1"])return @"iPhone 5s (GSM)";
        
        if ([deviceString isEqualToString:@"iPhone6,2"])return @"iPhone 5s (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPhone7,1"])return @"iPhone 6 Plus";
        
        if ([deviceString isEqualToString:@"iPhone7,2"])return @"iPhone 6";
        
        if ([deviceString isEqualToString:@"iPhone8,1"])return @"iPhone 6s";
        
        if ([deviceString isEqualToString:@"iPhone8,2"])return @"iPhone 6s Plus";
        
        if ([deviceString isEqualToString:@"iPhone8,4"])return @"iPhone SE";
        
        // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
        
        if ([deviceString isEqualToString:@"iPhone9,1"])return @"国行、日版、港行iPhone 7";
        
        if ([deviceString isEqualToString:@"iPhone9,2"])return @"港行、国行iPhone 7 Plus";
        
        if ([deviceString isEqualToString:@"iPhone9,3"])return @"美版、台版iPhone 7";
        
        if ([deviceString isEqualToString:@"iPhone9,4"])return @"美版、台版iPhone 7 Plus";
        
        if ([deviceString isEqualToString:@"iPhone10,1"])return @"iPhone 8";
        
        if ([deviceString isEqualToString:@"iPhone10,4"])return @"iPhone 8";
        
        if ([deviceString isEqualToString:@"iPhone10,2"])return @"iPhone 8 Plus";
        
        if ([deviceString isEqualToString:@"iPhone10,5"])return @"iPhone 8 Plus";
        
        if ([deviceString isEqualToString:@"iPhone10,3"])return @"iPhone X";
        
        if ([deviceString isEqualToString:@"iPhone10,6"])return @"iPhone X";
        
        if ([deviceString isEqualToString:@"iPod1,1"])return @"iPod Touch 1G";
        
        if ([deviceString isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
        
        if ([deviceString isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
        
        if ([deviceString isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
        
        if ([deviceString isEqualToString:@"iPod5,1"])return @"iPod Touch (5 Gen)";
        
        if ([deviceString isEqualToString:@"iPad1,1"])return @"iPad";
        
        if ([deviceString isEqualToString:@"iPad1,2"])return @"iPad 3G";
        
        if ([deviceString isEqualToString:@"iPad2,1"])return @"iPad 2 (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad2,2"])return @"iPad 2";
        
        if ([deviceString isEqualToString:@"iPad2,3"])return @"iPad 2 (CDMA)";
        
        if ([deviceString isEqualToString:@"iPad2,4"])return @"iPad 2";
        
        if ([deviceString isEqualToString:@"iPad2,5"])return @"iPad Mini (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad2,6"])return @"iPad Mini";
        
        if ([deviceString isEqualToString:@"iPad2,7"])return @"iPad Mini (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPad3,1"])return @"iPad 3 (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad3,2"])return @"iPad 3 (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPad3,3"])return @"iPad 3";
        
        if ([deviceString isEqualToString:@"iPad3,4"])return @"iPad 4 (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad3,5"])return @"iPad 4";
        
        if ([deviceString isEqualToString:@"iPad3,6"])return @"iPad 4 (GSM+CDMA)";
        
        if ([deviceString isEqualToString:@"iPad4,1"])return @"iPad Air (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad4,2"])return @"iPad Air (Cellular)";
        
        if ([deviceString isEqualToString:@"iPad4,4"])return @"iPad Mini 2 (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad4,5"])return @"iPad Mini 2 (Cellular)";
        
        if ([deviceString isEqualToString:@"iPad4,6"])return @"iPad Mini 2";
        
        if ([deviceString isEqualToString:@"iPad4,7"])return @"iPad Mini 3";
        
        if ([deviceString isEqualToString:@"iPad4,8"])return @"iPad Mini 3";
        
        if ([deviceString isEqualToString:@"iPad4,9"])return @"iPad Mini 3";
        
        if ([deviceString isEqualToString:@"iPad5,1"])return @"iPad Mini 4 (WiFi)";
        
        if ([deviceString isEqualToString:@"iPad5,2"])return @"iPad Mini 4 (LTE)";
        
        if ([deviceString isEqualToString:@"iPad5,3"])return @"iPad Air 2";
        
        if ([deviceString isEqualToString:@"iPad5,4"])return @"iPad Air 2";
        
        if ([deviceString isEqualToString:@"iPad6,3"])return @"iPad Pro 9.7";
        
        if ([deviceString isEqualToString:@"iPad6,4"])return @"iPad Pro 9.7";
        
        if ([deviceString isEqualToString:@"iPad6,7"])return @"iPad Pro 12.9";
        
        if ([deviceString isEqualToString:@"iPad6,8"])return @"iPad Pro 12.9";
        
        if ([deviceString isEqualToString:@"i386"])return @"Simulator";
        
        if ([deviceString isEqualToString:@"x86_64"])return @"Simulator";
        
        return deviceString;
        
    }
    
-(void)loginpushView{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)push:(UIBarButtonItem *)sender{
    //配置一：基础配置
    [KxMenu setTitleFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
    Color color1 = {
        0,
        0,
        0
    };
    Color color2 = {
        1,
        1,
        1
    };
    //配置二：拓展配置
    OptionalConfiguration options = {/*arrowSize:*/ 9,  //指示箭头大小
                               /* marginXSpacing: */7,  //MenuItem左右边距
                               /* marginYSpacing:*/ 9,  //MenuItem上下边距
                               /*intervalSpacing:*/ 25,  //MenuItemImage与MenuItemTitle的间距
                               /* menuCornerRadius:*/ 6.5,  //菜单圆角半径
                               /* maskToBackground: */true,  //是否添加覆盖在原View上的半透明遮罩
                               /* shadowOfMenu: */false,  //是否添加菜单阴影
                               /* hasSeperatorLine:*/ true,  //是否设置分割线
                               /* seperatorLineHasInsets:*/ false,  //是否在分割线两侧留下Insets
                               /*textColor:*/color1 , //menuItem字体颜色
                              /*  menuBackgroundColor:*/ color2  //菜单的底色
    };
    NSArray *menuItems = @[
      
//      [KxMenuItem menuItem:@"ACTION "
//                     image:nil
//                    target:nil
//                    action:NULL],
      [KxMenuItem menuItem:@"Share this"
                     image:[UIImage imageNamed:@"action_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      [KxMenuItem menuItem:@"Check menu"
                     image:[UIImage imageNamed:@"check_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      [KxMenuItem menuItem:@"Reload page"
                     image:[UIImage imageNamed:@"reload"]
                    target:self
                    action:@selector(pushMenuItem:)],
      [KxMenuItem menuItem:@"Search"
                     image:[UIImage imageNamed:@"search_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      [KxMenuItem menuItem:@"Go home"
                     image:[UIImage imageNamed:@"home_icon"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
     [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(SCREEN_WIDTH-40, 0, 0, 0)
                 menuItems:menuItems withOptions:options];
    
}

- (void) pushMenuItem:(KxMenuItem *)sender
{
   // ZLog(@"%@", sender.title);
    if ([sender.title isEqualToString:@"Share this"]) {
        TBHotViewController *vc = [[TBHotViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([sender.title isEqualToString:@"Check menu"]){
         wmViewController *vc = [[wmViewController alloc] init];
        vc.menuViewStyle = WMMenuViewStyleLine;
        //标题未点击的颜色
        vc.titleColorNormal = [UIColor lightGrayColor];
        //点击后的颜色
        vc.titleColorSelected = [UIColor redColor];
        //标题的宽度
        vc.menuItemWidth = SCREEN_WIDTH/4;
        vc.titleA = @[@"一逼",@"二狗",@"三巡",@"四杀",@"五滚"];
        //页面的导航栏标题
        vc.title = @"导航切换界面";
        vc.delegates = self;
        [self.navigationController pushViewController:vc animated:YES];

    }
}

-(void)chuangzhi:(NSString *)text{
    ZLog(@"%@",text);
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
