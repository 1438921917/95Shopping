//
//  MessageVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray*nameArray;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tagg==0) {
       self.title=@"个人资料";
    }else{
        self.title=@"公司资料";
    }
    
    [self CreatNameArr];
    [self CreatTableView];
}
#pragma mark --创建数据源
-(void)CreatNameArr{
    NSArray * arr1;
    NSArray * arr2;
    if (_tagg==0) {
         arr1 =@[@"昵称",@"真实姓名"];
         arr2 =@[@"所在地区"];
    }else{
        arr1 =@[@"公司名字",@"经营行业"];
        arr2 =@[@"所在场所"];
        
    }
    
    
   
   
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
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
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    MessageCell * cell =[MessageCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (_tagg==0) {
        //个人资料
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                 cell.textfield.placeholder=@"请填写昵称";
            }else{
                 cell.textfield.placeholder=@"请填写姓名";
            }
           
        }else{
            cell.textfield.enabled=NO;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
    }else{
        //公司资料
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                cell.textfield.placeholder=@"请填写公司名字";
                cell.textfield.sd_layout.widthIs(150);
            }else{
                cell.textfield.placeholder=@"请填写姓名";
            }
            
        }else{
           cell.textfield.enabled=NO;
           cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }

        
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
