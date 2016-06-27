//
//  RJJNavigationVv.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJNavigationVv.h"
#import "RJJLoginViewController.h"

@interface RJJNavigationVv ()

@property (nonatomic, assign) BOOL isLogin;

@end

@implementation RJJNavigationVv

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem.title = @"关注";
    self.tabBarItem.image =[UIImage imageNamed:@"关注2"];
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor colorWithRed:41/254.0 green:181/254.0 blue:235/254.0 alpha:0];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [bar setTitleTextAttributes:dict];
    [bar setTintColor:[UIColor whiteColor]];
//  获得本地版本号
//    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
//    NSString *verson = dict[@"CFBundleShortVersionString"];
//    float shortVerson = verson.floatValue;
//    NSLog(@"%2f",shortVerson);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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
