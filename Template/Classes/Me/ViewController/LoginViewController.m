//
//  LoginViewController.m
//  Template
//
//  Created by 森度 on 2017/10/13.
//  Copyright © 2017年 森度. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField *nameField;
@property(nonatomic ,strong)UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UITextField *name = [[UITextField alloc] init];
//    [name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(150);
//        make.left.mas_equalTo(80);
//        make.right.mas_equalTo(80);
//        make.height.mas_equalTo(40);
//    }];
    name.frame = CGRectMake(40, 180, SCREEN_WIDTH-140, 40);
    name.layer.cornerRadius= 5;
    name.layer.borderWidth= 1;
    name.layer.borderColor = [UIColor blackColor].CGColor;
    name.placeholder= @" 请输入手机号码:";
    [self.view addSubview:name];
    _nameField = name;
    _nameField.delegate = self;
    
    UIButton *numBtn = [[UIButton alloc] init];
    numBtn.frame = CGRectMake(SCREEN_WIDTH-100, 180, 60, 40);
//    [numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 35));
//        make.top.mas_equalTo(2);
//        make.right.mas_equalTo(5);
//    }];
    [numBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [numBtn addTarget:self action:@selector(huoQuYanZhengMa) forControlEvents:UIControlEventTouchUpInside];
    numBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    numBtn.backgroundColor = [UIColor grayColor];
    numBtn.userInteractionEnabled = NO;
    numBtn.tag = 100;
    [self.view addSubview:numBtn];
    
    
    UITextField *password = [[UITextField alloc] init];
    //    [name mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_offset(150);
    //        make.left.mas_equalTo(80);
    //        make.right.mas_equalTo(80);
    //        make.height.mas_equalTo(40);
    //    }];
    password.frame = CGRectMake(40, 230, SCREEN_WIDTH-80, 40);
    password.layer.cornerRadius= 5;
    password.layer.borderWidth= 1;
    password.layer.borderColor = [UIColor blackColor].CGColor;
    password.placeholder= @" 请输入验证码:";
    [self.view addSubview:password];
    _passwordField = password;
    _passwordField.delegate = self;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.frame = CGRectMake(50, 290, SCREEN_WIDTH-100, 40);
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = [UIColor grayColor];
    loginBtn.userInteractionEnabled =NO;
    loginBtn.tag = 101;
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
}

-(void)loginAction:(UIButton *)sender{
    [SMSSDK commitVerificationCode:self.passwordField.text phoneNumber:self.nameField.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            ZLog(@"验证成功");
        }
        else
        {
            // error
        }
    }];
}
-(void)huoQuYanZhengMa{
   
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.nameField.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            ZLog(@"请求成功");
        }
        else
        {
            // error
            ZLog(@"请求失败%@",error);
        }
    }];

//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18792140306" zone:@"86" result:^(NSError *error) {
//        
//        if (!error)
//        {
//            ZLog(@"**success**");
//        }
//        else
//        {
//            // error
//        }
//    }];
//    ZLog(@"****");
}

#pragma mark uitexfield的代理事件
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (self.nameField == textField) {
        if ([self validateNumber:string]) {
            
            if (existedLength - selectedLength + replaceLength < 12) {
                
                if (existedLength - selectedLength + replaceLength == 11) {
                    UIButton *btn = [self.view viewWithTag:100];
                    btn.backgroundColor = [UIColor greenColor];
                    btn.userInteractionEnabled = YES;
                }
                return YES;
        }
    }
    }
    
    if (self.nameField.text.length >=11 && existedLength - selectedLength + replaceLength >= 4) {
        UIButton *btn = [self.view viewWithTag:101];
        btn.backgroundColor = [UIColor greenColor];
        btn.userInteractionEnabled = YES;
        
    }
    if (self.passwordField == textField) {
        if (existedLength - selectedLength + replaceLength > 4) {
            return NO;
        }
    }
   
        return YES;
}

//限制只能输入数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
