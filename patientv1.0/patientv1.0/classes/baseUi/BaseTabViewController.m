//
//  BaseTabViewController.m
//  patientv1.0
//
//  Created by liyongli on 15/7/6.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "BaseTabViewController.h"
#import "MJRefresh.h"


@interface BaseTabViewController ()
{
    UIView *errorView;
    UIColor *bgColor;
}
@end

@implementation BaseTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nibsRegistered = NO;
     // Do any additional setup after loading the view from its nib.
    //初始化tabview
    [self createTabView];
    
    //分割线居中 左右顶到头
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorInset = insets;
    
    //初始化表格
    [self setupDataSource];
    // 添加下来加载
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.tableView headerBeginRefreshing];
}


-(void)headerRereshing
{
    //获取患者个人信息
}


//初始化tabview
-(void) createTabView
{
    self.tableView = [self startInitTabView];
    //设置协议，意思就是UITableView类的方法交给了tabView这个对象，让完去完成表格的一些设置操作
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //把tabView添加到视图之上
    [self.view addSubview:self.tableView];
    bgColor = [UIColor colorWithRed:[LibFun getColorByRGB:244.0] green:[LibFun getColorByRGB:244.0] blue:[LibFun getColorByRGB:244.0] alpha:1.000];
    self.tableView.backgroundColor = bgColor;
    
}

#pragma mark 自己添加的方法
-(void)setName:(NSString *)n
{
    if (![n isEqualToString:self.flagName])
    {
        self.flagName = [n copy];
    }
}

/**
 * 初始化tabView
 **/
-(UITableView *) startInitTabView
{
    CGRect frame=[self layoutTabView];
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    return tableView;
}

/**
 * 调整坐标tabView
 **/
-(CGRect) layoutTabView
{
    CGRect frame;
    frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return frame;
}

/**
 * 为tabView赋值
 **/
-(void) setupDataSource
{
    NSMutableArray *arraylist=[NSMutableArray arrayWithObjects:@"账户信息",@"服务条款",@"联系我们",@"版本信息",@"安全退出",nil];
    self.dataSource = arraylist;
}

//----------------------------
#pragma mark -实现协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
}

//设置单元格高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    //初始化cell并指定其类型，也可自定义cell
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel]setText:[self.dataSource objectAtIndex:indexPath.row]];//给cell添加数据
    [[cell textLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    //是否带剪头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"父类方法，需要重写");
}



-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"点击的顺序Select Button index: %d",indexPath.row);
    
}

///------------------------------------------------------------------
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}


////完成加载数据 请求服务器完成
-(void)doneLoadingTableViewData;
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doneLoadingTableViewData) object:nil];
    NSLog(@"doneLoadingTableViewData  当前是第%d页, 一共有%d页  ", self.currentIndex, self.totalPage);

}


#pragma mark -
/**
 * 是否有数据
 **/
-(void)isServerData:(BOOL) flg
{
    if (flg)
    {
        if (errorView)
        {
            [errorView removeFromSuperview];
            errorView = nil;
        }
    }
    else
    {
        if(errorView == nil)
        {
            errorView = [LibuiFun showErrorView:self.tableView errorMsg:@"暂无数据"];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupDataSource];
}



#pragma mark 默认的方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
