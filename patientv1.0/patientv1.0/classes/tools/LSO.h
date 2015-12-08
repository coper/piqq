//
//  LSO.h
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBManager.h"

@interface LSO : NSObject


@property (strong, nonatomic) FMDBManager *dbManger;
@property (strong, nonatomic) NSString    *tableName;




//1. 初始化创建数据库
//2. 创建表
//3. setItem
//4. getKey
//5. getAllData
//6. cleanKey
//7. cleanAll
//8. deleteTable

//  初始化数据库
-(BOOL)createDataTable;


-(BOOL)setItem:(NSString *)keyStr valueObj:(NSObject *)valueObj;
//待补充
-(BOOL)setItemStr:(NSString *)keyStr valueStr:(NSString *)valueStr;
-(BOOL)setItemInt:(NSString *)keyStr valueInt:(NSInteger *)valueInt;
-(BOOL)setItemBool:(NSString *)keyStr valueBool:(BOOL)isOk;

-(NSObject *)getItem:(NSString *)key;
//待补充
-(NSString *)getItemStr:(NSString *)key;
-(NSInteger *)getItemInt:(NSString *)key;
-(BOOL)getItemBool:(NSString *)key;

//待补充
-(NSObject *)getAllData;
-(BOOL)cleanItem:(NSString *)key;
-(BOOL)cleanAll;
-(BOOL)deleteTable;


@end
