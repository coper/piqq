//
//  AskRequestInfo.m
//  patient
//
//  Created by liyongli on 15/8/10.
//
//

#import "AskRequestInfo.h"
#import "NSString+Helper.h"

@implementation AskRequestInfo

/**
 * 自定义组织参数, 实际业务需求：每一个接口都需要token， sign，md5
 * @params paramsDict  业务逻辑请求的参数
 * 默认返回 业务传过来的参数
 */
- (NSMutableDictionary *)getParamsDict
{
    NSString *token             = kgetLocalData(kToken);
    NSString *uuid              = kgetLocalData(kUUID);
    NSString *privaFlagInfo     = privateFlagInfo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *initParams = [super getParamsDict];
    if (initParams)
    {
        NSEnumerator * enumeratorKey = [initParams keyEnumerator];
        for (NSString *key in enumeratorKey)
        {
            NSString *headValue     = initParams[key];
            [params setValue:headValue  forKey:key];
        }
    }
    NSString *md5String;
    NSString *_md5TargetString = [super getMD5TargetString];
    if (_md5TargetString)
    {
        md5String =[[_md5TargetString appendStr:token] appendStr:privaFlagInfo];
    }
    else
    {
        md5String=[token appendStr:privaFlagInfo];
    }
    NSLog(@" md5String %@ ",       md5String);
    NSString *privateKey;
    if (md5String)
    {
        privateKey        =   [NSString md5:md5String];
    }
    if (token)
    {
        [params setValue:token forKey:@"token"];
    }
    if (privateKey)
    {
        [params setValue:privateKey forKey:@"privateKey"];
    }
    if (uuid)
    {
        [params setValue:uuid forKey:@"uuid"];
    }
    return params;
}

#pragma  response  错误处理
/**
 * 集中http请求出错处理, 实际业务：每一个接口会返回错误码，不通的接口，返回的错误码，是相同的， 需要在一个地方集中处理。
 * 比如：服务器连接失败；参数错误...
 * @params codeNum   从服务器参数中解析的错误码
 */
-(void)errorCode:(int)codeNum flagStr:(NSString *) flagStr
{
    NSLog(@" errorCode 可以继承，重写这个方法 %d   %@", codeNum,  flagStr);
}

/**
 * http返回的错误信息
 * @params error   服务器返回的错误信息
 */
-(void)connectionFailedWithError:(NSError *)error
{
    NSLog(@" connectionFailedWithError 可以继承，重写这个方法");
    //kPE(kHttpError);
}
@end
