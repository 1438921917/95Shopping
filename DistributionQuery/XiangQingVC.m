//
//  XiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiangQingVC.h"
#import "YouZhiXianHuoCell.h"
#import "XiangQingModel.h"
#import "JinDianChaKanVC.h"
@interface XiangQingVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
     SDCycleScrollView *cycleScrollView2;
}
@property(nonatomic,strong)UIScrollView * bgScrollView;//背景的滚动试图
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * upBtn;
@property(nonatomic,strong)UIButton * nextBtn;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation XiangQingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.title=@"详情页";
    _dataArray=[NSMutableArray new];
    [self jieXiXiangQingYeData];
    [self CreatBgScrollView];//背景界面
   // [self CreatView1];//轮播图
//    [self CreatView2];//具体参数
//    [self CreatView3];//详细信息
//    [self CreatTwoBtn];//2个按钮
//    [self CreatView4];//猜你喜欢表格
}

#pragma mark --解析详情页的数据
-(void)jieXiXiangQingYeData{
    //@"7458" _messageID
    if (_tagg==1 || _tagg==3) {
        //现货详情
        [Engine tableViewXiangQingJieMianMessageID:_messageID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"])
            {
                if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                    [LCProgressHUD showMessage:@"Item3无数据"];
                }else{
                    NSDictionary * dicc =[dic objectForKey:@"Item3"];
                    XiangQingModel * md =[[XiangQingModel alloc]initWithXiangXiDic:dicc];
                    [_dataArray addObject:md];
                }
                [self CreatView1];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }else if (_tagg==2){
        //最新采购详情
        [Engine zuiXinCaiGouXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSDictionary * itemDicr=[dic objectForKey:@"Item2"];
                XiangQingModel * md =[[XiangQingModel alloc]initWithZuiXinCiGouXiangXiDic:itemDicr];
                [_dataArray addObject:md];
                [self CreatView1];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item3"]];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
}


#pragma mark --创建背景的滚动试图
-(void)CreatBgScrollView{
    _bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bgScrollView.backgroundColor=COLOR;
    //_bgScrollView.delegate=self;
    //_bgScrollView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight+200);
    [self.view addSubview:_bgScrollView];
}
#pragma mark --创建view1轮播图
-(void)CreatView1{
    NSLog(@"输出看看结果%lu",_dataArray.count);
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [_bgScrollView addSubview:_view1];
    _view1.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .topSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0);
   
   XiangQingModel * md =_dataArray[0];
    NSArray * arr =@[md.imagename];
    //轮播图可以通过URL来获取图片的大小，到时候在改尺寸
    cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 540*ScreenWidth/1080) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_view1 addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
    });
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        
    };

   //标题
    UILabel * titleLable =[UILabel new];
    titleLable.text=md.titleName;//@"出售183*7米的青岛产球磨机";
    titleLable.numberOfLines=0;
    [_view1 sd_addSubviews:@[titleLable]];
    titleLable.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(cycleScrollView2,15)
    .autoHeightRatio(0);
    [titleLable setSingleLineAutoResizeWithMaxWidth:300];
    //五角星
    UIButton *btnXing =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnXing setImage:[UIImage imageNamed:@"xiangqing_shou"] forState:UIControlStateNormal];
    [btnXing setImage:[UIImage imageNamed:@"xiangqing_shou_click"] forState:UIControlStateSelected];
    [btnXing addTarget:self action:@selector(shouCang:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 sd_addSubviews:@[btnXing]];
    btnXing.sd_layout
    .rightSpaceToView(_view1,20)
    .centerYEqualToView(titleLable)
    .widthIs(44/2)
    .heightIs(42/2);
    
    //价格
    UILabel * priceLabel =[UILabel new];
    priceLabel.text=[NSString stringWithFormat:@"¥%@万",md.priceName];//@"¥11.5万";
    priceLabel.textColor=[UIColor redColor];
    [_view1 sd_addSubviews:@[priceLabel]];
    priceLabel.sd_layout
    .leftEqualToView(titleLable)
    .heightIs(20)
    .topSpaceToView(titleLable,10);
    [priceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //编号
    UILabel * bianHao =[UILabel new];
    bianHao.text=[NSString stringWithFormat:@"编号  %@号",md.bianHaoName];//@"编号  001号";
    bianHao.alpha=.5;
    bianHao.font=[UIFont systemFontOfSize:13];
    [_view1 sd_addSubviews:@[bianHao]];
    bianHao.sd_layout
    .leftSpaceToView(priceLabel,20)
    .centerYEqualToView(priceLabel)
    .heightIs(20);
    [bianHao setSingleLineAutoResizeWithMaxWidth:200];
    
    //进店查看
    UIButton * chaKanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chaKanBtn setImage:[UIImage imageNamed:@"xiangqing_bt"] forState:0];
    [chaKanBtn addTarget:self action:@selector(chakanBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_view1 sd_addSubviews:@[chaKanBtn]];
    chaKanBtn.sd_layout
    .rightEqualToView(btnXing)
    .centerYEqualToView(priceLabel)
    .widthIs(128/2)
    .heightIs(44/2);
    
    //颜色的view
    UIView * viewColor =[UIView new];
    viewColor.backgroundColor=COLOR;
    [_view1 sd_addSubviews:@[viewColor]];
    viewColor.sd_layout
    .leftEqualToView(priceLabel)
    .rightEqualToView(chaKanBtn)
    .heightIs(40)
    .topSpaceToView(priceLabel,10);
    //电话图标
    UIImageView * phoneImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangqing_phone"]];
    [viewColor sd_addSubviews:@[phoneImage]];
    phoneImage.sd_layout
    .leftSpaceToView(viewColor,5)
    .centerYEqualToView(viewColor)
    .widthIs(28/2)
    .heightIs(28/2);
    //电话号码
    UILabel * phoneNumberLable =[UILabel new];
    phoneNumberLable.text=[NSString stringWithFormat:@"联系电话 %@",md.phoneName];//@"联系电话 400-1234-360";
    phoneNumberLable.alpha=.8;
    phoneNumberLable.font=[UIFont systemFontOfSize:13];
    [viewColor sd_addSubviews:@[phoneNumberLable]];
    phoneNumberLable.sd_layout
    .leftSpaceToView(phoneImage,10)
    .centerYEqualToView(viewColor)
    .heightIs(20);
    [phoneNumberLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //立即拨打
    UIButton * bodaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [bodaBtn setTitle:@"立即拨打" forState:0];
    bodaBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [bodaBtn setTitleColor:[UIColor redColor] forState:0];
    [viewColor sd_addSubviews:@[bodaBtn]];
    bodaBtn.sd_layout
    .rightSpaceToView(viewColor,0)
    .centerYEqualToView(viewColor)
    .widthIs(70)
    .heightIs(20);
    if (_tagg==2) {
        //最新采购
        viewColor.hidden=YES;
        [chaKanBtn setImage:[UIImage imageNamed:@"xiangqing_bt1(1)"] forState:0];
        [_view1 setupAutoHeightWithBottomView:chaKanBtn bottomMargin:10];

    }else if (_tagg==3){
        //店铺在进详情
        chaKanBtn.hidden=YES;
        [_view1 setupAutoHeightWithBottomView:viewColor bottomMargin:10];
    }
    else{
        [_view1 setupAutoHeightWithBottomView:viewColor bottomMargin:10];

    }
       [self CreatView2];//具体参数
}


-(void)shouCang:(UIButton*)btn{
    if (_tagg==2) {
        //代表最新采购详情页
        btn.selected=!btn.selected;
         NSLog(@"点击的是最新采购详情");
        NSLog(@"messageID=%@",_messageID);
        //Type 1.浏览 2.收藏 3.关注
        [Engine addMessageJiLuMessageID:_messageID Type:@"2" success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                btn.selected=YES;
                 [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        NSLog(@"点击的是优质现货详情");
    }
}

#pragma mark --进店查看按钮
-(void)chakanBtn:(UIButton*)btn{
    if (_tagg==2) {
        //短信联系
       //  [LCProgressHUD showMessage:@"点击了短信联系"];
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你好，我对你的求购一台二手设备感兴趣，请电话联系我15023573953" preferredStyle:UIAlertControllerStyleAlert];
        
        
       
        
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"自己编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [actionView addAction:action1];
        [actionView addAction:action2];
        [self presentViewController:actionView animated:YES completion:nil];
        
    }else{
        //进店查看
        JinDianChaKanVC * vc =[JinDianChaKanVC new];
        vc.tagg=1;
        vc.messageID=_dianPuID;
        NSLog(@"输出店铺ID=%@",_dianPuID);
        [self.navigationController pushViewController:vc animated:YES];

    }
}

#pragma mark --创建view2具体参数
-(void)CreatView2{
     XiangQingModel * md =_dataArray[0];
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view1,10)
    .heightIs(300);
    //数线
    UIImageView * lineView =[UIImageView new];
    lineView.image=[UIImage imageNamed:@"xianqing_line"];
    [_view2 sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,15)
    .widthIs(4)
    .heightIs(16);
    //titlename
    UILabel * titleName =[UILabel new];
    titleName.text=@"具体参数";
    titleName.alpha=.7;
    titleName.font=[UIFont systemFontOfSize:16];
    [_view2 sd_addSubviews:@[titleName]];
    titleName.sd_layout
    .leftSpaceToView(lineView,5)
    .centerYEqualToView(lineView)
    .heightIs(15);
    [titleName setSingleLineAutoResizeWithMaxWidth:150];
    
    //型号
    UILabel * xingHaoLabel =[UILabel new];
    xingHaoLabel.text=[NSString stringWithFormat:@"型号   %@",md.xinagHaoName];//@"型号   G5h520";
    xingHaoLabel.font=[UIFont systemFontOfSize:15];
    xingHaoLabel.alpha=.6;
    [_view2 sd_addSubviews:@[xingHaoLabel]];
    xingHaoLabel.sd_layout
    .leftEqualToView(titleName)
    .topSpaceToView(titleName,25)
    .heightIs(20);
    [xingHaoLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //产地
    UILabel * chanDiLabel =[UILabel new];
    chanDiLabel.text=[NSString stringWithFormat:@"产地   %@",md.chanDiName];//@"产地   河北-石家庄";
    chanDiLabel.textAlignment=0;
    chanDiLabel.font=[UIFont systemFontOfSize:15];
    chanDiLabel.alpha=.6;
    [_view2 sd_addSubviews:@[chanDiLabel]];
    chanDiLabel.sd_layout
    .rightSpaceToView(_view2,20)
    .centerYEqualToView(xingHaoLabel)
    .heightRatioToView(xingHaoLabel,1);
    [chanDiLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //数量
    UILabel * numberLabel =[UILabel new];
    numberLabel.text=[NSString stringWithFormat:@"数量   %@台",md.shuLiangName];//@"数量   50台";
    numberLabel.font=[UIFont systemFontOfSize:15];
    numberLabel.alpha=.6;
    [_view2 sd_addSubviews:@[numberLabel]];
    numberLabel.sd_layout
    .leftEqualToView(xingHaoLabel)
    .heightRatioToView(xingHaoLabel,1)
    .topSpaceToView(xingHaoLabel,15);
    [numberLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //所在地
    UILabel * addressLabel =[UILabel new];
    addressLabel.text=[NSString stringWithFormat:@"所在地   %@",md.suozaiDiName];//@"所在地   山东-济南";
    addressLabel.font=[UIFont systemFontOfSize:15];
    addressLabel.alpha=.6;
    addressLabel.textAlignment=0;
    [_view2 sd_addSubviews:@[addressLabel]];
    addressLabel.sd_layout
    .rightEqualToView(chanDiLabel)
    .topEqualToView(numberLabel)
    .heightRatioToView(xingHaoLabel,1);
    [addressLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    [_view2 setupAutoHeightWithBottomView:numberLabel bottomMargin:15];
    [self CreatView3];//详细信息
   

}



#pragma mark --创建view3详细信息
-(void)CreatView3{
     XiangQingModel * md =_dataArray[0];
    _view3=[UIView new];
    _view3.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view3]];
    _view3.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view2,10)
    .heightIs(300);
    //数线
    UIImageView * lineView =[UIImageView new];
    lineView.image=[UIImage imageNamed:@"xianqing_line"];
    [_view3 sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(_view3,15)
    .topSpaceToView(_view3,15)
    .widthIs(4)
    .heightIs(16);
    //titlename
    UILabel * titleName =[UILabel new];
    titleName.text=@"详细信息";
    titleName.alpha=.7;
    titleName.font=[UIFont systemFontOfSize:16];
    [_view3 sd_addSubviews:@[titleName]];
    titleName.sd_layout
    .leftSpaceToView(lineView,5)
    .centerYEqualToView(lineView)
    .heightIs(15);
    [titleName setSingleLineAutoResizeWithMaxWidth:150];
    UILabel * contentLabel =[UILabel new];
    contentLabel.numberOfLines=0;
    contentLabel.text=md.xiangXiName;//@"以上是；爱黑发盒饭发发发爱阿狸的骄傲骄傲和山地和大海癌变VC啊了骄傲的两大考虑AV克拉vkajkdkd王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮";
    contentLabel.font=[UIFont systemFontOfSize:13];
    contentLabel.alpha=.6;
    [_view3 sd_addSubviews:@[contentLabel]];
    contentLabel.sd_layout
    .leftEqualToView(titleName)
    .topSpaceToView(titleName,15)
    .rightSpaceToView(_view3,20)
    .autoHeightRatio(0);
    
    
    [_view3 setupAutoHeightWithBottomView:contentLabel bottomMargin:20];
    [self CreatTwoBtn];//2个按钮
 
    
}
#pragma mark --创建2个按钮
-(void)CreatTwoBtn{
    int d =(ScreenWidth-216)/3;
    NSArray * arr =@[@"xiangqing_before",@"xiangqing_next"];
    for (int i =0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arr[i]] forState:0];
        [_bgScrollView sd_addSubviews:@[btn]];//216  63
        btn.sd_layout
        .widthIs(216/2)
        .heightIs(63/2)
        .leftSpaceToView(_bgScrollView,d+(216/2+d)*i)
        .topSpaceToView(_view3,20);
        
    }
       [self CreatView4];//猜你喜欢表格
}

#pragma mark --猜你喜欢
-(void)CreatView4{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];//WithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_bgScrollView sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view3,20+63/2+20)
    .heightIs(10*95+40);
    _tableView.bounces=NO;
    __weak __typeof(self)weakSelf = self;
    _tableView.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.bgScrollView.contentSize=CGSizeMake(ScreenWidth, rect.size.height+rect.origin.y+10);
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.tag=indexPath.row;
    cell.chaKanBtn.hidden=YES;
    return cell;
}
//区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView =[UIView new];
    //数线
    UIImageView * lineView =[UIImageView new];
    lineView.image=[UIImage imageNamed:@"xianqing_line"];
    [headView sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(headView,15)
    .topSpaceToView(headView,15)
    .widthIs(4)
    .heightIs(16);
    //titlename
    UILabel * titleName =[UILabel new];
    titleName.text=@"猜你喜欢❤️";
    titleName.alpha=.7;
    titleName.font=[UIFont systemFontOfSize:16];
    [headView sd_addSubviews:@[titleName]];
    titleName.sd_layout
    .leftSpaceToView(lineView,5)
    .centerYEqualToView(lineView)
    .heightIs(15);
    [titleName setSingleLineAutoResizeWithMaxWidth:150];
    
    
    return headView;
}
//区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
