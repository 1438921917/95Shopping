//
//  RegistVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()
@property(nonatomic,strong)UIImageView * topImageview;//天空图片
@property(nonatomic,strong)UITextField *phoneText;//手机号
@property(nonatomic,strong)UITextField *pwdText;//请输入密码
@property(nonatomic,strong)UITextField *quePwdText;//确认入密码
@property(nonatomic,strong)UITextField * codeText;//输入验证码
@property(nonatomic,strong)UIButton * codeBtn;//获取验证码按钮
@property(nonatomic,strong)UIButton * commentBtn;//提交入住
@property(nonatomic,strong)UIView * lineView1;
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)UIView * lineView3;
@property(nonatomic,strong)UIView * lineView4;
@property(nonatomic,strong)UIView * bgview;
@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"注册";
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatTopImageView];//创建天空的图片
    [self CreatView];
    [self CreatLoginBtn];
}
#pragma mark--  创建天空的图片
-(void)CreatTopImageView{
    _topImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_banner"]];
    [self.view sd_addSubviews:@[_topImageview]];
    _topImageview.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .rightSpaceToView(self.view,0)
    .heightIs(ScreenWidth*434/750);
}
#pragma mark --创建白色的view
-(void)CreatView{
    _bgview=[[UIView alloc]init];
    _bgview.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_bgview]];
    _bgview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_topImageview,15);
    
    //手机号
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"手机号";
    _phoneText.alpha=1;
    _phoneText.leftView =[self imageViewNameStr:@"phone"];
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_phoneText]];
    _phoneText.sd_layout
    .leftSpaceToView(_bgview,40)
    .rightSpaceToView(_bgview,40)
    .heightIs(30)
    .topSpaceToView(_bgview,10);
    
    //线条1
    _lineView1=[UIView new];
    _lineView1.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView1]];
    _lineView1.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .topSpaceToView(_phoneText,10)
    .heightIs(1);
    
    //请输入密码
    _pwdText=[[UITextField alloc]init];
    _pwdText.placeholder=@"请输入密码";
    _pwdText.alpha=1;
    _pwdText.leftView =[self imageViewNameStr:@"login_ps"];
    _pwdText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_pwdText]];
    _pwdText.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView1,15);
    
    //线条2
    _lineView2=[UIView new];
    _lineView2.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView2]];
    _lineView2.sd_layout
    .leftEqualToView(_lineView1)
    .rightEqualToView(_lineView1)
    .topSpaceToView(_pwdText,10)
    .heightIs(1);
    
    //确认密码
    _quePwdText=[[UITextField alloc]init];
    _quePwdText.placeholder=@"请确认密码";
    _quePwdText.alpha=1;
    _quePwdText.leftView =[self imageViewNameStr:@"login_ps"];
    _quePwdText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_quePwdText]];
    _quePwdText.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView2,15);
    
    //线条3
    _lineView3=[UIView new];
    _lineView3.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView3]];
    _lineView3.sd_layout
    .leftEqualToView(_lineView1)
    .rightEqualToView(_lineView1)
    .topSpaceToView(_quePwdText,10)
    .heightIs(1);

    
    
    //获取验证码btn
    _codeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.backgroundColor=COLOR;
    [_codeBtn setTitle:@"获取验证码" forState:0];
    [_codeBtn setTitleColor:[UIColor blackColor] forState:0];
    _codeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [_bgview sd_addSubviews:@[_codeBtn]];
    _codeBtn.sd_layout
    .widthIs(100)
    .rightEqualToView(_phoneText)
    .heightIs(40)
    .topSpaceToView(_lineView3,10);
//
//    
    //请输入验证码
    _codeText=[[UITextField alloc]init];
    _codeText.placeholder=@"请输入验证码";
    _codeText.leftView =[self imageViewNameStr:@"login_yanzhnegma"];
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_codeText]];
    _codeText.sd_layout
    .leftEqualToView(_phoneText)
    .rightSpaceToView(_codeBtn,0)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView3,15);
//
    //线条4
    _lineView4=[UIView new];
    _lineView4.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView4]];
    _lineView4.sd_layout
    .leftEqualToView(_lineView2)
    .rightEqualToView(_lineView2)
    .topSpaceToView(_codeText,10)
    .heightIs(1);
//
    
    [_bgview setupAutoHeightWithBottomView:_lineView4 bottomMargin:10];
    
    
    
}
#pragma mark --入住按钮
-(void)CreatLoginBtn{
    //登录
    _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.backgroundColor=[UIColor redColor];
    // [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_bt"] forState:0];
    [_commentBtn setTitle:@"提交入驻" forState:0];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:0];
    _commentBtn.sd_cornerRadius=@(5);
    [self.view sd_addSubviews:@[_commentBtn]];
    _commentBtn.sd_layout
    .leftEqualToView(_lineView3)
    .rightEqualToView(_lineView3)
    .heightIs(40)
    .topSpaceToView(_bgview,10);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton*)imageViewNameStr:(NSString*)imageName{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    
    btn.frame=CGRectMake(0, 0, 30, 30);
    return btn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
