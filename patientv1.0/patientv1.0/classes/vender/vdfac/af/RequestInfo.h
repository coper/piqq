//
//  RequestInfo.h
//  可以根据不同的业务需求继承，重写。
//  Created by family on 15/7/27.
//  Copyright (c) 2015年 李永利. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDefine.h"

//返回的数据格式
typedef enum HttpResponseFormat
{
    HttpResponseFormat_JOSN,
    HttpResponseFormat_Plist,
    HttpResponseFormat_XML,
    HttpResponseFormat_Bin,
} HttpResponseFormat;

@interface RequestInfo : NSObject

//协议
@property (assign,nonatomic)    id<WmHttpRequeestDelegate>wmDelegate;

//返回的数据格式
@property (assign,nonatomic)    HttpResponseFormat  dataFormat;
//请求的URL
@property (copy,nonatomic)      NSString            *urlStr;
//上传图片，图片的值
@property (strong,nonatomic)    NSData              *imgData;
//每个请求，请求标识  比如： 同一个类里来2个请求，根据这个标志来区分开
@property (copy,nonatomic)      NSString            *flagStr;
//创建不同的AFHTTPRequestOperationManager，一般情况不需要赋值，默认的都行。
@property (copy,nonatomic)      NSString            *localName;








/**
 * 集中http请求出错处理, 实际业务：每一个接口会返回错误码，不通的接口，返回的错误码，是相同的， 需要在一个地方集中处理。 
 * 比如：服务器连接失败；参数错误...
 * @params codeNum   从服务器参数中解析的错误码
 */
-(void)errorCode:(int)codeNum flagStr:(NSString *) flagStr;

/**
 * http返回的错误信息
 * @params error   服务器返回的错误信息
 */
-(void)connectionFailedWithError:(NSError *)error;

/**
 * 添加http Head
 * @params headKey      key
 * @params headValues   value
 */
-(void)setHeaderField:(NSString *)headKey headValue:(NSString *) headValues;

/**
 * 返回 head 参数
 * @params NSDictionary   返回http header
 */
-(NSMutableDictionary *) getHeaderParams;


/**
 * 自定义组织参数, 实际业务需求：每一个接口都需要token， sign，md5
 * @params paramsDict  业务逻辑请求的参数
 * 默认返回 业务传过来的参数
 */
- (void)setParamKey:(NSString *)paramKey paramValue:(NSString *) paramValues;

/**
 * 返回 http参数 参数
 * @params NSDictionary   返回http 参数值
 */
- (NSMutableDictionary *)getParamsDict;

- (NSString *)getMD5TargetString;




@end
