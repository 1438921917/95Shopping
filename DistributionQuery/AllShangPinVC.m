//
//  AllShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AllShangPinVC.h"
#import "JinDianChaKanCell.h"
@interface AllShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation AllShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self dataShuJuPage:@"1"];
    if (_tagg==11) {
        self.title=@"所有商品";
    }else if (_tagg==12){
        self.title=@"新品上架";
    }else if (_tagg==13){
        self.title=@"经典旧货";
    }else if (_tagg==14){
        self.title=@"优质好货";
    }
    [self CreatTabelView];
}

-(void)dataShuJuPage:(NSString*)page{
    [Engine dianPuChanPinMessageID:_messageID Cid:[NSString stringWithFormat:@"%lu",_cidd] Page:page success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
}

-(void)CreatTabelView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
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
    JinDianChaKanCell * cell =[JinDianChaKanCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.tag=indexPath.row;
    //[cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    cell.chaKanBtn.hidden=YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
