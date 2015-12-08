//
//  Student.h
//  patientv1.0
//
//  Created by liyongli on 15/7/24.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *studentNumber;
@property(nonatomic, strong) NSString *sex;


@end
