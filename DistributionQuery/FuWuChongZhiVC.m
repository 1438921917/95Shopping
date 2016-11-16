//
//  FuWuChongZhiVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuWuChongZhiVC.h"

@interface FuWuChongZhiVC ()
@property(nonatomic,strong)UIButton*lastBtn;
@end

@implementation FuWuChongZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"服务充值";
    self.view.backgroundColor=[UIColor whiteColor];
    [self Creat];
}
-(void)Creat{
    //图片
    UIImageView * imageview= [[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"guyong_pic"];
    [self.view sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .topSpaceToView(self.view,10+64)
    .heightIs(360*(ScreenWidth-20)/690);
//温馨提示
    UILabel * tishiLabel =[UILabel new];
    tishiLabel.text=@"                          温馨提示\n1.充值短信后，即可发送短信至商家手机；\n2.短信内容建议，对应货源、自己的联系方式；\n3.禁止发送违规、违法的消息内容。";
    tishiLabel.font=[UIFont systemFontOfSize:14];
    tishiLabel.textColor=[UIColor blackColor];
    tishiLabel.numberOfLines=0;
    tishiLabel.alpha=.7;
    [self.view sd_addSubviews:@[tishiLabel]];
    tishiLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(imageview,30)
    .autoHeightRatio(0);
    [tishiLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
    
    //2个按钮
    NSArray * arr =@[@"chongzh",@"choangzhi1"];
    NSArray * sarr =@[@"chongzhi_click",@"choangzhi1_click"];
    int d =(ScreenWidth-125*2)/3;
    for (int i =0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arr[i]] forState:0];
         [btn setImage:[UIImage imageNamed:sarr[i]] forState:UIControlStateSelected];
        btn.tag=i;
        _lastBtn=btn;
        [btn addTarget:self action:@selector(duanXinBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view sd_addSubviews:@[btn]];
         btn.sd_layout
        .leftSpaceToView(self.view,d+(125+d)*i)
        .topSpaceToView(tishiLabel,30)
        .widthIs(250/2)
        .heightIs(142/2);
    
    }
    
    //立即充值按钮
    UIButton * chongZhiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chongZhiBtn setImage:[UIImage imageNamed:@"chonzghi_bt"] forState:0];
    [self.view sd_addSubviews:@[chongZhiBtn]];
    chongZhiBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,40)
    .widthIs(450/2)
    .heightIs(77/2);
    
}
#pragma mark --短信
-(void)duanXinBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    _lastBtn.selected=NO;
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
