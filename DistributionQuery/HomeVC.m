//
//  HomeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeVC.h"
#import "YouZhiXianHuoVC.h"
#import "LrdOutputView.h"
#import "YouZhiShangHuVC.h"
#import "QiYeKuaiSuMaiVC.h"
#import "HomeModel.h"
#import "ZuiXinCaiGouVC.h"
@interface HomeVC ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,LrdOutputViewDelegate>
{
    SDCycleScrollView *cycleScrollView2;
}
@property(nonatomic,retain)UIView * view1;//4个按钮
@property(nonatomic,strong)UIView * view2;//拨打电话
@property(nonatomic,strong)UIView * view3;//特价专区
@property(nonatomic,strong)UIView * view4;//设备专区
@property(nonatomic,strong)UIView * view5;//物资专区
@property(nonatomic,strong)UIScrollView * bgScrollView;//背景的滚动试图
@property(nonatomic,strong)UITextField * textfield;//导航条文本框
@property(nonatomic,strong)UIButton * leftBtn;//创建商品商户按钮
@property(nonatomic,strong)UIButton * rightBtn;//创建导航条搜索按钮
@property (nonatomic, assign) CGFloat alphaMemory;
@property(nonatomic,strong)NSArray *menuArr;
@property (nonatomic, strong) LrdOutputView *outputView;//搜索商品下拉菜单
@property(nonatomic,strong)NSMutableArray * tejiaArray;
@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated
{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [_bgScrollView  setContentOffset:CGPointZero animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets=NO;
    self.backHomeBtn.hidden=YES;
    self.title=@"";
    
    _tejiaArray=[NSMutableArray new];
    // [self TeJiaZhuanQuData];//首页特价专区数据解析
     [self CreatBgScrollView];//背景screr
     [self CreatTextFiled];//导航条
     [self CreatLunBoTu];//轮播图
     [self CreatBtnFore];//4个btn
     [self CreatView2];//拨打电话
     [self CreatView3];//特价专区
//     [self CreatView4];//设备专区
//     [self CreatView5];//物资专区
}

#pragma mark --首页特价专区数据解析
-(void)TeJiaZhuanQuData{
    [Engine FirstTeJiaZhuanQusuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                 [LCProgressHUD showMessage:@"Item3是空"];;
            }else{
                NSArray * item3Arr =[dic objectForKey:@"Item3"];
                for (NSDictionary * dicc in item3Arr )
                {
                    HomeModel * teJiaModel =[[HomeModel alloc]initWithTeJiaDic:dicc];
                    [_tejiaArray addObject:teJiaModel];
                }
            }
            
        }
        else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
        
        
    } error:^(NSError *error) {
        
    }];
}




#pragma mark --创建背景的滚动试图
-(void)CreatBgScrollView{
    _bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49)];
    _bgScrollView.backgroundColor=COLOR;
    _bgScrollView.delegate=self;
    [self.view addSubview:_bgScrollView];
}



#pragma mark --创建导航条文本框
-(void)CreatTextFiled{
    //创建商品商户按钮
    _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitle:@"商品" forState:0];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down"] forState:0];
   // [_leftBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down_click"] forState:0];
    _leftBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _leftBtn.frame=CGRectMake(0, 0, 45, 15);
     UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    
    
    //创建搜索文本框
    _textfield=[UITextField new];
    _textfield.layer.cornerRadius=5;
    _textfield.clipsToBounds=YES;
    _textfield.layer.borderWidth=1;
    _textfield.layer.borderColor=[[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1]CGColor];
    _textfield.center=CGPointMake(self.view.center.x, 27);
    _textfield.bounds=CGRectMake(0, 0, ScreenWidth-150, 30);
    _textfield.placeholder=@"   请输入类别或者关键字";
    _textfield.font=[UIFont systemFontOfSize:14];
    UIBarButtonItem * leftBtn3 =[[UIBarButtonItem alloc]initWithCustomView:_textfield];
    self.navigationItem.leftBarButtonItems=@[leftBtn2,leftBtn3];
    
    //搜索按钮
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"搜索" forState:0];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
     self.navigationItem.rightBarButtonItems=@[rightBtn];
    
    //下拉菜单
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"商品" imageName:@"0"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"商户" imageName:@"1"];
    self.menuArr = @[one, two];
}
//商品商户按钮点击
-(void)leftBtnClick:(UIButton*)btn{
    CGFloat x = btn.center.x+35;
    CGFloat y = btn.frame.origin.y + btn.bounds.size.height + 25;
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.menuArr origin:CGPointMake(x, y) width:70 height:30 direction:kLrdOutputViewDirectionRight];
    
    _outputView.fount=15;
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];

}
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"输出看看%lu",indexPath.row);
    if (indexPath.row==0) {
         [_leftBtn setTitle:@"商品" forState:0];
    }else{
         [_leftBtn setTitle:@"商户" forState:0];
    }
   
}
#pragma mark --滚动试图代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

   // NSLog(@"%.f",_bgScrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (_bgScrollView.contentOffset.y<-10) {
        self.navigationController.navigationBarHidden=YES;
    }else{
        self.navigationController.navigationBarHidden=NO;
    }
    if (offsetY>=0) {
        //重新赋值 frame
        if (offsetY<=100) {
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
                _alphaMemory = offsetY/(100) >= 1 ? 1 : offsetY/(100);
                [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
            if (offsetY<=50) {
                [_leftBtn setTitleColor:[UIColor whiteColor] forState:0];
                [_rightBtn setTitleColor:[UIColor whiteColor] forState:0];
                [_leftBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down"] forState:0];
                
            }
            
            
        }else if (offsetY>100){
            _alphaMemory = 1;
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
            if (offsetY>50) {
                [_leftBtn setTitleColor:[UIColor redColor] forState:0];
                [_rightBtn setTitleColor:[UIColor redColor] forState:0];
                [_leftBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down_click"] forState:0];
            }
        }
    }

}

#pragma mark --首页轮播图
-(void)CreatLunBoTu{
    NSArray * arr =@[@"banner"];
    [self remoteImageLoaded:arr];
//    [Engine getFirstImagesuccess:^(NSDictionary *dic) {
//        
//    } error:^(NSError *error) {
//        
//    }];
}
//获取网络图片
- (void)remoteImageLoaded:(NSArray*)arr{

   cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, ScreenWidth, 540*ScreenWidth/1080) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [_bgScrollView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = arr;
    });
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        // NSLog(@">>>>>  %ld", (long)index);
        
    };
    
}

#pragma mark --创建view1
-(void)CreatBtnFore{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(cycleScrollView2,0);
   
    int d =(ScreenWidth-209/3*4)/5;
    for (int i =0; i<4; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        NSString * nameStr =[NSString stringWithFormat:@"home_bt%d",i+1];
        btn.tag=i;
        [btn addTarget:self action:@selector(view1Btn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:nameStr] forState:0];
        [_view1 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(_view1,d+(209/3+d)*i)
        .topSpaceToView(_view1,10)
        .widthIs(209/3)
        .heightIs(192/3);
        [_view1 setupAutoHeightWithBottomView:btn bottomMargin:10];
    }
    
    
}
#pragma mark --4个按钮
-(void)view1Btn:(UIButton*)btn{
   // NSLog(@"输出%lu",btn.tag);
    if (btn.tag==0) {
        //优质现货
        YouZhiXianHuoVC * vc =[YouZhiXianHuoVC new];
        vc.tagg=1;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==1){
        //优质商户
        YouZhiShangHuVC * vc =[YouZhiShangHuVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==2){
        //最新采购
        ZuiXinCaiGouVC * vc =[ZuiXinCaiGouVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else if (btn.tag==3){
        //企业快色买货
        QiYeKuaiSuMaiVC* vc =[QiYeKuaiSuMaiVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark --创建view2拨打电话
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view1,10);
    //图片
    UIImageView * imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_weituo"]];
    [_view2 sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(_view2,30)
    .topSpaceToView(_view2,10)
    .widthIs(221/2.5)
    .heightIs(65/2.5);
    //立即拨打按钮
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"home_phone"] forState:0];
    [_view2 sd_addSubviews:@[btn]];
    btn.sd_layout
    .rightSpaceToView(_view2,20)
    .centerYEqualToView(imageview)
    .widthIs(118/2)
    .heightIs(38/2);
    
    //详情咨询
    UILabel * label =[UILabel new];
    label.text=@"详情请咨询  4000365195";
    label.alpha=.6;
    label.font=[UIFont systemFontOfSize:14];
    [_view2 sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(imageview,10)
    .rightSpaceToView(btn,10)
    .centerYEqualToView(imageview)
    .heightIs(20);
    [_view2 setupAutoHeightWithBottomView:imageview bottomMargin:10];
}

#pragma mark --创建view3（特价专区）
-(void)CreatView3{
    NSLog(@"有个数吗%lu",_tejiaArray.count);
    _view3=[UIView new];
    _view3.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view3]];
    _view3.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view2,10);
    
    //特价专区
    UILabel * label =[UILabel new];
    label.text=@"特价专区";
    label.textColor=[UIColor blackColor];
    label.alpha=.6;
    label.font=[UIFont systemFontOfSize:16];
     [_view3 sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(_view3,10)
    .topSpaceToView(_view3,10)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    //线条
    UIView * linview =[UIView new];
    linview.backgroundColor=COLOR;
    [_view3 sd_addSubviews:@[linview]];
    linview.sd_layout
    .leftSpaceToView(_view3,0)
    .rightSpaceToView(_view3,0)
    .heightIs(1)
    .topSpaceToView(label,10);
    //点击进入
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:0];
    btn.tag=10;
    [btn addTarget:self action:@selector(tejiaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_view3 sd_addSubviews:@[btn]];
    btn.sd_layout
    .rightSpaceToView(_view3,10)
    .centerYEqualToView(label)
    .widthIs(198/3)
    .heightIs(40/3);
    //特价专区滚动图
    UIScrollView * priceScrollview =[[UIScrollView alloc]init];
    priceScrollview.showsHorizontalScrollIndicator = NO;
    [_view3 sd_addSubviews:@[priceScrollview]];
    priceScrollview.sd_layout
    .leftSpaceToView(_view3,0)
    .rightSpaceToView(_view3,0)
    .topSpaceToView(linview,10)
    .heightIs(100);
    
    [_view3 setupAutoHeightWithBottomView:priceScrollview bottomMargin:10];
    //解析特价专区数据
    [Engine FirstTeJiaZhuanQusuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"Item3是空"];;
            }else{
                NSArray * item3Arr =[dic objectForKey:@"Item3"];
                for (int i=0;i<item3Arr.count;i++ )
                {
                    NSDictionary * dicc =item3Arr[i];
                    HomeModel * md =[[HomeModel alloc]initWithTeJiaDic:dicc];
                    NSLog(@"输出看%@",md.imageview);
                    UIImageView * imageTejia =[[UIImageView alloc]init];
                    [imageTejia setImageWithURL:[NSURL URLWithString:md.imageview] placeholderImage:[UIImage imageNamed:@"login_banner"]];
                    [priceScrollview sd_addSubviews:@[imageTejia]];
                    imageTejia.sd_layout
                    .leftSpaceToView(priceScrollview,10+(100+10)*i)
                    .topSpaceToView(priceScrollview,0)
                    .widthIs(100)
                    .heightIs(80);
                    CGFloat k =100*item3Arr.count +10*(item3Arr.count+1);
                    priceScrollview.contentSize=CGSizeMake(k, 100);
                    UILabel * nameLabel =[UILabel new];
                    nameLabel.font=[UIFont systemFontOfSize:15];
                    nameLabel.text=md.sheBeiName;
                    [priceScrollview sd_addSubviews:@[nameLabel]];
                    nameLabel.sd_layout
                    .centerXEqualToView(imageTejia)
                    .topSpaceToView(imageTejia,0)
                    .heightIs(20);
                    [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
                   // [_tejiaArray addObject:teJiaModel];
                }
            }
            
        }
        else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
        
        
    } error:^(NSError *error) {
        
    }];
    
//    if (_tejiaArray.count==0) {
//        
//    }else{
//        for (int i =0; i<_tejiaArray.count; i++) {
//            HomeModel * md =_tejiaArray[i];
//            NSLog(@"输出看%@",md.imageview);
//           // CGSize  size =[ToolClass getImageSizeWithURL:md.imageview];
//            UIImageView * imageTejia =[[UIImageView alloc]init];
//            [imageTejia setImageWithURL:[NSURL URLWithString:md.imageview] placeholderImage:[UIImage imageNamed:@"login_banner"]];
//            [priceScrollview sd_addSubviews:@[imageTejia]];
//            imageTejia.sd_layout
//            .leftSpaceToView(priceScrollview,10+(100+10)*i)
//            .topSpaceToView(priceScrollview,0)
//            .widthIs(100)
//            .heightIs(80);
//            CGFloat k =100*_tejiaArray.count +10*(_tejiaArray.count+1);
//            
//            priceScrollview.contentSize=CGSizeMake(k, 100);
//            UILabel * nameLabel =[UILabel new];
//            nameLabel.font=[UIFont systemFontOfSize:15];
//            nameLabel.text=md.sheBeiName;
//            [priceScrollview sd_addSubviews:@[nameLabel]];
//            nameLabel.sd_layout
//            .centerXEqualToView(imageTejia)
//            .topSpaceToView(imageTejia,0)
//            .heightIs(20);
//            [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
//            
//        }
//       
//    }
//   
//    
    
    
    
    [self CreatView4];//设备专区
   // [self CreatView5];//物资专区
}
#pragma mark --特价专区点击进入
-(void)tejiaBtn:(UIButton*)btn{
    YouZhiXianHuoVC * vc =[YouZhiXianHuoVC new];
    vc.tagg=btn.tag;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --创建view4设备专区
-(void)CreatView4{
    _view4=[UIView new];
    _view4.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view4]];
    _view4.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view3,10);
    
    //特价专区
    UILabel * label =[UILabel new];
    label.text=@"设备专区";
    label.textColor=[UIColor blackColor];
    label.alpha=.6;
    label.font=[UIFont systemFontOfSize:16];
    [_view4 sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(_view4,10)
    .topSpaceToView(_view4,10)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    //线条
    UIView * linview =[UIView new];
    linview.backgroundColor=COLOR;
    [_view4 sd_addSubviews:@[linview]];
    linview.sd_layout
    .leftSpaceToView(_view4,0)
    .rightSpaceToView(_view4,0)
    .heightIs(1)
    .topSpaceToView(label,10);
    //点击进入
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:0];
    btn.tag=11;
    [btn addTarget:self action:@selector(tejiaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_view4 sd_addSubviews:@[btn]];
    btn.sd_layout
    .rightSpaceToView(_view4,10)
    .centerYEqualToView(label)
    .widthIs(198/3)
    .heightIs(40/3);
    //设备专区文字
    NSArray * arr =@[@"化工",@"矿山",@"机床",@"制冷",@"纺织",@"造纸",@"塑料",@"制冷"];
    for (int i =0; i<arr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
       // btn.backgroundColor=[UIColor redColor];
        [btn setTitle:arr[i] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [_view4 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(_view4,0+((ScreenWidth-0)/4+0)*(i%4))
        .topSpaceToView(linview,0+(ScreenWidth/8+0)*(i/4))
        .widthIs(ScreenWidth/4)
        .heightIs(ScreenWidth/8);
        
     [_view4 setupAutoHeightWithBottomView:btn bottomMargin:10];
    }
    
    
    
    
   
    [self CreatView5];//物资专区
    
}
#pragma mark --创建view5物资专区
-(void)CreatView5{
    _view5=[UIView new];
    _view5.backgroundColor=[UIColor whiteColor];
    [_bgScrollView sd_addSubviews:@[_view5]];
    _view5.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(_view4,10);
    
    //特价专区
    UILabel * label =[UILabel new];
    label.text=@"物资专区";
    label.textColor=[UIColor blackColor];
    label.alpha=.6;
    label.font=[UIFont systemFontOfSize:16];
    [_view5 sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(_view5,10)
    .topSpaceToView(_view5,10)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    //线条
    UIView * linview =[UIView new];
    linview.backgroundColor=COLOR;
    [_view5 sd_addSubviews:@[linview]];
    linview.sd_layout
    .leftSpaceToView(_view5,0)
    .rightSpaceToView(_view5,0)
    .heightIs(1)
    .topSpaceToView(label,10);
    //点击进入
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:0];
      btn.tag=12;
    [btn addTarget:self action:@selector(tejiaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_view5 sd_addSubviews:@[btn]];
    btn.sd_layout
    .rightSpaceToView(_view5,10)
    .centerYEqualToView(label)
    .widthIs(198/3)
    .heightIs(40/3);
    
    //物资专区文字
    NSArray * arr =@[@"钢结构",@"废金属",@"配件",@"再生资源"];
    for (int i =0; i<arr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        // btn.backgroundColor=[UIColor redColor];
        [btn setTitle:arr[i] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [_view5 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(_view5,0+((ScreenWidth-0)/4+0)*(i/1))
        .topSpaceToView(linview,0+(ScreenWidth/8+0)*(i/4))
        .widthIs(ScreenWidth/4)
        .heightIs(ScreenWidth/8);
        
        [_view5 setupAutoHeightWithBottomView:btn bottomMargin:10];
    }
    
     __weak __typeof(self)weakSelf = self;
    _view5.didFinishAutoLayoutBlock=^(CGRect rect){
      //  NSLog(@">>>%f",rect.size.height+rect.origin.y);
        weakSelf.bgScrollView.contentSize=CGSizeMake(ScreenWidth, rect.size.height+rect.origin.y+10);
    };
    
    
}


//#pragma mark --6个btn
//-(void)CreatBtn{
//    for (int i =0; i<6; i++) {
//        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor=[UIColor yellowColor];
//        [self.view sd_addSubviews:@[btn]];
//        //
//        btn.sd_layout
//        .leftSpaceToView(self.view,10+((ScreenWidth-30)/2+10)*(i/3))
//        .topSpaceToView(_view1,10+(100+10)*(i%3))
//        .widthIs((ScreenWidth-30)/2)
//        .heightIs(100);
//        
//    }
//    
//    
//    
//}
//

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.navigationController.view endEditing:YES];
//}


@end
