//
//  LSO.m
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "LSO.h"

@implementation LSO

//1. 创建数据库
-(BOOL)createDataTable
{
    BOOL flg;
    if (self.dbManger == nil)
    {
        self.dbManger = [[FMDBManager alloc] init];
    }
//    NSString *sql = @"CREATE TABLE 'message_table' ('message_key' TEXT PRIMARY KEY  NOT NULL  check(typeof('message_key') = 'text'), 'att_value' )";
    NSString *sql = @"CREATE TABLE 'message_table' ('message_key' TEXT PRIMARY KEY  NOT NULL  check(typeof('message_key') = 'text'), 'att_value' BLOB)";
    //创建表
    flg =  [self.dbManger createTable:self.tableName withSql:sql];
    return flg;
}

//添加数据 修改数据
-(BOOL)setItem:(NSString *)keyStr valueObj:(NSObject *)valueObj
{
    BOOL isOk = NO;

    NSString *sqlStr = [NSString stringWithFormat:@"replace into message_table(message_key, att_value) values(?,?)"];
    
    isOk = [self.dbManger insertTable:sqlStr, keyStr, [NSKeyedArchiver archivedDataWithRootObject:valueObj]];
    if (isOk)
    {
        NSLog(@"成功执行了SQL语句 %@", sqlStr);
    }
    return isOk;
}

//查询数据
-(NSObject *)getItem:(NSString *)key
{
    NSObject *attValue;
    NSString *taleName = [NSString stringWithFormat:@"message_table WHERE message_key= '%@'", key];
    NSData   *tmpData   = [self.dbManger getDb_Bolbdata:taleName withFieldName:@"att_value"];
    if (tmpData)
    {
        attValue = [NSKeyedUnarchiver unarchiveObjectWithData:tmpData];
    }
    return attValue;
}









-(NSString *)getItemStr:(NSString *)key
{
    return nil;
}
-(NSInteger *)getItemInt:(NSString *)key
{
    return  0;
}
-(BOOL)getItemBool:(NSString *)key
{
    return  NO;
}

-(BOOL)setItemStr:(NSString *)keyStr valueStr:(NSString *)valueStr
{
    return  NO;
}

-(BOOL)setItemInt:(NSString *)keyStr valueInt:(NSInteger *)valueInt
{
    return  NO;
}

-(BOOL)setItemBool:(NSString *)keyStr valueBool:(BOOL)isOk
{
    return  NO;
}


//返回所有的数据    暂时没有实现
-(NSObject *)getAllData
{
//    NSObject *attValue;
//    NSString *taleName = [NSString stringWithFormat:@"message_table"];
//    NSData   *tmpData   = [self.dbManger getDb_Bolbdata:taleName withFieldName:@"*"];
//    if (tmpData)
//    {
//        attValue = [NSKeyedUnarchiver unarchiveObjectWithData:tmpData];
//    }
//    NSLog(@"%@", attValue);
    return nil;
}


//清除所有的数据
-(BOOL)cleanItem:(NSString *)key
{
    return NO;
}


//清空所有的数据
-(BOOL)cleanAll
{
    return NO;
}


//删除表
-(BOOL)deleteTable
{
    return  NO;
}


//- (void)logMessage:(NSString *)format, ... {
//    va_list args;
//    va_start(args, format);
//    
//    id arg = nil;
//    while ((arg = va_arg(args,id))) {
//        /// Do your thing with arg here
//    }
//    
//    va_end(args);
//}



@end
