//
//  DaShangJingJiRenVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "DaShangJingJiRenVC.h"

@interface DaShangJingJiRenVC ()
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIButton * lastBtn;
@end

@implementation DaShangJingJiRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"打赏经纪人";
    [self CreatView1];
    [self CreatView2];
}
#pragma mark --创建view1
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10+64);
   //头像
    UIImageView * headImage =[UIImageView new];
    headImage.sd_cornerRadius=@(75/2);
    [headImage setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"my_photo"]];
    [_view1 sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,10)
    .widthIs(75)
    .heightIs(75);
   //编号
    UILabel * bianHaoLabel =[UILabel new];
    bianHaoLabel.text=@"编号01";
    bianHaoLabel.font=[UIFont systemFontOfSize:16];
    bianHaoLabel.alpha=.8;
    [_view1 sd_addSubviews:@[bianHaoLabel]];
    bianHaoLabel.sd_layout
    .leftSpaceToView(headImage,20)
    .topSpaceToView(_view1,20)
    .heightIs(25);
    [bianHaoLabel setSingleLineAutoResizeWithMaxWidth:120];
    //电话
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"电话 400-0123-456";
    phoneLabel.font=[UIFont systemFontOfSize:16];
    phoneLabel.alpha=.8;
    [_view1 sd_addSubviews:@[phoneLabel]];
    phoneLabel.sd_layout
    .leftEqualToView(bianHaoLabel)
    .topSpaceToView(bianHaoLabel,15)
    .heightIs(20);
    [phoneLabel setSingleLineAutoResizeWithMaxWidth:260];
    
    [_view1 setupAutoHeightWithBottomView:headImage bottomMargin:10];
    
    
}
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_view1,10)
    .bottomSpaceToView(self.view,0);
    //雇佣费用
    UILabel * guLabel =[UILabel new];
    guLabel.text=@"雇佣费用";
    guLabel.font=[UIFont systemFontOfSize:18];
    guLabel.alpha=.6;
    [_view2 sd_addSubviews:@[guLabel]];
    guLabel.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,15)
    .heightIs(20);
    [guLabel setSingleLineAutoResizeWithMaxWidth:260];
    //雇佣按钮
    UIButton * guyongBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [guyongBtn setBackgroundImage:[UIImage imageNamed:@"guyongfeiyong"] forState:0];
   // [wangji addTarget:self action:@selector(wangji) forControlEvents:UIControlEventTouchUpInside];
    [_view2 sd_addSubviews:@[guyongBtn]];
    guyongBtn.sd_layout
    .leftEqualToView(guLabel)
    .topSpaceToView(guLabel,15)
    .widthIs(204/2)
    .heightIs(116/2);
    //打赏经纪人
    UILabel * dashangLab =[UILabel new];
    dashangLab.text=@"打赏经纪人";
    dashangLab.font=[UIFont systemFontOfSize:18];
    dashangLab.alpha=.6;
    [_view2 sd_addSubviews:@[dashangLab]];
    dashangLab.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(guyongBtn,20)
    .heightIs(20);
    [dashangLab setSingleLineAutoResizeWithMaxWidth:260];
    //6个按钮
    NSArray * imageArr =@[@"bt11",@"bt2",@"bt3",@"bt4",@"bt5",@"bt6"];
    NSArray * seleArr =@[@"bt1",@"bt22",@"bt33",@"bt44",@"bt55",@"bt66"];
    UIButton * bbttnn;
        for (int i =0; i<6; i++) {
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:0];
            btn.tag=i;
            bbttnn=btn;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:seleArr[i]] forState:UIControlStateSelected];
            [_view2 sd_addSubviews:@[btn]];
            btn.sd_layout
            .leftSpaceToView(_view2,15+(204/2+15)*(i%3))
            .topSpaceToView(dashangLab,10+(116/2+15)*(i/3))
            .widthIs(204/2)
            .heightIs(116/2);
            if (i==0) {
                btn.selected=YES;
                _lastBtn=btn;
            }
            
        }
    //合计
    UILabel * hejiLab =[UILabel new];
    hejiLab.text=@"合计  1066.6元";
    hejiLab.textColor=[UIColor redColor];
    hejiLab.font=[UIFont systemFontOfSize:20];
    hejiLab.attributedText=[ToolClass attrStrFrom:hejiLab.text intFond:16 Color:[UIColor blackColor] numberStr:@"合计"];
    hejiLab.textAlignment=2;
    [_view2 sd_addSubviews:@[hejiLab]];
    hejiLab.sd_layout
    .rightSpaceToView(_view2,15)
    .topSpaceToView(bbttnn,20)
    .widthIs(260)
    .heightIs(20);
    //确认支付
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"dashang_bt"] forState:0];
    [_view2 sd_addSubviews:@[sureBtn]];
    sureBtn.sd_layout
    .centerXEqualToView(_view2)
    .bottomSpaceToView(_view2,30)
    .widthIs(450/2)
    .heightIs(77/2);
   
    
}
-(void)btnClick:(UIButton*)btn{
    _lastBtn.selected=!_lastBtn.selected;
    btn.selected=!btn.selected;
    _lastBtn=btn;
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
