//
//  RJJCustomButton.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJCustomButton.h"

@implementation RJJCustomButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{



    return CGRectMake(25, 8, 20, 20);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{




    return CGRectMake(25, 36, 30, 8);

}

@end
