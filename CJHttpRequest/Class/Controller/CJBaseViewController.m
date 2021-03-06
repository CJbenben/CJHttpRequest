//
//  CJBaseViewController.m
//  CJHttpRequest
//
//  Created by ChenJie on 16/5/9.
//  Copyright © 2016年 ChenJie. All rights reserved.
//

#import "CJBaseViewController.h"

NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";

@interface CJBaseViewController ()<UITableViewDataSource, UITableViewDelegate>
/**
 *  获取表格数据、子类重写
 */
- (void)getDataWithTableView;

@end

@implementation CJBaseViewController
#pragma mark -
#pragma mark - 懒加载
- (JGProgressHUD *)HUD{
    if (_HUD == nil) {
        _HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        _HUD.textLabel.text = @"正在拼命加载中";
    }
    return _HUD;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)configSuperViewFrame:(CGRect)frame{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)addMJRefreshHeader:(BOOL)isHaveHeader addFooter:(BOOL)isHaveFooter{
    if (isHaveHeader) {
        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        
        [self.tableView.header beginRefreshing];
    }
    if (isHaveFooter) {
        [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    
}

- (void)headerRereshing{
    NSLog(@"子类需要重写getDataWithTableView、下拉刷新");
    [self.dataArray removeAllObjects];
    [self checkNetworkState];
    [self.tableView.footer endRefreshing];
}

- (void)footerRereshing{
    NSLog(@"子类需要重写getDataWithTableView、上拉加载");
    [self checkNetworkState];
}

- (void)checkNetworkState{
    if (!self.dataArray.count) {
        self.currPage = 1;
    }else{
        self.currPage ++;
    }
    [self getDataWithTableView];
}

- (void)getDataWithTableView{
    NSLog(@"子类需要重写加载数据");
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"子类需要重写Section");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"子类需要重写numberOfRowsInSection");
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"子类需要重写cellForRowAtIndexPath");
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HidenKeybord;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
