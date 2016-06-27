//
//  RJJCustomVIew.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJCustomVIew.h"

@implementation RJJCustomVIew

+ (instancetype)customView{

    return [[[NSBundle mainBundle] loadNibNamed:@"RJJCustomView" owner:nil options:nil] lastObject];

}

@end
