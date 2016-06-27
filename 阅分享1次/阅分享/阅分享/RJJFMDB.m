//
//  RJJFMDB.m
//  阅分享
//
//  Created by  任京记 on 16/6/19.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJFMDB.h"


@implementation RJJFMDB
static FMDatabase *_db;


+ (void)fmdb{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"renjingji"];
     _db = [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user(id integer PRIMARY KEY,userName text, userPassWord text);"];
    
}
+ (void) addPerson:(RJJPerson *)person{
    
    
   [_db executeUpdateWithFormat:@"INSERT INTO t_user(userName,userPassword ) VALUES (%@, %@);", person.name, person.passWord];
}
+ (NSArray *)persons
{// 得到结果集
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_user;"];
    
    // 不断往下取数据
    NSMutableArray *persons = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        RJJPerson *person = [[RJJPerson alloc] init];
        person.name = [set stringForColumn:@"userName"];
        person.passWord = [set stringForColumn:@"userPassWord"];
        [persons addObject:person];
    }
    return persons;
}
@end
