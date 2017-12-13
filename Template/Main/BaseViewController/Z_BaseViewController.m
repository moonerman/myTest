//
//  Z_BaseViewController.m
//  Template
//
//  Created by 森度 on 2017/8/16.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "Z_BaseViewController.h"
@interface Z_BaseViewController ()

@end

@implementation Z_BaseViewController
-(void)dealloc{
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DayOrNight) name:@"DayOrNight" object:nil];
    
    self.dk_manager.themeVersion = DKThemeVersionNormal;
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
     // Do any additional setup after loading the view.
}

-(void)DayOrNight{

    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {
        self.dk_manager.themeVersion = DKThemeVersionNight;

    }else{
        
        self.dk_manager.themeVersion = DKThemeVersionNormal;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.dk_manager.themeVersion = DKThemeVersionNormal;
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
