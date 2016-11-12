//
//  QiuGouShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "QiuGouShangPinVC.h"
#import "YouZhiXianHuoCell.h"
@interface QiuGouShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation QiuGouShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatTableView];
}
#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
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
    cell.chaKanBtn.sd_layout
    .widthIs(60)
    .heightIs(23);
    [cell.chaKanBtn setBackgroundImage:[UIImage imageNamed:@"shoucnag_bt"] forState:0];
    // [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
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
