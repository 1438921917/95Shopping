//
//  TuoGuanVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TuoGuanVC.h"
#import "GuanLiCell.h"
#import "DaShangJingJiRenVC.h"
@interface TuoGuanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation TuoGuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self CreatTableView];
}
#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44+5, ScreenWidth, ScreenHeight-64-44-5) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    GuanLiCell * cell =[GuanLiCell cellWithTableView:tableView CellID:CellIdentifier];
     cell.indexPath=indexPath;
    cell.xiugaiBtn.tag=indexPath.row;
    cell.tejiaBtn.tag=indexPath.row;
    [self btnAddDianJi:cell];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190;
}
#pragma mark --4个按钮点击状态
-(void)btnAddDianJi:(GuanLiCell*)cell{
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(UIButton *btn,NSIndexPath *indexPath) {
            NSLog(@"输出%lu",btn.tag);
            if (btn.tag==0) {
                //刷新
            }else if (btn.tag==1){
                //下架
            }else if (btn.tag==2){
                //置顶
            }else{
                //成交
                UIAlertController * actionview =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
               
                UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"          自己成交 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];;
                UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"          托管成交 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    DaShangJingJiRenVC * vc =[DaShangJingJiRenVC new];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                [actionview addAction:action1];
                [actionview addAction:action2];
                 [self presentViewController:actionview animated:YES completion:nil];
            }
            
        }];
        
    }
    //修改
    [cell.xiugaiBtn addTarget:self action:@selector(xiuGaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    //特价
    [cell.tejiaBtn addTarget:self action:@selector(teJiaBtnn:) forControlEvents:UIControlEventTouchUpInside];

}

//修改
-(void)xiuGaiBtn:(UIButton*)btn{
    ScanCodeVC * vc =[ScanCodeVC new];
    vc.tagg=2;
    [self.navigationController pushViewController:vc animated:YES];

}
//特价
-(void)teJiaBtnn:(UIButton*)btn{
    
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
