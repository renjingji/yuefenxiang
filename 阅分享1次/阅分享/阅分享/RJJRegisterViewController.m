//
//  RJJRegisterViewController.m
//  阅分享
//
//  Created by  任京记 on 16/6/17.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJRegisterViewController.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "FMDB.h"
#import "RJJFMDB.h"
#import "RJJPerson.h"

@interface RJJRegisterViewController ()<MFMessageComposeViewControllerDelegate>
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic,strong) NSString *str;
@property (nonatomic, weak) UITextField *identifyText;
@property (nonatomic, weak) UITextField *passWordField;
@end

@implementation RJJRegisterViewController

- (void)viewDidLoad {
    [self addTelNumber];
    [self addPassWord];
    [self addButton];
    [self addLabel];
    [self addHtmlBtn];
    [self addRegisterBtn];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    UITextField *identifyText = [[UITextField alloc] init];
    //    identifyText.frame = CGRectMake(10, 119, 180, 35);
    identifyText.borderStyle = UITextBorderStyleRoundedRect;
    identifyText.placeholder = @"请输入验证码";
    identifyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    identifyText.keyboardType = UIKeyboardTypeNumberPad;
    self.identifyText = identifyText;
    [self.view addSubview:identifyText];
    identifyText.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    button.bounds = CGRectMake(0, 0, 20, 25);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    UIButton *idenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    idenButton.backgroundColor = [UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1];
    [idenButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [idenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    idenButton.frame = CGRectMake(200, 119, 110, 35);
    idenButton.layer.cornerRadius = 5;
    idenButton.layer.masksToBounds = YES;
    [idenButton setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [idenButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [idenButton addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:idenButton];
    idenButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *idenButtonH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[identifyText]-10-[idenButton(==identifyText)]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"idenButton":idenButton,@"identifyText":identifyText}];
    [self.view addConstraints:idenButtonH];
    NSArray *idenButtonV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameField]-10-[identifyText(40)]" options:0 metrics:nil views:@{@"nameField":_nameField,@"identifyText":identifyText}];
    [self.view addConstraints:idenButtonV];
    NSArray *idenButtonV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameField]-10-[idenButton(40)]" options:0 metrics:nil views:@{@"nameField":_nameField,@"idenButton":idenButton}];
    [self.view addConstraints:idenButtonV2];

   
    self.button.selected = [[NSUserDefaults standardUserDefaults] boolForKey:@"www"];
    [RJJFMDB fmdb];
//    [self.DB executeUpdate:@"DROP TABLE IF EXISTS t_user;"];
    [self setUpForDismissKeyBoard];
    
    
    
}
/**获取验证码*/
- (void)getIdentifyCode{
    
    NSString *tel = self.nameField.text;
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc] init];
        NSString *strr = @"556667";
        self.str = strr;
        NSString *str = [NSString stringWithFormat:@"验证码 %@",strr];
        message.body = str;
        message.recipients = [NSArray arrayWithObject:tel];
        message.navigationItem.title = @"发短信";
        [self presentViewController:message animated:YES completion:nil];
        message.messageComposeDelegate = self;
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    if (result == MessageComposeResultCancelled || result == MessageComposeResultFailed || result ==  MessageComposeResultSent ) {
        [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
    }
    
}
/**添加注册registerBtn*/
- (void)addRegisterBtn{
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    registerBtn.backgroundColor = [UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1];
    registerBtn.frame = CGRectMake(10, 233, 300, 30);
    registerBtn.layer.cornerRadius = 7;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registerBtn];

}
/**注册*/
- (void)registerClick{
    if (self.nameField.text.length == 0) {
        MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//      自定义view
        MB.customView = [[UIImageView alloc] init];
        MB.labelText = @"请输入正确的手机号码";
        MB.mode = MBProgressHUDModeText;
        MB.removeFromSuperViewOnHide = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MB.hidden = YES;
        });
        return;
    }
    NSArray *array = [RJJFMDB persons];
    for (RJJPerson *person in array) {
        if ([person.name isEqualToString:self.nameField.text]) {
            MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            MB.labelText = @"此号码已注册";
            MB.mode = MBProgressHUDModeText;
            MB.removeFromSuperViewOnHide = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                MB.hidden = YES;
                NSLog(@"%@",person.name);
            });
        }
        return;

    }
    
    if ([self.identifyText.text isEqualToString:self.str]) {
        RJJPerson *person = [[RJJPerson alloc] init];
        person.name = self.nameField.text;
        person.passWord = self.passWordField.text;
        [RJJFMDB addPerson:person];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        MBProgressHUD *MB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MB.labelText = @"验证码错误";
        MB.mode = MBProgressHUDModeText;
        MB.removeFromSuperViewOnHide = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MB.hidden = YES;
        });

    }


}
/**添加协议btn*/
- (void)addHtmlBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"同意《阅分享用户注册协议》" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.frame = CGRectMake(85, 209, 130, 10);
    [self.view addSubview:btn];
}

- (void)addLabel{
    UILabel * label = [[UILabel alloc] init];
    label.text = @"我已经阅读并";
    label.textColor = [UIColor blackColor];
    label.frame = CGRectMake(23, 209, 60, 10);
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
}

/**添加userName用户名*/
- (void)addTelNumber{
    
    UITextField *nameField = [[UITextField alloc] init];
//    nameField.frame = CGRectMake(10, 74, 300, 35);
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.placeholder = @"请输入手机号";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:nameField];
    self.nameField = nameField;
    nameField.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *nameFieldH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[nameField]-20-|" options:0 metrics:nil views:@{@"nameField":nameField}];
    [self.view addConstraints:nameFieldH];
    NSArray *namefieldV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[nameField(40)]" options:0 metrics:nil views:@{@"nameField":nameField}];
    [self.view addConstraints:namefieldV];
}
/**返回*/
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**添加密码框*/
- (void)addPassWord{
    UITextField *passWordField = [[UITextField alloc] init];
    passWordField.frame = CGRectMake(10, 164, 300, 35);
    passWordField.borderStyle = UITextBorderStyleRoundedRect;
    passWordField.placeholder = @"请输入密码";
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:passWordField];
    self.passWordField = passWordField;

}
/**添加同意按钮*/
- (void)addButton{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"未选中同意条款"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"选中同意条款"] forState:UIControlStateSelected];
    button.frame = CGRectMake(10, 209, 10, 10);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    self.button = button;

}

- (void)buttonClick:( UIButton *)button{
    button.selected = !button.selected;
    [[NSUserDefaults standardUserDefaults] setBool:button.selected forKey:@"www"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

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
