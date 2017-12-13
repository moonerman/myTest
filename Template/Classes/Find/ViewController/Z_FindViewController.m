//
//  Z_FindViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_FindViewController.h"
#import "ShoppingCartTool.h"
NSInteger num = 0;
@interface Z_FindViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic, retain) UISearchController *searchController;

/** 加入购物车按钮 */
@property (nonatomic, strong) UIButton *addButton;
/** 购物车按钮 */
@property (nonatomic, strong) UIButton *shoppingCartButton;
/** 商品数量label */
@property (nonatomic, strong) UILabel *goodsNumLabel;

@end

@implementation Z_FindViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *timeLable = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 200, 40)];
    timeLable.backgroundColor = [UIColor redColor];
    [timeLable addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeLable];
    
    UIButton *localLable = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 200, 40)];
    localLable.backgroundColor = [UIColor redColor];
    [localLable addTarget:self action:@selector(localAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localLable];
    [self CtreatSearch];
    
  /*  UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 300, 50, 50)];
    imageView.image = [UIImage imageNamed:@"tabbar_find_select"];
    [self.view addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 300)]; animation.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 400)];
    animation.duration = 1;
    [imageView.layer addAnimation:animation forKey:@"d"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(-50, 40)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(50, 40)];
    animation1.duration = 10;
    [imageView.layer addAnimation:animation1 forKey:@"d"];*/
    [self setUpUI];
    
}

- (void)setUpUI {
    // 加入购物车按钮
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 300, 120, 50)];
    [self.view addSubview:self.addButton];
    self.addButton.backgroundColor = [UIColor redColor];
    [self.addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 购物车按钮
    self.shoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120 - 50 - 20, SCREEN_HEIGHT - 300, 50, 50)];
    [self.view addSubview:self.shoppingCartButton];
    [self.shoppingCartButton setImage:[UIImage imageNamed:@"tabbar_voucher_normal"] forState:UIControlStateNormal];
    [self.shoppingCartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 商品数量label
    self.goodsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shoppingCartButton.center.x, self.shoppingCartButton.frame.origin.y, 20, 20)];
    [self.view addSubview:self.goodsNumLabel];
    self.goodsNumLabel.backgroundColor = [UIColor redColor];
    self.goodsNumLabel.textColor = [UIColor whiteColor];
    self.goodsNumLabel.textAlignment = NSTextAlignmentCenter;
   // self.goodsNumLabel.font = [UIFont systemFontOfSize:10];
    self.goodsNumLabel.font = [UIFont fontWithName:@"courier" size:11];
    self.goodsNumLabel.layer.cornerRadius = 10;
    self.goodsNumLabel.clipsToBounds = YES;
   // self.goodsNumLabel.text = @"99+";
}


/** 加入购物车按钮点击 */
- (void)addButtonClicked:(UIButton *)sender {
    [ShoppingCartTool addToShoppingCartWithGoodsImage:[UIImage imageNamed:@"tabbar_find_select"] startPoint:self.addButton.center endPoint:self.shoppingCartButton.center completion:^(BOOL finished) {
        ZLog(@"动画结束了");
        num++;
        //------- 颤抖吧 -------//这是goodsNumLabel动的动画
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
        scaleAnimation.duration = 0.1;
        scaleAnimation.repeatCount = 2; // 颤抖两次
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.goodsNumLabel.layer addAnimation:scaleAnimation forKey:nil];
        self.goodsNumLabel.text = [NSString stringWithFormat:@"%ld",(long)num];

    }];
}


-(void)CtreatSearch{
    
    self.definesPresentationContext = YES;

    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置背景
    _searchController.searchBar.translucent = NO;
    _searchController.searchBar.barTintColor = [UIColor lightGrayColor];
    
    //设置边框和背景颜色
    _searchController.searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
   // _searchController.searchBar.layer.borderWidth = 1;
    _searchController.searchBar.placeholder = @"搜索";
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 34);
    _searchController.searchBar.delegate=self;
    _searchController.searchBar.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchController.searchBar;
    self.navigationItem.titleView.center = self.searchController.searchBar.center;
}
//输入好后一次性搜索，点击search按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchText = [searchBar text];
    ZLog(@"--%@--",searchText);
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    ZLog(@"888");
}
//每输入一个字符就调用一次
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = [searchController.searchBar text];
    ZLog(@"%@",searchText);
}
-(void)timeAction:(UIButton *)sender{
   // __weak typeof(self) weakSelf = self;
    /*
     *isAutoSelect:是否随着滚动值而改变
     *
     */
    [BRDatePickerView showDatePickerWithTitle:@"选择时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:nil minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
    }];

   ZLog(@"%@",sender.titleLabel.text/*获取UIbutton上的字体*/);
 
    //选择name
 /*   NSArray *array = [NSArray arrayWithObjects:@"张三",@"李四",@"张三",@"李四",@"张三",@"张三",@"李四",@"张三",@"李四",@"张三", nil];
    [BRStringPickerView showStringPickerWithTitle:@"name"
                                             dataSource:array
                                        defaultSelValue:0
                                           isAutoSelect:NO
                                      resultBlock:^(id selectValue) {
                                          ZLog(@"%@",selectValue);
                                      }];*/
}

-(void)localAction:(UIButton *)sender{
    [BRAddressPickerView showAddressPickerWithDefaultSelected:nil isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
        [sender setTitle:[NSString stringWithFormat:@"%@-%@-%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]] forState:UIControlStateNormal];
    }];
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
