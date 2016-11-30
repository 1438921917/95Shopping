//
//  TongHangShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TongHangShangPinVC.h"
#import "YouZhiXianHuoCell.h"
@interface TongHangShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * selectAllBtn;//全选
@property(nonatomic,strong)UIButton * deleteBtn;//删除
@property (nonatomic,strong)NSMutableArray *deleteArr;
@end

@implementation TongHangShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _deleteArr=[NSMutableArray new];
    [self.rightBtn addTarget:self action:@selector(bbbnn:) forControlEvents:UIControlEventTouchUpInside];
    [self CreatTableView];
    
}


-(void)bbbnn:(UIButton*)button{
    NSLog(@"总管出来了");
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
//    
//    self.tableView.editing = !self.tableView.editing;
//    
//    if (self.tableView.editing) {
//        
//        [button setTitle:@"完成" forState:UIControlStateNormal];
//        
//    }else{
//        
//        [button setTitle:@"删除" forState:UIControlStateNormal];
//        
    //}
  
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
    .widthIs(220/2)
    .heightIs(23);
    [cell.chaKanBtn setBackgroundImage:[UIImage imageNamed:@"shoucnag_phone-1"] forState:0];
    [cell.chaKanBtn setTitle:@"4000238438" forState:0];
    cell.chaKanBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [cell.chaKanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [cell.chaKanBtn setTitleColor:[UIColor redColor] forState:0];
    cell.chaKanBtn.titleLabel.font=[UIFont systemFontOfSize:13];
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
