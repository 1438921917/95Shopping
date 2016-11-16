//
//  ZuiXinCaiGouVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ZuiXinCaiGouVC.h"
#import "ZuiXinCaiGouCell.h"
#import "XiangQingVC.h"
#import "HomeModel.h"
@interface ZuiXinCaiGouVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@end

@implementation ZuiXinCaiGouVC
-(void)viewWillAppear:(BOOL)animated{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _dataArray=[NSMutableArray new];
    self.title=@"最新采购";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatTableView];
}
#pragma mark --数据解析
-(void)shuJuJieXiDataPage:(NSString*)page {
    //GongQiu 1优质现货 2最新采购
    
    [Engine tejiaZhuanQuLieBiaoHangYeID:@"0" DiQu:@"0" GuanJianZi:@"0" Page:page PageSize:@"10" GongQiu:@"2" TeJia:@"0" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            
            if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"Item3没有数据"];
            }else{
                NSArray * array =[dic objectForKey:@"Item3"];
                NSMutableArray * array2=[NSMutableArray new];
                for (NSDictionary * dicc in array) {
                    HomeModel * md =[[HomeModel alloc]initWithYouZhiXianHuoDic:dicc];
                    [array2 addObject:md];
                }
                if (self.myRefreshView == _tableView.header) {
                    _dataArray = array2;
                    _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                }else if(self.myRefreshView == _tableView.footer){
                    [_dataArray addObjectsFromArray:array2];
                }
                
                
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            [_myRefreshView endRefreshing];
        }
    } error:^(NSError *error) {
        
    }];
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
    
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self shuJuJieXiDataPage:@"1" ];
    
        
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了");
        _AAA=_AAA+1;
        [self shuJuJieXiDataPage:[NSString stringWithFormat:@"%d",_AAA]];
        
        
    }];
    _tableView.footer.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    ZuiXinCaiGouCell * cell =[ZuiXinCaiGouCell cellWithTableView:tableView CellID:CellIdentifier];
    HomeModel * md =_dataArray[indexPath.row];
    cell.model=md;
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     HomeModel * md =_dataArray[indexPath.row];
    XiangQingVC * vc =[XiangQingVC new];
    vc.tagg=2;//2标注是最新采购的详情界面
    vc.messageID=md.messageID;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[ZuiXinCaiGouCell class] contentViewWidth:[ToolClass  cellContentViewWith]];;
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
