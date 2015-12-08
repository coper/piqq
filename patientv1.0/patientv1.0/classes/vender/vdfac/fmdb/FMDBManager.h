//
//  FMDBManager.h
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"




#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"askDataBase.sqlite"


@interface FMDBManager : NSObject

@property (strong, nonatomic) FMDatabase *_db;
@property (strong, nonatomic) NSString   *_dbName;

// 创建数据库
- (FMDatabase *)createDataBase;
// 删除数据库
- (void)deleteDatabse;
// 判断是否存在表
- (BOOL) isTableExist:(NSString *)tableName;
// 创建表
- (BOOL) createTable:(NSString *)tableName withSql:(NSString *)sql;
// 删除表-彻底删除表
- (BOOL) deleteTable:(NSString *)tableName;
// 清除表-清数据
- (BOOL) eraseTable:(NSString *)tableName;
// 插入数据
- (BOOL)insertTable:(NSString*)sql, ...;
// 插入数据，用arr组织参数
- (BOOL)insertTableByArr:(NSString *)sql withFieldName:(NSArray *)fieldArr;

#pragma 读取单一数据
// 整型
- (NSInteger)getDb_Integerdata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 布尔型
- (BOOL)getDb_Booldata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 字符串型
- (NSString *)getDb_Stringdata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 二进制数据型
- (NSData *)getDb_Bolbdata:(NSString *)tableName withFieldName:(NSString *)fieldName;

@end
