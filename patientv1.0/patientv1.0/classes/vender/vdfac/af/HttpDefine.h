//
//  HttpDefine.h
//
//  Created by family on 15/7/27.
//  Copyright (c) 2015年 李永利. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WmHttpRequeestDelegate <NSObject>

@optional
//上传进度
-(void)setUploadProgress:(NSUInteger) bytesWritten totalBytesWritten:(long long) totalBytesWritten totalBytesExpectedToWrite:(long long) totalBytesExpectedToWrite andResquestInfo:(id)requestInfo;

//下载进度
-(void)setDownloadProgress:(NSUInteger) bytesWritten totalBytesWritten:(long long) totalBytesWritten totalBytesExpectedToWrite:(long long) totalBytesExpectedToWrite andResquestInfo:(id)requestInfo;


@required
//请求服务完成
- (void)connectionComplete:(NSDictionary *)dic andFlagString:(NSString *)flagStr andResquestInfo:(id)requestInfo;
//请求服务器失败
- (void)connectionFailedWithError:(NSError *)error andResquestInfo:(id)requestInfo;

@end

@interface HttpDefine : NSObject

//设置IP
+(void)setIp:(NSString *)ip;
//获取IP
+(NSString *)getIp;
//获取URL绝对路径
+(NSString *)getURLPath:(NSString *)relativePath;

@end
