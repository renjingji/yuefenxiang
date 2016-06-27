//
//  RJJFMDB.h
//  阅分享
//
//  Created by  任京记 on 16/6/19.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "RJJPerson.h"

@interface RJJFMDB : NSObject
@property (nonatomic, strong) FMDatabase *db;


+ (void)fmdb;
+ (void) addPerson:(RJJPerson *)person;
+ (NSArray *)persons;

@end
