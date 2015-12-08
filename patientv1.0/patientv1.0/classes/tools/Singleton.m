//
//  Singleton.m
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//
#import "Singleton.h"
@implementation Singleton

static Singleton *myInstance =nil;
static int num;

@synthesize localDB;

+(Singleton*)GetInstance
{
    @synchronized([Singleton class])
    {
        if(myInstance ==nil)
        {
            myInstance = [[self alloc] init];
        }
    }
    return myInstance;
}

+(id)alloc
{
    @synchronized([Singleton class])
    {
        if (myInstance ==nil)
        {
            myInstance = [super alloc];
            num++;
            NSLog(@"对象数目:%d",num);
        }
        else
        {
            NSLog(@"不好意思，你在实例化第二个对象");
        }
        return myInstance;
    }
    return nil;
}

-(id)init
{
    self = [super init];
    if(self !=nil)
    {
        NSLog(@"初始化数据");
        [self initMain];
    }
    return self;
}

-(void)initMain
{
    //本地数据存储管理
    localDB = [[LSO alloc] init];
}



-(void)SayHello
{
    NSLog(@"Hello,world!");
}
@end