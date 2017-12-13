//
//  Z_CenterViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_CenterViewController.h"

@interface Z_CenterViewController ()<ZBarReaderViewDelegate>

@property (nonatomic , assign)NSInteger distance;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *line;

@end

@implementation Z_CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationbarBack];

}

#pragma mark -初始化导航栏

- (void)setupNavigationbarBack {
    
    self.navigationItem.title = @"扫一扫";
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, 12, 21);
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftButtonItem];
    

    [self buildOverlayView];
}

- (void)buildOverlayView
{
    
    ZBarReaderView *readerView = [ZBarReaderView new];
    ZBarImageScanner *scanner = readerView.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    readerView.frame=CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGRect scanMaskRect = CGRectMake((SCREEN_WIDTH*0.35) * 0.5, (SCREEN_HEIGHT*0.35-30) * 0.5, SCREEN_WIDTH * 0.65, SCREEN_WIDTH * 0.65);
    readerView.torchMode = NO;
    readerView.tracksSymbols = NO;
    readerView.trackingColor = [UIColor clearColor];
    readerView.readerDelegate = self;
    [self.view addSubview:readerView];
    // readerView.backgroundColor = [UIColor redColor];
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    readerView.scanCrop =  [self getScanCrop:scanMaskRect readerViewBounds:readerView.bounds];
    [readerView start];
    

   
    
    CGFloat scanW = SCREEN_WIDTH * 0.65;
    CGFloat padding = 10.0f;
    CGFloat labelH = 20.0f;
    CGFloat tabBarH = 64.0f;
    CGFloat cornerW = 26.0f;
    CGFloat marginX = (SCREEN_WIDTH - scanW) * 0.5;
    CGFloat marginY = (SCREEN_HEIGHT - scanW - padding - labelH) * 0.5;
    
    //遮盖视图
    for (int i = 0; i < 4; i++) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, (marginY + scanW) * i, SCREEN_WIDTH, marginY + (padding + labelH) * i)];
        if (i == 2 || i == 3) {
            cover.frame = CGRectMake((marginX + scanW) * (i - 2), marginY, marginX, scanW);
        }
        cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [self.view addSubview:cover];
    }
    
    CGRect bounds = self.view.bounds;
    bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    
   // UIView* overlayView = [[UIView alloc] initWithFrame:bounds];
    readerView.autoresizesSubviews = YES;
    readerView.autoresizingMask    = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    readerView.opaque              = NO;
    
    
 
    
    //扫描视图
    UIView *scanView = [[UIView alloc] initWithFrame:CGRectMake(marginX, marginY, scanW, scanW)];
    [readerView addSubview:scanView];
    
    //扫描线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanW, 2)];
    [self drawLineForImageView:line];
    [scanView addSubview:line];
    self.line = line;
    
    //边框
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanW, scanW)];
    borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
    borderView.layer.borderWidth = 1.0f;
    [scanView addSubview:borderView];
    
    //扫描视图四个角
    for (int i = 0; i < 4; i++) {
        CGFloat imgViewX = (scanW - cornerW) * (i % 2);
        CGFloat imgViewY = (scanW - cornerW) * (i / 2);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, cornerW, cornerW)];
        if (i == 0 || i == 1) {
            imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI_2 * i);
        }else {
            imgView.transform = CGAffineTransformRotate(imgView.transform, - M_PI_2 * (i - 1));
        }
        [self drawImageForImageView:imgView];
        [scanView addSubview:imgView];
    }
    
    //提示标签
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scanView.frame) + padding, SCREEN_WIDTH, labelH)];
    label.text = @"将二维码/条形码放入框内，即可自动扫描";
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [readerView addSubview:label];
    
    [self addTimer];
}

- (void)addTimer
{
    _distance = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    if (_distance++ > SCREEN_WIDTH * 0.65) _distance = 0;
    _line.frame = CGRectMake(0, _distance, SCREEN_WIDTH * 0.65, 2);
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
//绘制角图片
- (void)drawImageForImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 6.0f);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
    //路径
    CGContextBeginPath(context);
    //设置起点坐标
    CGContextMoveToPoint(context, 0, imageView.bounds.size.height);
    //设置下一个点坐标
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, imageView.bounds.size.width, 0);
    //渲染，连接起点和下一个坐标点
    CGContextStrokePath(context);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

//绘制线图片
- (void)drawLineForImageView:(UIImageView *)imageView
{
    CGSize size = imageView.bounds.size;
    UIGraphicsBeginImageContext(size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建一个颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //设置开始颜色
    const CGFloat *startColorComponents = CGColorGetComponents([[UIColor greenColor] CGColor]);
    //设置结束颜色
    const CGFloat *endColorComponents = CGColorGetComponents([[UIColor whiteColor] CGColor]);
    //颜色分量的强度值数组
    CGFloat components[8] = {startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]
    };
    //渐变系数数组
    CGFloat locations[] = {0.0, 1.0};
    //创建渐变对象
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //绘制渐变
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.25, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.5, kCGGradientDrawsBeforeStartLocation);
    //释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    ZLog(@"%f,%f,%f,%f",x, y, width, height);
    return CGRectMake(x, y, width, height);
}
#pragma mark ZBarReaderViewDelegate
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols) {
        ZLog(@"********%@*********", symbol.data);
        break;
    }
    [readerView stop];
    [self removeTimer];

}
#pragma mark -导航栏返回按钮

- (void)backAction {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
