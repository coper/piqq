//
//  RequestInfo.m
//
//  Created by family on 15/7/27.
//  Copyright (c) 2015年 李永利. All rights reserved.
//

#import "RequestInfo.h"

@implementation RequestInfo
{
    NSMutableDictionary *_headerParams;
    NSMutableDictionary *_paramsDict;
    NSString            *_md5TargetString;

}

/**
 * 自定义组织参数, 实际业务需求：每一个接口都需要token， sign，md5
 * @params paramsDict  业务逻辑请求的参数
 * 默认返回 业务传过来的参数
 */
-(void) setParamKey:(NSString *)paramKey paramValue:(NSString *)paramValues
{
    if (paramKey && paramValues)
    {
        if ( _paramsDict == NULL )
        {
            _paramsDict = [[NSMutableDictionary alloc] init];
        }
        [_paramsDict setValue:paramValues forKey:paramKey];
        
        if ([NSString stringWithFormat:@"%@",paramValues].length >500)
        {
            return;
        }
        if(_md5TargetString == nil)
        {
           _md5TargetString = [[NSMutableString alloc] initWithString:@""];
        }
//        _md5TargetString = [_md5TargetString appendStr:paramValues];
    }
}

/**
 * 添加http Head
 * @params headKey      key
 * @params headValues   value
 */
-(void)setHeaderField:(NSString *)headKey headValue:(NSString *)headValues
{
    if (_headerParams == nil)
    {
        _headerParams =  [[NSMutableDictionary alloc] init];
    }
    [_headerParams setValue:headValues forKey:headKey];
}

/**
 * 返回 head 参数
 * @params NSDictionary   返回http header
 */
-(NSMutableDictionary *)getHeaderParams
{
    return _headerParams;
}

/**
 * 自定义组织参数, 实际业务需求：每一个接口都需要token， sign，md5
 * @params paramsDict  业务逻辑请求的参数
 * 默认返回 业务传过来的参数
 */
- (NSMutableDictionary *)getParamsDict
{
    NSLog(@" getParamsDict 可以继成，重写这个方法");
    return  _paramsDict;
}

- (NSString *)getMD5TargetString
{
    return _md5TargetString;
}

#pragma  response  错误处理
/**
 * 集中http请求出错处理, 实际业务：每一个接口会返回错误码，不通的接口，返回的错误码，是相同的， 需要在一个地方集中处理。
 * 比如：服务器连接失败；参数错误...
 * @params codeNum   从服务器参数中解析的错误码
 */
-(void)errorCode:(int)codeNum flagStr:(NSString *) flagStr
{
    NSLog(@" errorCode 可以继承，重写这个方法");
}

/**
 * http返回的错误信息
 * @params error   服务器返回的错误信息
 */
-(void)connectionFailedWithError:(NSError *)error
{
    NSLog(@" connectionFailedWithError 可以继承，重写这个方法");
}

@end
