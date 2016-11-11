//
//  SetViewController.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SetViewController.h"
#import "MessageVC.h"
#import "MyRenZhengVC.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    [self CreatDataArr];//数据源
    [self CreatTableView];//表
}
#pragma mark --创建数据源
-(void)CreatDataArr{
    NSArray * arr1 =@[@"头像"];
    NSArray * arr2=@[@"个人资料",@"公司资料"];
    NSArray * arr3 =@[@"我要认证"];
    _dataArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];
}
#pragma mark --创建表
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_dataArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * imageview =[UIImageView new];
        imageview.tag=1;
        [cell sd_addSubviews:@[imageview]];
    }
    UIImageView * imageview =(UIImageView *)[cell viewWithTag:1];
    cell.textLabel.text=_dataArray[indexPath.section][indexPath.row];
    cell.textLabel.alpha=.7;
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        imageview.image=[UIImage imageNamed:@"my_photo"];
        imageview.sd_layout
        .rightSpaceToView(cell,20)
        .centerYEqualToView(cell)
        .widthIs(80)
        .heightIs(80);
        
    }else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        //更换头像
    }
    else if (indexPath.section==1) {
        //个人资料、公司资料
        MessageVC * vc =[MessageVC new];
        vc.tagg=indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==2){
        //我要认证
        MyRenZhengVC * vc =[MyRenZhengVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 100;
    }else{
       return 50;
    }
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
