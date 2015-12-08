//
//  WmHttpRequestManager.h
//
//  Created by family on 15/7/27.
//  Copyright (c) 2015年 李永利. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestInfo.h"

@interface WmHttpRequestManager : NSObject

///创建请求manager
+ (WmHttpRequestManager *)shareManager;

//get
- (void)startAsyncHttpGetWithRequestInfo:(RequestInfo *)requestInfo;
//post
- (void)startAsyncHttpPostWithRequestInfo:(RequestInfo *)requestInfo;
//head
- (void)startAsyncHttpHeadWithRequestInfo:(RequestInfo *)requestInfo;
//upload Image
- (void)startAsyncUploadImage:(RequestInfo *)requestInfo;
///页面dealloc的时候，取消联网
- (void)cancelRequest;

@end
