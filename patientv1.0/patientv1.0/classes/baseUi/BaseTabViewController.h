//
//  BaseTabViewController.h
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "BaseController.h"
#import "LibFun.h"
#import "LibuiFun.h"


@interface BaseTabViewController : BaseController<UITableViewDelegate,UITableViewDataSource>
{

}

@property(strong,nonatomic)NSMutableArray   *dataSource;
@property(strong,nonatomic)UITableView      *tableView;
@property(strong,nonatomic)NSMutableArray   *tmpDataArray;
@property(nonatomic, assign)BOOL             nibsRegistered;
@property (copy, nonatomic)NSString         *flagName;

//一共页码
@property                   int             totalPage;
//当前是第几页
@property                   int             currentIndex;
//一页显示多个item
@property                   int             totalCount;


-(UITableView *) startInitTabView;
-(CGRect) layoutTabView;

//请求服务器完成
-(void)doneLoadingTableViewData;
//没有数据
- (void)isServerData:(BOOL) flg;

@end
