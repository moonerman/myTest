//
//  Z_HomeViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_HomeViewController.h"

@interface Z_HomeViewController ()<PNChartDelegate>

@end

@implementation Z_HomeViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"首页";
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    [rightBtn setTitle:@"夜间" forState:UIControlStateNormal];
//    [rightBtn setTitle:@"白天" forState:UIControlStateSelected];
//    [rightBtn addTarget:self action:@selector(qiehuanLight:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = right;

    [super viewDidLoad];
    [self yuanhuan];
    [self shuzhuangtu];
    //[self zhexiantu];
    [self bingxing];
    // Do any additional setup after loading the view.
}

-(void)qiehuanLight:(UIButton *)sender{
    sender.selected = !sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DayOrNight" object:nil];
}
-(void)yuanhuan{
    //1.PNCircleChart圆环=================================
    
    //初始化圆环PNCircleChart最后一个初始化方法功能比较齐全
    
    //total总圆100单位
    
    //current占总圆的80单位
    
    //clockwise顺时针方向YES
    
    //shadow有阴影YES
    
    //shadowColor阴影颜色greenColor
    
    //displayCountingLabel是否显示计数标签YES
    
    //overrideLineWidth圆环的宽20像素
    
    PNCircleChart * circleChart = [[PNCircleChart alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 200) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:80] clockwise:YES shadow:NO shadowColor:[UIColor greenColor] displayCountingLabel:YES overrideLineWidth:[NSNumber numberWithInt:20]];
    
    //设置颜色
    
    [circleChart setStrokeColorGradientStart:[UIColor redColor]];
    
    //开始画圆
    
    [circleChart strokeChart];
    
    //背景颜色
    
   // circleChart.backgroundColor = [UIColor whiteColor];
    
    //Add
    
    [self.view addSubview:circleChart];
    
}
-(void)zhexiantu{
    //2.PNLineChart折线图=================================
    
    PNLineChart *lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    //设置背景颜色
    
   // lineChart.backgroundColor = [UIColor whiteColor];
    
    //设置坐标轴是否可见
    
    lineChart.showCoordinateAxis = YES;
    
    //设置是否显示网格线
    
    lineChart.showYGridLines = YES;
    
    //设置网格线颜色
    
    lineChart.yGridLinesColor = [UIColor grayColor];
    
    //设置X轴标签
    
    lineChart.xLabels = @[@"魅族",@"华为",@"中兴",@"小米",@"苹果",@"一加",@"乐视"];
    
    //设置坐标轴颜色
    
    lineChart.axisColor = [UIColor blueColor];
    
    //设置坐标轴宽度
    
    lineChart.axisWidth = 2.0;
    
    //Add
    
    [self.view addSubview:lineChart];
    
    //曲线数据1
    
    PNLineChartData *data1 = [[PNLineChartData alloc]init];
    
    //曲线颜色
    
    data1.color = PNRed;
    
    //曲线格式
    
    data1.inflexionPointStyle = PNLineChartPointStyleCircle;
    
    //设置数据（Y轴坐标根据数据的大小自动适应）
    
    NSArray *dataArray1 = @[@4,@8,@7,@4,@19,@6,@5];
    
    data1.itemCount = dataArray1.count;
    
    data1.getData = ^(NSUInteger index){
        
        CGFloat yValue = [dataArray1[index] floatValue];
        return [ PNLineChartDataItem dataItemWithY:yValue];
        
    };
    
    //曲线数据2
    
    PNLineChartData *data2 = [[PNLineChartData alloc]init];
    
    //曲线颜色
    
    data2.color = PNGreen;
    
    //曲线格式
    
    data2.inflexionPointStyle = PNLineChartPointStyleCircle;
    
    //设置数据（Y轴坐标根据数据的大小自动适应）
    
    NSArray *dataArray2 = @[@6,@15,@3,@12,@20,@16,@3];
    
    data2.itemCount = dataArray2.count;
    
    data2.getData = ^(NSUInteger index){
        
        CGFloat yValue = [dataArray2[index] floatValue];
        
        return [ PNLineChartDataItem dataItemWithY:yValue];
        
    };
    
    lineChart.chartData = @[data1,data2];
    
    //开始绘图
    
    [lineChart strokeChart];
    
    //数据标注名称
    
    data1.dataTitle = @"数据1标注名称";
    
    data2.dataTitle = @"数据2标注名称";
    
    //标注摆放样式
    
    lineChart.legendStyle = PNLegendItemStyleSerial;
    
    //标注字体
    
    lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    //标注颜色
    
    lineChart.legendFontColor = [UIColor redColor];
    
    // 标示所在的View
    
    UIView *legend = [lineChart getLegendWithMaxWidth:SCREEN_WIDTH];
    
    [legend setFrame:CGRectMake(0, 205, legend.frame.size.width, 10)];
    
    legend.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:legend];
    
  
}
-(void)shuzhuangtu{
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 200)];
    
    barChart.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    
    //Y坐标label宽度(微调)
    
    barChart.yChartLabelWidth = 20.0;
    
    barChart.chartMarginLeft = 30.0;
    
    barChart.chartMarginRight = 10.0;
    
    barChart.chartMarginTop = 5.0;
    
    barChart.chartMarginBottom = 10.0;
    
    //X坐标刻度的上边距
    
    barChart.labelMarginTop = 2.0;
    
    //是否显示坐标轴
    
    barChart.showChartBorder = YES;
    
    [barChart setXLabels:@[@"魅族",@"华为",@"中兴",@"小米",@"苹果",@"乐视"]];
    
    [barChart setYValues:@[@20,@8,@5,@33,@16,@8]];
    
    //每个柱子的颜色
    
    [barChart setStrokeColors:@[PNGreen,PNRed,PNRed,PNRed,PNRed,PNRed]];
    
    //    barChart.strokeColor = [UIColor redColor];
    
    //是否立体效果
    
    barChart.isGradientShow = YES;
    
    //显示各条状图的数值
    
    barChart.isShowNumbers = YES;
    
    //开始绘图
    
    [barChart strokeChart];
    
    barChart.delegate = self;
    
    //Add
    
    [self.view addSubview:barChart];
    

}

-(void)bingxing{
    //4.PNPieChart圆饼图=================================
    
    //圆饼数据
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:30 color:PNRed],
                       
                       [PNPieChartDataItem dataItemWithValue:10 color:PNFreshGreen description:@"绿色"],
                       
                       [PNPieChartDataItem dataItemWithValue:60 color:PNBlue description:@"蓝色"],
                       
                       ];
    
    //PNPieChart初始化
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2 - 100, 430, 200, 200) items:items];
    
  //  pieChart.backgroundColor = [UIColor whiteColor];
    
    //扇形上字体颜色
    
    pieChart.descriptionTextColor = [UIColor whiteColor];
    
    pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    
    // 阴影颜色
    
    pieChart.descriptionTextShadowColor = [UIColor yellowColor];
    
    //显示实际数值(不显示比例数字)
    
    pieChart.showAbsoluteValues = YES;
    
    // 只显示数值不显示内容描述
    
    pieChart.showOnlyValues = NO;
    
    //开始绘图
    
    [pieChart strokeChart];
    
    //Add
    
    [self.view addSubview:pieChart];
    
    // 标注排放样式
    
    pieChart.legendStyle = PNLegendItemStyleStacked;
    
    pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [pieChart getLegendWithMaxWidth:200];
    
    [legend setFrame:CGRectMake(50, 440, legend.frame.size.width, 10)];
    
    [self.view addSubview:legend];
    
}
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex {
    ZLog(@"Click on line %f, %f, line index is %d", point.x, point.y, (int) lineIndex);
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
