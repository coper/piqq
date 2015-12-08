//
//  实现的单例类，
//  Singleton.h
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "LSO.h"


#import <Foundation/Foundation.h>

@interface Singleton : NSObject

// 本地数据存储
@property (strong, nonatomic) LSO *localDB;



+(Singleton*)GetInstance;
-(void)SayHello;

@end
