//
//  DictionaryWithString.h
//  patient
//
//  Created by zhangyu on 15/6/4.
//  Copyright (c) 2015年 ASK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryWithString : NSObject
@property(nonatomic,strong) NSString *md5TargetString;
@property(nonatomic,strong) NSMutableDictionary *mutaDictionary;

- (void)setValue:(id)value forKey:(NSString *)key;
@end
