//
//  AskLogManager.h
//  patientv1.0
//
//  Created by liyongli on 15/10/27.
//  Copyright © 2015年 ask. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AskLogManagerDelegate <NSObject>
@required
//请求服务完成
- (void)connectionComplete:(NSDictionary *)dic andFlagString:(NSString *)flagStr andResquestInfo:(id)requestInfo;
//请求服务器失败
- (void)connectionFailedWithError:(NSError *)error andResquestInfo:(id)requestInfo;
@end

@interface AskLogManager : NSObject
///创建请求manager
+ (AskLogManager *)shareManager;


/**
 *  1.1	app启动事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  type: 机型 String 类型
 *  net: 网络类型，2G,3G,4G,WIFI等 String 类型
 *  pro: 移动设备网络代码 String 类型
 *  v: app版本号 String 类型
 *  h: 分辨率,高 String 类型
 *  w: 分辨率,宽 String 类型
 *  os：操作系统 String 类型
 *  osv: 操作系统版本号 String 类型
 *  devClass：设备分类，比如iphone,ipad String 类型
 *  lon：经度，浮点数
 *  lat：纬度，浮点数
 *  mainVersion: 程序主版本
 */
-(void)appinit:(NSString *)appid
           dev:(NSString *)dev
             t:(NSString *)t
           uid:(NSString *)uid;
/**
 *  1.2	app关闭事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 */
-(void)appclose:(NSString *)appid
            dev:(NSString *)dev
              t:(NSString *)t
            uid:(NSString *)uid;

/**
 *  1.3	栏目点击事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)columnclick:(NSString *)appid
               dev:(NSString *)dev
                 t:(NSString *)t
               uid:(NSString *)uid
             cname:(NSString *)cname;

/**
 *  1.4	文章点击事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  bid: 推荐栏id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 *  rt: 取值范围online，testa，testb，String类型，非必填
 */
-(void)articleclick:(NSString *)appid
                dev:(NSString *)dev
                  t:(NSString *)t
                uid:(NSString *)uid
                aid:(NSString *)aid
                bid:(NSString *)bid
              cname:(NSString *)cname
                 rt:(NSString *)rt;
/**
 *  1.5	文章浏览事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)articleview:(NSString *)appid
               dev:(NSString *)dev
                 t:(NSString *)t
               uid:(NSString *)uid
               aid:(NSString *)aid
             cname:(NSString *)cname;

/**
 *  1.6	文章评论事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)comment:(NSString *)appid
           dev:(NSString *)dev
             t:(NSString *)t
           uid:(NSString *)uid
           aid:(NSString *)aid
         cname:(NSString *)cname;
/**
 *  1.7	文章分享事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)share:(NSString *)appid
         dev:(NSString *)dev
           t:(NSString *)t
         uid:(NSString *)uid
         aid:(NSString *)aid
       cname:(NSString *)cname;
/**
 *  1.8	文章收藏事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)favorite:(NSString *)appid
            dev:(NSString *)dev
              t:(NSString *)t
            uid:(NSString *)uid
            aid:(NSString *)aid
          cname:(NSString *)cname;
/**
 *  1.9	文章返回事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 */
-(void)articlereturn:(NSString *)appid
                 dev:(NSString *)dev
                   t:(NSString *)t
                 uid:(NSString *)uid
                 aid:(NSString *)aid
               cname:(NSString *)cname;

/**
 *  2.1	推荐请求事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  bid: 推荐栏id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 *  rule：推荐规则，String类型
 *  rule_view：是否返回推荐规则，String类型，“true”或”false”
 *  param_view：是否返回处理参数，String类型，”true”或”false”
 *	row：需要返回的文章数量，String类型
 *  attrs：需要返回的文章属性，String类型，多个属性用逗号分隔
 *  debug：是否为debug(debug模式返回处理步骤，中间结果，处理时间)，     String类型，“true”或”false”
 */
-(void)rec:(NSString *)appid
       dev:(NSString *)dev
         t:(NSString *)t
       uid:(NSString *)uid
       aid:(NSString *)aid
       bid:(NSString *)bid
     cname:(NSString *)cname
      rule:(NSString *)rule
 rule_view:(NSString *)rule_view
param_view:(NSString *)param_view
       row:(NSString *)row
     attrs:(NSString *)attrs
     debug:(NSString *)debug;


/**
 *  2.2	推荐返回事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  bid: 推荐栏id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 *  row：实际返回文章数，String类型
 *  debug：是否为debug，String类型，”true”或”false”
 *	total_time：推荐所消耗的总时间,单位为ms，String类型
 *	aids：返回文章id列表，String类型，多个id用逗号分隔
 *  rtype：取值范围online，testa，testb，可以为空，String类型
 */
-(void)recback:(NSString *)appid
           dev:(NSString *)dev
             t:(NSString *)t
           uid:(NSString *)uid
           aid:(NSString *)aid
           bid:(NSString *)bid
         cname:(NSString *)cname
           row:(NSString *)row
         debug:(NSString *)debug
    total_time:(NSString *)total_time
          aids:(NSString *)aids
         rtype:(NSString *)rtype;


/**
 *  2.3	推荐展示事件
 *  appid: 应用id
 *  dev: 移动设备id
 *  t:   事件发生时间，毫秒级
 *  uid: 用户id，会员用户才提交
 *  aid: 文章id，String类型
 *  cname: 点击栏目名称(层级表示，如： 财经,房产) String 类型
 *  row：实际返回文章数，String类型
 *  debug：是否为debug，String类型，”true”或”false”
 *  rtype：取值范围online，testa，testb，可以为空，String类型
 */
-(void)recshow:(NSString *)appid
           dev:(NSString *)dev
             t:(NSString *)t
           uid:(NSString *)uid
           aid:(NSString *)aid
         cname:(NSString *)cname
           row:(NSString *)row
         debug:(NSString *)debug
         rtype:(NSString *)rtype;
/**
 *  2.4	手工推荐事件
 *  k: appkey,也就是appid，如26001, String类型
 *  t: 事件发生时间，毫秒级
 *  aid: 文章id，String类型
 *  bid：推荐栏id, String类型
 *  etime：失效时间, 时间戳 long类型  
 */
-(void)article:(NSString *)k
             t:(long)t
           aid:(NSString *)aid
           bid:(NSString *)bid
         etime:(long)etime;

@end
