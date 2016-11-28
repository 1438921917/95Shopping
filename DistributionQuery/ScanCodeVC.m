//
//  ScanCodeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ScanCodeVC.h"
#import "ScanCodeCell.h"
#import "PublicTypeVC.h"
@interface ScanCodeVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)UIScrollView * bgScrollview;
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@end

@implementation ScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-44)];
    [self.view addSubview:_bgScrollview];
    if (_tagg==2) {
            self.title=@"修改";
    }else{
         self.backHomeBtn.hidden=YES;
        //搜索按钮
        UIButton*rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"发布" forState:0];
        [rightBtn setTitleColor:[UIColor redColor] forState:0];
        rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        rightBtn.frame=CGRectMake(0, 0, 50, 15);
        [rightBtn addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightBtnn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems=@[rightBtnn];
    }
    
    
   

    NSArray * arr1 =@[@"标题",@"名称",@"数量",@"型号",@"价格"];
    NSArray * arr2 =@[@"产地",@"成色",@"有限期"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    [self CreatTableView];
}
-(void)CreatTableView{
    _tableView=[[UITableView alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.bounces=NO;
    [_bgScrollview sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_bgScrollview,0)
    .heightIs(50*8+10);
    [self CreatXiangXiMessage];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_tableView addGestureRecognizer:tap];
    
}
-(void)tap:(UITapGestureRecognizer*)tap{
    NSLog(@"点击了");
    [_tableView endEditing:YES];
    [_view1 endEditing:YES];
    [_view2 endEditing:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_nameArray[section]  count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    ScanCodeCell * cell =[ScanCodeCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textfield.placeholder=@"请选择填写或者语音";
            cell.yuYinBtn.hidden=NO;
        }else if (indexPath.row==1){
            cell.textfield.placeholder=@"请填写产品名称";
        }else if (indexPath.row==2){
            cell.textfield.placeholder=@"请填写产品数量";
        }else if (indexPath.row==3){
            cell.textfield.placeholder=@"请填写产品型号";
        }else{
            cell.textfield.placeholder=@"请填写产品价格";
        }
    }else{
        cell.textfield.enabled=NO;
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
    return 5;
}


#pragma mark --详细信息
-(void)CreatXiangXiMessage{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_tableView,5)
    .heightIs(100);
    //详细信息
    UILabel * xiangXi =[UILabel new];
    xiangXi.text=@"详细信息";
    xiangXi.alpha=.7;
    xiangXi.font=[UIFont systemFontOfSize:16];
    [_view1 sd_addSubviews:@[xiangXi]];
    xiangXi.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,10)
    .heightIs(20);
    [xiangXi setSingleLineAutoResizeWithMaxWidth:200];
    //线
    UIView * lineView =[UIView new];
    lineView.backgroundColor=COLOR;
    //lineView.alpha=.7;
    [_view1 sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(_view1,0)
    .rightSpaceToView(_view1,0)
    .topSpaceToView(xiangXi,10)
    .heightIs(1);
    //语音按钮
    UIButton * yuyinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [yuyinBtn setImage:[UIImage imageNamed:@"fabu_yuyin"] forState:0];
    [_view1 sd_addSubviews:@[yuyinBtn]];
    yuyinBtn.sd_layout
    .rightSpaceToView(_view1,15)
    .centerYEqualToView(xiangXi)
    .widthIs(32/2)
    .heightIs(47/2);
    
    //uitextview
    UITextView * textView =[UITextView new];
    textView.delegate=self;
    textView.text=@"请您说出商品名称，编号";
    textView.font=[UIFont systemFontOfSize:14];
    [_view1 sd_addSubviews:@[textView]];
    textView.sd_layout
    .leftEqualToView(xiangXi)
    .topSpaceToView(lineView,5)
    .rightSpaceToView(_view1,15)
    .heightIs(80);
    [_view1 setupAutoHeightWithBottomView:textView bottomMargin:10];
    [self CreatView2];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    CGFloat rects = _bgScrollview.frame.size.height - (textView.frame.origin.y + textView.frame.size.height + 216 +50);
    
    NSLog(@"aa%f>>>%f",rects,(textView.frame.origin.y + textView.frame.size.height + 216 +50));
    
   // if (rects <= 0) {
        [_bgScrollview  setContentOffset:CGPointMake(0, 266) animated:YES];
    _bgScrollview.scrollEnabled=NO;
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            CGRect frame = _bgScrollview.frame;
//            
//            frame.origin.y = -rects;
//            
//            _bgScrollview.frame = frame;
//            
//        }];
    
   // }
    
    
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        CGRect frame = _bgScrollview.frame;
//        
//        frame.origin.y = 0.0;
//        
//        _bgScrollview.frame = frame;
//        
//    }];
     [_bgScrollview  setContentOffset:CGPointMake(0, 0) animated:YES];
    _bgScrollview.scrollEnabled=YES;
    
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --创建上传图片
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftEqualToView(_view1)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_view1,5);
    
    //详细信息
    UILabel * xiangXi =[UILabel new];
    xiangXi.text=@"上传图片";
    xiangXi.alpha=.7;
    xiangXi.font=[UIFont systemFontOfSize:16];
    [_view2 sd_addSubviews:@[xiangXi]];
    xiangXi.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,10)
    .heightIs(20);
    [xiangXi setSingleLineAutoResizeWithMaxWidth:200];
    NSArray * arr =@[@"铭牌照片",@"整机照片"];
    //上传图片2个btn
    for (int i =0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"fabu_pic"] forState:0];
        UILabel * label =[UILabel new];
        label.font=[UIFont systemFontOfSize:13];
        label.alpha=.6;
        label.text=arr[i];
        [_view2 sd_addSubviews:@[btn,label]];
        btn.sd_layout
        .leftSpaceToView(xiangXi,5+(91+30)*i)
        .topSpaceToView(xiangXi,0)
        .widthIs(186/2)
        .heightIs(140/2);
      
        label.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn,0)
        .heightIs(20);
        [label setSingleLineAutoResizeWithMaxWidth:120];
        [_view2 setupAutoHeightWithBottomView:label bottomMargin:10];
        
    }
     __weak __typeof(self)weakSelf = self;
    _view2.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.bgScrollview.contentSize=CGSizeMake(ScreenWidth, rect.origin.y+rect.size.height+10);
    };
    
}
#pragma mark --发布按钮
-(void)fabu{
    PublicTypeVC * vc =[PublicTypeVC new];
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
