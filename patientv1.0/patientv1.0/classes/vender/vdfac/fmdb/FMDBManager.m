//
//  FMDBManager.m
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "FMDBManager.h"

static FMDatabase *shareDataBase = nil;

@implementation FMDBManager

-(FMDatabase *)createDataBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"createDataBase dataBasePath    %@", dataBasePath)
        shareDataBase = [FMDatabase databaseWithPath:dataBasePath];
    });
    return shareDataBase;
}

#pragma mark 删除数据库
// 删除数据库
- (void)deleteDatabse
{
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // delete the old db.
    if ([fileManager fileExistsAtPath:dataBasePath])
    {
        [shareDataBase close];
        success = [fileManager removeItemAtPath:dataBasePath error:&error];
        if (!success)
        {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }
}

// 创建表
- (BOOL) createTable:(NSString *)tableName withSql:(NSString *)sql
{
    BOOL isOk;
    shareDataBase = [self createDataBase];
    if ([shareDataBase open])
    {
        if ( ![self isTableExist:tableName] )
        {
            NSString *sqlstr = [NSString stringWithFormat:@"%@",sql];
            NSLog(@"sqlstr: %@", sqlstr);
            [shareDataBase executeUpdate:sqlstr];
        }
        [shareDataBase close];
    }
    return isOk;
}

// 删除表
- (BOOL) deleteTable:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if (![shareDataBase executeUpdate:sqlstr])
    {
        NSLog(@"Delete table error!");
        return NO;
    }
    return YES;
}

// 清除表
- (BOOL) eraseTable:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    if (![shareDataBase executeUpdate:sqlstr])
    {
        NSLog(@"Erase table error!");
        return NO;
    }
    return YES;
}

// 插入数据
- (BOOL)insertTable:(NSString*)sql, ...
{
    BOOL result;
    shareDataBase = [self createDataBase];
    if ([shareDataBase open])
    {
        va_list args;
        va_start(args, sql);
        result = [shareDataBase executeUpdate:sql withVAList:args];
        va_end(args);
        
        [shareDataBase close];
    }
    return result;
}

// 插入数据
-(BOOL)insertTableByArr:(NSString *)sql withFieldName:(NSArray *)fieldArr
{
    BOOL result;
    shareDataBase = [self createDataBase];
    if ([shareDataBase open])
    {
        result = [shareDataBase executeUpdate:sql withArgumentsInArray:fieldArr];
    }
    return result;
}


#pragma mark 获得单一数据
// 整型
- (NSInteger)getDb_Integerdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSInteger result = NO;
    
    shareDataBase = [self createDataBase];
    if ([shareDataBase open])
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
        FMResultSet *rs = [shareDataBase executeQuery:sql];
        if ([rs next])
            result = [rs intForColumnIndex:0];
        [rs close];
        
        [shareDataBase close];
    }
    return result;
}

// 布尔型
- (BOOL)getDb_Booldata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    BOOL result;
    result = [self getDb_Integerdata:tableName withFieldName:fieldName];
    return result;
}

// 字符串型
- (NSString *)getDb_Stringdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSString *result = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
    FMResultSet *rs = [shareDataBase executeQuery:sql];
    if ([rs next])
        result = [rs stringForColumnIndex:0];
    [rs close];
    
    return result;
}

// 二进制数据型
- (NSData *)getDb_Bolbdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSData *result = nil;
    shareDataBase = [self createDataBase];
    if ([shareDataBase open])
    {
        NSString *sqlstr = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
        NSLog(@"sqlstr: %@", sqlstr);
        FMResultSet *rs = [shareDataBase executeQuery:sqlstr];
        NSLog(@"rs: %@", rs);
        if ([rs next])
            result = [rs dataForColumnIndex:0];
        [rs close];
    
        [shareDataBase close];
    }
    return result;
}


// 判断是否存在表
- (BOOL) isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [shareDataBase executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return NO;
}
@end
