//
//  QiuGouShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "QiuGouShangPinVC.h"
#import "YouZhiXianHuoCell.h"
#import "HomeModel.h"
@interface QiuGouShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)UIButton * selectAllBtn;//全选
@property(nonatomic,strong)UIButton * deleteBtn;//删除
@property (nonatomic,strong)NSMutableArray *deleteArr;
@end

@implementation QiuGouShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // _AAA=1;
    _dataArray=[NSMutableArray new];
    _deleteArr=[NSMutableArray new];
    [self CreatTableView];
    [self.rightBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectedBtn:(UIButton*)button{
    self.tableView.allowsMultipleSelectionDuringEditing=YES;
    self.tableView.editing=!self.tableView.editing;
    
}

-(void)getQiuGouData:(NSString*)page{
    [Engine getMessageJiLuType:@"2" Page:page PageSize:@"10" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            if ([dic objectForKey:@"Item3"]==[NSNull null] ||[[dic objectForKey:@"Item3"] count]==0 ) {
                 [LCProgressHUD showMessage:@"Item3为空"];
            }else{
                NSArray * item3Ar =[dic objectForKey:@"Item3"];
                 NSMutableArray * array2=[NSMutableArray new];
                for (NSDictionary * dicc in item3Ar) {
                    HomeModel * md =[[HomeModel alloc]initWithCaiGouDic:dicc];
                    [array2 addObject:md];
                }
                
                if (self.myRefreshView == _tableView.header) {
                    _dataArray = array2;
                    _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                }else if(self.myRefreshView == _tableView.footer){
                    [_dataArray addObjectsFromArray:array2];
                }
            }
             [_myRefreshView  endRefreshing];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            [_myRefreshView  endRefreshing];
        }
    } error:^(NSError *error) {
         [_myRefreshView  endRefreshing];
    }];
}


#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
     _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self getQiuGouData:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;//网上拉第一下的时候 展示的应该是第二页数据
        NSLog(@"页数%d",_AAA);
      [self getQiuGouData:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    _tableView.footer.hidden = YES;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.model=_dataArray[indexPath.row];
    cell.imagedan.hidden=YES;
    cell.chaKanBtn.sd_layout
    .widthIs(60)
    .heightIs(23);
    [cell.chaKanBtn setBackgroundImage:[UIImage imageNamed:@"shoucnag_bt"] forState:0];
    // [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[YouZhiXianHuoCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
