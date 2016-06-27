//
//  RJJBookNavigaionVc.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJBookNavigaionVc.h"

@interface RJJBookNavigaionVc ()

@end

@implementation RJJBookNavigaionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem.title = @"书";
    self.tabBarItem.image = [UIImage imageNamed:@"书2"];
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
