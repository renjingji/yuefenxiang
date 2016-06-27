//
//  RJJForgetViewController.m
//  阅分享
//
//  Created by  任京记 on 16/6/19.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJForgetViewController.h"
#import <MessageUI/MessageUI.h>

@interface RJJForgetViewController ()<MFMessageComposeViewControllerDelegate>
@property (nonatomic, weak) UITextField *nameField;
@property (nonatomic, weak) UITextField *identifyText;
@property (nonatomic, weak) UITextField *passWordField;
@property (nonatomic, copy) NSString *str;
@end

@implementation RJJForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    self.title = @"忘记密码";
    UIButton *idenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    idenButton.backgroundColor = [UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1];
    [idenButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [idenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    idenButton.frame = CGRectMake(200, 119, 110, 35);
    idenButton.layer.cornerRadius = 5;
    idenButton.layer.masksToBounds = YES;
    [idenButton setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [idenButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [idenButton addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:idenButton];
    [self addIdentifyingCode];
    [self addPassWord];
    [self addTelNumber];
    [self addBtnClick];
    [self setUpForDismissKeyBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
/**添加验证码*/
- (void)addIdentifyingCode{
    UITextField *identifyText = [[UITextField alloc] init];
    identifyText.frame = CGRectMake(10, 119, 180, 35);
    identifyText.borderStyle = UITextBorderStyleRoundedRect;
    identifyText.placeholder = @"请输入验证码";
    identifyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    identifyText.keyboardType = UIKeyboardTypeNumberPad;
    self.identifyText = identifyText;
    [self.view addSubview:identifyText];
}
/**添加userName用户名*/
- (void)addTelNumber{
    
    UITextField *nameField = [[UITextField alloc] init];
    nameField.frame = CGRectMake(10, 74, 300, 35);
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.placeholder = @"请输入手机号";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:nameField];
    self.nameField = nameField;
}
/**添加密码框*/
- (void)addPassWord{
    UITextField *passWordField = [[UITextField alloc] init];
    passWordField.frame = CGRectMake(10, 164, 300, 35);
    passWordField.borderStyle = UITextBorderStyleRoundedRect;
    passWordField.placeholder = @"请输入新密码";
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:passWordField];
    self.passWordField = passWordField;
    
}
- (void)addBtnClick{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认 " forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:1];
    btn.frame = CGRectMake(10, 220, 300, 35);
    btn.layer.cornerRadius = 7;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];

}


/**收起键盘*/
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
