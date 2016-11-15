//
//  ZuiXinCaiGouVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ZuiXinCaiGouVC.h"
#import "ZuiXinCaiGouCell.h"
@interface ZuiXinCaiGouVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ZuiXinCaiGouVC
-(void)viewWillAppear:(BOOL)animated{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"最新采购";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTableView];
}
#pragma mark --创建主表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth, ScreenHeight-64-51) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    ZuiXinCaiGouCell * cell =[ZuiXinCaiGouCell cellWithTableView:tableView CellID:CellIdentifier];
    
    return cell;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 95;
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
