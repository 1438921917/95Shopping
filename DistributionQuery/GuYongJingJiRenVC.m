//
//  GuYongJingJiRenVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GuYongJingJiRenVC.h"
#import "SetViewController.h"
#import "ChoosePeopleVC.h"
@interface GuYongJingJiRenVC ()
@property (nonatomic,strong)UIView * view1;
@property (nonatomic,strong)UIView * view2;
@end

@implementation GuYongJingJiRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"雇佣经纪人";
    [self CreatView1];
}
#pragma mark --创建view1
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64+5);
    UIImageView * imageview= [[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"guyong_pic"];
    [_view1 sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(_view1,10)
    .rightSpaceToView(_view1,10)
    .topSpaceToView(_view1,10)
    .heightIs(360*(ScreenWidth-20)/690);
    [_view1 setupAutoHeightWithBottomView:imageview bottomMargin:10];
    [self CreatView2];
}

#pragma mark --创建view2
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_view1,5)
    .bottomSpaceToView(self.view,0);
    
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"guyong_title"];
    [_view2 addSubview:imageview];
    imageview.sd_layout
    .leftSpaceToView(_view2,10)
    .rightSpaceToView(_view2,10)
    .topSpaceToView(_view2,10)
    .heightIs(38*(ScreenWidth-20)/665);
    
    
    NSArray * imageArr=@[@"guyong_bt1",@"guyong_bt2",@"guyong_bt3"];
    NSArray * titleArr =@[@"供应商品信息",@"实名、场地",@"雇佣须知"];
    NSArray * dexArr =@[@"供应商品信息不低于6条",@"实名、场地认证通过",@"雇佣经纪人同一阶段只能雇佣1人，\n单笔生意成交或过期后，即为接触雇佣"];
    UILabel * label=nil;
    for (int i =0; i<3; i++) {
        //左边图片
        UIImageView * leftImage =[UIImageView new];
        leftImage.image=[UIImage imageNamed:imageArr[i]];
        [_view2 addSubview:leftImage];
        leftImage.sd_layout
        .leftSpaceToView(_view2,40)
        .topSpaceToView(imageview,25+(45+20)*i)
        .widthIs(45)
        .heightIs(45);
        //title
        UILabel * titleLabel =[UILabel new];
        titleLabel.font=[UIFont systemFontOfSize:16];
        titleLabel.text=titleArr[i];
        [_view2 sd_addSubviews:@[titleLabel]];
        titleLabel.sd_layout
        .leftSpaceToView(leftImage,20)
        .topEqualToView(leftImage)
        .heightIs(20);
        [titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        
        UILabel * dexLabel =[UILabel new];
        dexLabel.font=[UIFont systemFontOfSize:14];
        dexLabel.alpha=.6;
        dexLabel.text=dexArr[i];
        [_view2 sd_addSubviews:@[dexLabel]];
        dexLabel.sd_layout
        .leftEqualToView(titleLabel)
        .topSpaceToView(titleLabel,5)
        .autoHeightRatio(0);
        [dexLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        label=dexLabel;
    }
    
    NSArray * btnArr =@[@"guyong_bt4",@"guyong_bt5"];
    for (int i =0; i<2; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:btnArr[i]] forState:0];
        [_view2 sd_addSubviews:@[btn]];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .leftSpaceToView(_view2,10+(ScreenWidth/2)*i)
        .widthIs((ScreenWidth-20)/2)
        .topSpaceToView(label,30)
        .heightIs(40);
    }
    
    
    
}
-(void)btnClick:(UIButton*)btn{
    if (btn.tag==0) {
        //我已符合
        ChoosePeopleVC * vc =[ChoosePeopleVC new];
       
         [self.navigationController pushViewController:vc animated:YES ];
    }else{
        //完善
        SetViewController * vc =[SetViewController new];
        [self.navigationController pushViewController:vc animated:YES ];
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
