//
//  PublicTypeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PublicTypeVC.h"
#import "ChoosePeopleVC.h"
@interface PublicTypeVC ()
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UIView * view2;
@end

@implementation PublicTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择发布类型";
    _headImage=[[UIImageView alloc]init];
    _headImage.image=[UIImage imageNamed:@"login_banner"];
    [self.view sd_addSubviews:@[_headImage]];
    _headImage.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(434*ScreenWidth/750);
    [self CreatView2];
}
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_headImage,10)
    .bottomSpaceToView(self.view,0);
    
    //label
    UILabel * label =[UILabel new];
    label.text=@"温馨提示\n请您选择发布类型";
    label.textAlignment=1;
    label.numberOfLines=2;
    label.font=[UIFont systemFontOfSize:15];
    label.alpha=.7;
    [_view2 sd_addSubviews:@[label]];
    label.sd_layout
    .centerXEqualToView(_view2)
    .topSpaceToView(_view2,20)
    .widthIs(150)
    .autoHeightRatio(0);
    NSArray * imageArr =@[@"fabu_geren",@"fabu_tuoguan"];
    //2个btn
    int d =(ScreenWidth-347)/3;
    for (int i =0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:0];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnn:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 sd_addSubviews:@[btn]];
        btn.sd_layout
        .leftSpaceToView(_view2,d+(347/2+d)*i)
        .topSpaceToView(label,20)
        .widthIs(347/2)
        .heightIs(160/2);
    }
    
    
}
-(void)btnn:(UIButton*)btn{
    if (btn.tag==0) {
        //个人交易
        [LCProgressHUD showMessage:@"发布完毕"];
    }else{
        //托管经济人
        ChoosePeopleVC * vc =[ChoosePeopleVC new];
        [self.navigationController pushViewController:vc animated:YES];
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
