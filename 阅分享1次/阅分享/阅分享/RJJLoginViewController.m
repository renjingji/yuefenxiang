//
//  RJJLoginViewController.m
//  阅分享
//
//  Created by  任京记 on 16/6/15.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJLoginViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "RJJRegisterViewController.h"
#import "RJJForgetViewController.h"

@class RJJTabBarVc;
@interface RJJLoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *passWordField;
@property (nonatomic, weak) UITabBarController *tabbar;

@end

@implementation RJJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账号登录";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick)];
    self.navigationItem.rightBarButtonItem = item;
//    
//    RJJFriendViewController *viw = [[RJJFriendViewController alloc] init];
//    [self.navigationController pushViewController:viw animated:YES];
    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.frame  = CGRectMake(10, 120,40, 30);
    nameLabel.text = @"账户";
    nameLabel.textColor = [UIColor blackColor];
    [self.view addSubview:nameLabel];
    UITextField *nameField = [[UITextField alloc] init];
    nameField.delegate = self;
    nameField.inputView = nil;
//    nameField.frame = CGRectMake(60, 120, 240, 30);
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.placeholder = @"请输入手机号";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.keyboardType = UIKeyboardTypeNumberPad;
    self.nameField = nameField;
    [self.view addSubview:nameField];
    UILabel *passWordLabel = [[UILabel alloc] init];
    passWordLabel.text = @"密码";
    passWordLabel.textColor = [UIColor blackColor];
    [self.view addSubview:passWordLabel];
    UITextField *passWordField = [[UITextField alloc] init];
    passWordField.borderStyle = UITextBorderStyleRoundedRect;
    passWordField.placeholder = @"请输入密码";
    passWordField.secureTextEntry = YES;
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordField = passWordField;
    [self.view addSubview:passWordField];
    UIButton *forgetPassWord = [UIButton buttonWithType:UIButtonTypeCustom];
//    forgetPassWord.frame = CGRectMake(240, 220, 60, 20);
    forgetPassWord.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPassWord setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPassWord setTitleColor:[UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1] forState:UIControlStateNormal];
    [forgetPassWord setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [forgetPassWord setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [forgetPassWord addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassWord];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 300, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setBackgroundColor:[UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1]];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [self setUpForDismissKeyBoard];
    /**使用Autolayout代码添加约束 一个约束就是添加一个NSLayoutConstraint，添加之前先将autoresizing功能设置为no 还要确保控件已经添加到父控件上， 然后控件添加了约束，就不要再设置frame*/
    
    
//    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *nameConstraint = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
//    [self.view addConstraint:nameConstraint];
//    NSLayoutConstraint *nameConstraintRight = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nameField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10];
//    [self.view addConstraint:nameConstraintRight];
//    NSLayoutConstraint *nameConstraintW = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nameField attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0];
//    [self.view addConstraint:nameConstraintW];
//    NSLayoutConstraint *nameConstraintHeight = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nameField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
//    [self.view addConstraint:nameConstraintHeight];
//    NSLayoutConstraint *nameConsY = [NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
//    [self.view addConstraint:nameConsY];
//    nameField.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *nameFieldConsRight = [NSLayoutConstraint constraintWithItem:nameField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:10];
//    [self.view addConstraint:nameFieldConsRight];
//    NSLayoutConstraint *nameFieldConsHeight = [NSLayoutConstraint constraintWithItem:nameField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:30];
//    [nameField addConstraint:nameFieldConsHeight];
//    NSLayoutConstraint *nameFieldConsY = [NSLayoutConstraint constraintWithItem:nameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//    [self.view addConstraint:nameFieldConsY];
//
    
//    使用vfl语言来设置自动布局
//    设置Autoresizing功能为no
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameField.translatesAutoresizingMaskIntoConstraints = NO;
//    设置多个约束
//    options对齐方式
    NSArray *nameLW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[nameLabel(40)]-10-[nameField]-30-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"nameLabel":nameLabel,@"nameField":nameField}];
//    添加多个约束
    [self.view addConstraints:nameLW];
    NSArray *nameLH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[nameLabel(40)]" options:0  metrics:nil views:@{@"nameLabel":nameLabel}];
    [self.view addConstraints:nameLH];
    passWordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    passWordField.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *passWordH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[passWordLabel(40)]-10-[passWordField]-30-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"passWordLabel":passWordLabel,@"passWordField":passWordField}];
    [self.view addConstraints:passWordH];
    NSArray *passWordV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel]-20-[passWordLabel(40)]" options:0 metrics:nil views:@{@"nameLabel":nameLabel,@"passWordLabel":passWordLabel}];
    [self.view addConstraints:passWordV];
    forgetPassWord.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *forgetW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[forgetPassWord(60)]" options:0 metrics:nil views:@{@"forgetPassWord":forgetPassWord}];
    [self.view addConstraints:forgetW];
    NSArray *forgetH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[passWordField]-10-[forgetPassWord(10)]" options:NSLayoutFormatAlignAllRight metrics:nil views:@{@"passWordField":passWordField,@"forgetPassWord":forgetPassWord}];
    [self.view addConstraints:forgetH];
    loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *loginBtnH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[loginBtn]-30-|" options:0 metrics:nil views:@{@"loginBtn":loginBtn}];
    [self.view addConstraints:loginBtnH];
    NSArray *loginV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[passWordField]-40-[loginBtn(40)]" options:0 metrics:nil views:@{@"loginBtn":loginBtn,@"passWordField":passWordField}];
    [self.view addConstraints:loginV];
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

  /** 忘记密码*/
- (void)forgetPassWord{
    RJJForgetViewController *forgetVc = [[RJJForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVc animated:YES];

}

/**注册*/
- (void)registerClick{
    RJJRegisterViewController *registerrVc = [[RJJRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerrVc animated:YES];
}


/**登录*/
- (void)loginClick:(UIButton *)login{
    if (self.nameField.text.length == 0) {
        MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MB.labelText = @"请输入手机号";
        MB.mode = MBProgressHUDModeText;
        MB.removeFromSuperViewOnHide = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MB.hidden = YES;
        });
        return;
    }
    if (self.passWordField.text.length == 0) {
        MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MB.labelText = @"请输入密码";
        MB.mode = MBProgressHUDModeText;
        MB.removeFromSuperViewOnHide = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MB.hidden = YES;
        });
        return;
    }
    NSString *userName = self.nameField.text;
    NSString *userId = self.passWordField.text;
    /**没有服务器端， 所以没有办法从服务器上将用户id下载到本地，上传密码参数的时候要加密，base64加密或MD5加密*/
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:^(NSProgress * _Nonnull uploadProgress) {
//        <#code#>
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        解析responseObject 判断用户密码是否正确，如果正确就登录到主界面，并且将
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        <#code#>
//    }]
//
    if ([userName isEqualToString:@"13917265873"] && [userId isEqualToString:@"yanshagua521"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userName forKey:@"userName"];
        [defaults setObject:userId forKey:@"userId"];
        [defaults synchronize];
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**编辑结束，点击空白的地方将键盘收起来*/
- (void)setUpForDismissKeyBoard{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
   [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view addGestureRecognizer:tap];
   }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view removeGestureRecognizer:tap];
    }];
}
#pragma mark 手势识别器的方法 收起键盘
- (void)hideKeyBoard{

    [self.view endEditing:YES];


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
