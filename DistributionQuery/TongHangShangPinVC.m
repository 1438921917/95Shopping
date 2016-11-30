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
    [self CreatAllselectBtn];
}

#pragma mark --创建全选和删除
-(void)CreatAllselectBtn{
    _selectAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectAllBtn.frame = CGRectMake(0, ScreenHeight-40, ScreenWidth/2, 40);
    _selectAllBtn.backgroundColor=[UIColor greenColor];
    [_selectAllBtn setTitleColor:[UIColor redColor] forState:0];
    [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectAllBtn];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     _deleteBtn.backgroundColor=[UIColor greenColor];
     [_deleteBtn setTitleColor:[UIColor redColor] forState:0];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn.frame = CGRectMake(ScreenWidth/2,ScreenHeight-40, ScreenWidth/2, 40);
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteBtn];
    
   
}



//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
        
        //真正项目中做删除
        
        //1.将表中的cell删除
        
        //2.将本地的数组中数据删除
        
        //3.最后将服务器端的数据删除
        
    }
}
//选择你要对表进行处理的方式  默认是删除方式

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // [self.deleteArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
    
}


















-(void)bbbnn:(UIButton*)button{
    NSLog(@"总管出来了");
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.tableView.editing = !self.tableView.editing;
    
    if (self.tableView.editing) {
        
        [button setTitle:@"完成" forState:UIControlStateNormal];
        
    }else{
        
        [button setTitle:@"删除" forState:UIControlStateNormal];
        
    }
    
  
}

#pragma mark --全选
-(void)selectAllBtnClick:(UIButton *)button {
    
    //    [self.tableView reloadData];
    
//    for (int i = 0; i < self.dataArray.count; i ++) {
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        
//        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//        
//        [self.deleteArr addObjectsFromArray:self.dataArray];
//        
//    }
    
    NSLog(@"self.deleteArr:%@", self.deleteArr);
    
}
#pragma mark --删除按钮
- (void)deleteClick:(UIButton *) button {
    
    if (self.tableView.editing) {
        
        //删除
       // [self.dataArray removeObjectsInArray:self.deleteArr];
        
        [self.tableView reloadData];
        
    }
    
    else return;
    
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
