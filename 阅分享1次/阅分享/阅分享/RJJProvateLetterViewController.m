//
//  RJJProvateLetterViewController.m
//  阅分享
//
//  Created by  任京记 on 16/6/15.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJProvateLetterViewController.h"

@interface RJJProvateLetterViewController ()

@end

@implementation RJJProvateLetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"私信";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 15, 20);
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backClick{

    [self.navigationController popViewControllerAnimated:YES];




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
