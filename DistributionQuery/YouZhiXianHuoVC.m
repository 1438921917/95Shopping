//
//  YouZhiXianHuoVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YouZhiXianHuoVC.h"
#import "YouZhiXianHuoCell.h"
#import "XiangQingVC.h"
@interface YouZhiXianHuoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end
@implementation YouZhiXianHuoVC
-(void)viewWillAppear:(BOOL)animated{
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
     self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   self.view.backgroundColor=[UIColor whiteColor];
    // [self.navigationItem setTitle:@"优质现货"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"优质现货";
   // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:TITLE_FOUNT]}];
    [self CreatTableView];
}

#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
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
    YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
    [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XiangQingVC * vc =[XiangQingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

#pragma mark --立即查看
-(void)chaKan:(UIButton*)btn{
    XiangQingVC * vc =[XiangQingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
