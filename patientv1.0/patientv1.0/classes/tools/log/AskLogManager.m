//
//  AskLogManager.m
//  patientv1.0
//
//  Created by liyongli on 15/10/27.
//  Copyright © 2015年 ask. All rights reserved.
//

#import "AskLogManager.h"

@implementation AskLogManager

#pragma mark - 对外公开接口
+ (AskLogManager *)shareManager {
    static AskLogManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (manager == nil)
        {
            manager = [[AskLogManager alloc]init];
        }
    });
    return manager;
}





@end
