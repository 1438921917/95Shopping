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
@property(nonatomic,strong)UILabel * lastLabel;
@end

@implementation FuWuChongZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tagg==0) {
        self.title=@"短信充值";
    }else{
         self.title=@"400充值";
    }
   
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
    tishiLabel.text=@"温馨提示";
//    if (_tagg==0) {
//        tishiLabel.text=@"                          温馨提示\n1.充值短信后，即可发送短信至商家手机；\n2.短信内容建议，对应货源、自己的联系方式；\n3.禁止发送违规、违法的消息内容。";
//    }else{
//        tishiLabel.text=@"                          温馨提示\n1.充值短信后，即可发送短信至商家手机；\n2.短信内容建议，对应货源、自己的联系方式；\n3.禁止发送违规、违法的消息内容。";
//    }
    tishiLabel.font=[UIFont systemFontOfSize:14];
    tishiLabel.textColor=[UIColor redColor];
    tishiLabel.alpha=.7;
    [self.view sd_addSubviews:@[tishiLabel]];
    tishiLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(imageview,25)
    .autoHeightRatio(0);
    [tishiLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
    
    UILabel * contentLabel =[UILabel new];
    if (_tagg==0) {
         contentLabel.text=@"1.充值短信后，即可发送短信至商家手机；\n2.短信内容建议，对应货源、自己的联系方式；\n3.禁止发送违规、违法的消息内容。";
    }else{
         contentLabel.text=@"                       首次认证成功的客户，\n即可得到20分钟400被叫通话!商家联系更方便哦！";
    }
   
    contentLabel.font=[UIFont systemFontOfSize:13];
    contentLabel.textColor=[UIColor blackColor];
    contentLabel.alpha=.7;
    [self.view sd_addSubviews:@[contentLabel]];
    contentLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(tishiLabel,15)
    .autoHeightRatio(0);
    [contentLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
    
    
    
    
    
    //2个按钮
    NSArray * arr=nil;
    NSArray * sarr=nil;
    NSArray * titleArr=nil;
    int d=0;
    if (_tagg==0) {
        arr =@[@"messege_line",@"messege_line"];
        sarr =@[@"messege_line_red",@"messege_line_red"];
        titleArr =@[@"100条\n\n500元",@"200条\n\n900元"];
         d =(ScreenWidth-125*arr.count)/(arr.count+1);
    }else{
        arr =@[@"messege_line",@"messege_line",@"messege_line"];
        sarr =@[@"messege_line_red",@"messege_line_red",@"messege_line_red"];
        titleArr =@[@"1000分钟\n\n1000元",@"2000分钟\n\n1600元",@"5000分钟\n\n3000元"];
         d =(ScreenWidth-99*arr.count)/(arr.count+1);
    }
    
    for (int i =0; i<arr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arr[i]] forState:0];
        [btn setImage:[UIImage imageNamed:sarr[i]] forState:UIControlStateSelected];
        btn.tag=i;
        UILabel * nameLabel =[UILabel new];
        if (i==0) {
            btn.selected=YES;
            _lastBtn=btn;
            nameLabel.textColor=[UIColor redColor];
            _lastLabel=nameLabel;
        }
      
        nameLabel.tag=1;
        nameLabel.numberOfLines=0;
        nameLabel.textAlignment=1;
        nameLabel.font=[UIFont systemFontOfSize:14];
        nameLabel.text=titleArr[i];
        [btn sd_addSubviews:@[nameLabel]];
        nameLabel.sd_layout
        .leftSpaceToView(btn,0)
        .rightSpaceToView(btn,0)
        .topSpaceToView(btn,0)
        .bottomSpaceToView(btn,0);

       
        [btn addTarget:self action:@selector(duanXinBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view sd_addSubviews:@[btn]];
        if (_tagg==0) {
            btn.sd_layout
            .leftSpaceToView(self.view,d+(125+d)*i)
            .topSpaceToView(contentLabel,30)
            .widthIs(250/2)
            .heightIs(142/2);
        }else{
            btn.sd_layout
            .leftSpaceToView(self.view,d+(99+d)*i)
            .topSpaceToView(contentLabel,30)
            .widthIs(188/2)
            .heightIs(142/2);
        }
        
        
        
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
    _lastBtn.selected=!_lastBtn.selected;
    btn.selected=!btn.selected;
    _lastBtn=btn;
    _lastLabel.textColor=[UIColor blackColor];
    UILabel * namelable=[[btn subviews] objectAtIndex:1];
    namelable.textColor=[UIColor redColor];
    _lastLabel=namelable;
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
