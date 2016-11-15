//
//  MyselfPublicVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyselfPublicVC.h"
#import "MyselfPublicCell.h"
#import "YuYinPublicVC.h"
@interface MyselfPublicVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)UIButton * publicBtn;
@end

@implementation MyselfPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatNameArray];
    [self CreatTableView];
}
#pragma mark --创建数据源
-(void)CreatNameArray{
    NSArray * arr1 =@[@"标题",@"数量",@"价格"];
    NSArray * arr2 =@[@"所属行业",@"所在地"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    _view3=[UIView new];
    _view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_view3];
}



#pragma mark --创建表
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 64+50, ScreenWidth, 5*50+5+5);
    _tableView.bounces=NO;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
    [self CreatView3];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_tableView addGestureRecognizer:tap];
    


}
-(void)tap:(UITapGestureRecognizer*)tap{
    NSLog(@"点击了");
    [_tableView endEditing:YES];
}
#pragma mark --创建图片
-(void)CreatView3{
    _view3.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_tableView,5)
    .heightIs(120);
    //上传图片
    UILabel * nameLabel =[[UILabel alloc]init];
    nameLabel.text=@"上传图片";
    nameLabel.alpha=.7;
    nameLabel.font=[UIFont systemFontOfSize:16];
    [_view3 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view3,15)
    .topSpaceToView(_view3,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    //相机按钮
    UIButton * camaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [camaBtn setImage:[UIImage imageNamed:@"fabu_pic"] forState:0];
    [_view3 sd_addSubviews:@[camaBtn]];
    camaBtn.sd_layout
    .leftSpaceToView(nameLabel,25)
    .topSpaceToView(nameLabel,0)
    .widthIs(186/2)
    .heightIs(140/2);
    //创建Label
    UILabel * label =[UILabel new];
    label.text=@"温馨提示:\n上传产品照片,\n有助于详细展示产品！";
    label.numberOfLines=0;
    label.alpha=.6;
    label.textAlignment=1;
    label.font=[UIFont systemFontOfSize:13];
    [_view3  sd_addSubviews:@[label]];
    label.sd_layout
    .rightSpaceToView(_view3,20)
    .centerYEqualToView(camaBtn)
    .autoHeightRatio(0);
    [label setSingleLineAutoResizeWithMaxWidth:100];
    
    //立即发布
    _publicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_publicBtn setImage:[UIImage imageNamed:@"fabu_bt"] forState:0];
    [_publicBtn addTarget:self action:@selector(fabu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[_publicBtn]];
    _publicBtn.sd_layout
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .topSpaceToView(_view3,40)
    .heightIs(40);
    
}

#pragma  mark --发布按钮
-(void)fabu:(UIButton*)btn{
    NSLog(@"你点击发布了");
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_nameArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    MyselfPublicCell * cell =[MyselfPublicCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textField.placeholder=@"请选择填写或者语音";
            cell.yuYinBtn.hidden=NO;
            [cell.yuYinBtn addTarget:self action:@selector(yuyinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if (indexPath.row==1){
            cell.textField.placeholder=@"请填写产品数量";
        }else{
            cell.textField.placeholder=@"请填写产品价格";
        }
    }else{
        cell.textField.hidden=YES;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 5;
}

-(void)yuyinBtnClick:(UIButton*)btn{
    YuYinPublicVC * vc =[[YuYinPublicVC alloc]init];
    vc.tagg=0;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
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
