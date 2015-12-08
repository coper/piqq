//
//  WmHttpRequestManager.h
//
//  Created by family on 15/7/27.
//  Copyright (c) 2015年 李永利. All rights reserved.
//

#import "WmHttpRequestManager.h"
#import "AFNetworking.h"

@interface WmHttpRequestManager() {
    NSMutableDictionary *ems;
    NSMutableDictionary *afr;
}

@end

@implementation WmHttpRequestManager

#pragma mark - 对外公开接口
+ (WmHttpRequestManager *)shareManager {
    static WmHttpRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (manager == nil)
        {
            manager = [[WmHttpRequestManager alloc]init];
        }
    });
    return manager;
}

//Get
-(void)startAsyncHttpGetWithRequestInfo:(RequestInfo *)requestInfo
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    //1. 送给服务器的参数
    jsonDict =  [requestInfo getParamsDict];
    AFHTTPRequestOperationManager *afHttpManager = [self getLMS:requestInfo.localName];
    //2. 添加请求头信息
    [self createHttpHeader:afHttpManager headParams:requestInfo.getHeaderParams];
    
    NSLog(@"\n----------------------------------------\n请求地址：%@ \n----------------------------------------\n参数：%@ \n----------------------------------------",requestInfo.urlStr, jsonDict);
    
    //数据是josn 数据格式
    if (requestInfo.dataFormat == HttpResponseFormat_JOSN)
    {
        //1. 返回josn
        afHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager GET:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_Plist)
    {
        //2.plist
        afHttpManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager GET:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_XML)
    {
        //3.设置返回数据类型
        afHttpManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager GET:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else
    {
        NSLogError(@"post 请求暂时不支持返回这样的数据格式 %u", requestInfo.dataFormat);
        return;
    }
    
    //3. 上传进度
    [afr[requestInfo.flagStr] setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        if ([requestInfo.wmDelegate respondsToSelector:@selector(setUploadProgress:totalBytesWritten:totalBytesExpectedToWrite:andResquestInfo:)])
        {
            [requestInfo.wmDelegate setUploadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
        }
    }];
    //4. 下载进度
    [afr[requestInfo.flagStr] setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        if ([requestInfo.wmDelegate respondsToSelector:@selector(setDownloadProgress:totalBytesWritten:totalBytesExpectedToWrite:andResquestInfo:)])
        {
            [requestInfo.wmDelegate setDownloadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
        }
    }];
}

//post
-(void)startAsyncHttpPostWithRequestInfo:(RequestInfo *)requestInfo
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    //1. 送给服务器的参数
    jsonDict =  [requestInfo getParamsDict];
    AFHTTPRequestOperationManager *afHttpManager = [self getLMS:requestInfo.localName];
    //2. 添加请求头信息
    [self createHttpHeader:afHttpManager headParams:requestInfo.getHeaderParams];
    
    NSLog(@"\n----------------------------------------\n请求地址：%@ \n----------------------------------------\n参数：%@ \n----------------------------------------",requestInfo.urlStr, jsonDict);
    //数据是josn 数据格式
    if (requestInfo.dataFormat == HttpResponseFormat_JOSN)
    {
        //1. 返回josn
        afHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager POST:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_Plist)
    {
        //2.plist
        afHttpManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager POST:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_XML)
    {
        //3.设置返回数据类型
        afHttpManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        //2. 请求
        afr[requestInfo.flagStr] = [afHttpManager POST:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else
    {
        NSLogError(@"post 请求暂时不支持返回这样的数据格式 %u", requestInfo.dataFormat);
        return;
    }
    
    //3. 上传进度
    [afr[requestInfo.flagStr] setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {

        if ([requestInfo.wmDelegate respondsToSelector:@selector(setUploadProgress:totalBytesWritten:totalBytesExpectedToWrite:andResquestInfo:)])
        {
            [requestInfo.wmDelegate setUploadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
        }
    }];
    //4. 下载进度
    [afr[requestInfo.flagStr] setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            if ([requestInfo.wmDelegate respondsToSelector:@selector(setDownloadProgress:totalBytesWritten:totalBytesExpectedToWrite:andResquestInfo:)])
            {
                [requestInfo.wmDelegate setDownloadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
            }
    }];
  
}


//head
-(void)startAsyncHttpHeadWithRequestInfo:(RequestInfo *)requestInfo
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    //1. 送给服务器的参数
    if (requestInfo.getParamsDict)
    {
        jsonDict =  [requestInfo getParamsDict];
    }
    AFHTTPRequestOperationManager *afHttpManager = [self getLMS:requestInfo.localName];
    //2. 添加请求头信息
    [self createHttpHeader:afHttpManager headParams:requestInfo.getHeaderParams];
    NSLog(@"\n----------------------------------------\n请求地址：%@ \n----------------------------------------\n参数：%@ \n----------------------------------------",requestInfo.urlStr, jsonDict);
    //数据是josn 数据格式
    if (requestInfo.dataFormat == HttpResponseFormat_JOSN)
    {
        //1. 返回josn
        afHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        [afHttpManager HEAD:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_Plist)
    {
        //2.plist
        afHttpManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
        [afHttpManager HEAD:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else if (requestInfo.dataFormat == HttpResponseFormat_XML)
    {
        //3.设置返回数据类型
        afHttpManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [afHttpManager HEAD:requestInfo.urlStr parameters:jsonDict success:^(AFHTTPRequestOperation *operation) {
            //请求成功，转换成json字典
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //请求失败
            [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
        }];
    }
    else
    {
        NSLogError(@"post 请求暂时不支持返回这样的数据格式 %u", requestInfo.dataFormat);
        return;
    }

}


//上传图片
-(void)startAsyncUploadImage:(RequestInfo *)requestInfo
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    //1. 送给服务器的参数
   
    jsonDict = [requestInfo getParamsDict];
    AFHTTPRequestOperationManager *afHttpManager = [self getLMS:requestInfo.localName];
    //2. 添加请求头信息
    [self createHttpHeader:afHttpManager headParams:requestInfo.getHeaderParams];
    
    afr[requestInfo.flagStr] = [afHttpManager POST:requestInfo.urlStr parameters:jsonDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:requestInfo.imgData name:@"file" fileName:@"icon.jpg" mimeType:@"image/*"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
        [requestInfo.wmDelegate connectionComplete:dic andFlagString:requestInfo.flagStr andResquestInfo:requestInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [requestInfo.wmDelegate connectionFailedWithError:error andResquestInfo:requestInfo];
    }];
    //3. 上传进度
    [afr[requestInfo.flagStr] setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        [requestInfo.wmDelegate setUploadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
    }];
    //4. 下载进度
    [afr[requestInfo.flagStr] setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        [requestInfo.wmDelegate setDownloadProgress:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite andResquestInfo:requestInfo];
    }];
}


///页面dealloc的时候，取消联网
-(void)cancelRequest
{
    for (NSString *key in afr)
    {
       AFHTTPRequestOperation *httpOperation = afr[key];
       [httpOperation cancel];
    }
    [afr removeAllObjects];
}

-(id)init
{
    if (self = [super init])
    {
        ems = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil];
        afr = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil];
        //4.返回图片
        //_manager.responseSerializer = [AFImageResponseSerializer serializer];
#pragma  检测网络连接情况
        /**
         AFNetworkReachabilityStatusUnknown          = -1,  // 未知
         AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
         AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
         */
        // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        // 检测网络连接的单例,网络变化时的回调方法
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
        {
            NSLog(@"  status   %ld", (long)status);
            
        }];
    }
    return self;
}


-(AFHTTPRequestOperationManager *)getLMS:(NSString *)localName
{
    if (!localName)
    {
        localName = @"main";
    }
    if (!ems[localName])
    {
        AFHTTPRequestOperationManager *pm = [[AFHTTPRequestOperationManager alloc] init];
        ems[localName] = pm;
        pm = [[AFHTTPRequestOperationManager alloc] init];
        pm.requestSerializer  = [AFJSONRequestSerializer serializer];
        pm.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"application/xml", nil];
    }
    return ems[localName];
}

#pragma mark - 添加请求体信息，可自定义
- (void)createHttpHeader:(AFHTTPRequestOperationManager *)afHttpManager headParams:(NSMutableDictionary *)headParams
{
    if (headParams)
    {
        for (NSString *key in headParams)
        {
            NSString *headValue = headParams[key];
            [afHttpManager.requestSerializer setValue:headValue forHTTPHeaderField:key];
        }
    }
}

@end
