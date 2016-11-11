//
//  MyRenZhengVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyRenZhengVC.h"

@interface MyRenZhengVC ()
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIImageView * imageview;
@end

@implementation MyRenZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要认证";
    [self CreatView1];//创建view1上传身份证
    [self CreatPhotoImage];//拍照师范
    [self CreatView2];//场地照片
}
#pragma mark --创建view1
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64);
   
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"身份证照片";
    nameLabel.alpha=.8;
    [_view1 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
   
    UIButton * upbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [upbtn addTarget:self action:@selector(upbtnphoto:) forControlEvents:UIControlEventTouchUpInside];
    [upbtn setImage:[UIImage imageNamed:@"renzheng_add"] forState:0];
    [_view1 sd_addSubviews:@[upbtn]];
//    413 212
    upbtn.sd_layout
    .leftSpaceToView(nameLabel,25)
    .topEqualToView(nameLabel)
    .widthIs(413/2)
    .heightIs(242/2);
     [_view1 setupAutoHeightWithBottomView:upbtn bottomMargin:10];
    
}

#pragma mark --上传身份证照片
-(void)upbtnphoto:(UIButton*)btn{
    
}

#pragma mark --照片实例
-(void)CreatPhotoImage{
    _imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"renzheng_shifan"]];
    [self.view sd_addSubviews:@[_imageview]];
    _imageview.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(_view1,10)
    .rightSpaceToView(self.view,15)
    .heightIs((ScreenWidth-30)*371/596);
}

#pragma mark --创建view2
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_imageview,10);
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"场地照片";
    nameLabel.alpha=.8;
    [_view2 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UIButton * upbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [upbtn addTarget:self action:@selector(upbtnphoto:) forControlEvents:UIControlEventTouchUpInside];
    [upbtn setImage:[UIImage imageNamed:@"renzheng_add1"] forState:0];
    [_view2 sd_addSubviews:@[upbtn]];
    //    413 212
    upbtn.sd_layout
    .leftSpaceToView(nameLabel,25)
    .topEqualToView(nameLabel)
    .widthIs(413/2)
    .heightIs(242/2);
    [_view2 setupAutoHeightWithBottomView:upbtn bottomMargin:10];
    
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
