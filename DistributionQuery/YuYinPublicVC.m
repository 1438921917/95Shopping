//
//  YuYinPublicVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YuYinPublicVC.h"
#define API_KEY @"EwvQA5D7CSSWjHx0U5m3fRVD" // 请修改为您在百度开发者平台申请的API_KEY
#define SECRET_KEY @"a83b3ea2c058dde32479c79e0d46f832" // 请修改您在百度开发者平台申请的SECRET_KEY
//#error 请修改为您在百度开发者平台申请的APP ID
#define APPID @"8897098"
@interface YuYinPublicVC ()
@property(nonatomic,strong)UIView * bgView;

@end

@implementation YuYinPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tagg==0) {
       self.title=@"标题";
    }else{
       self.title=@"语音发布";
    }
   
    self.automaticallyAdjustsScrollViewInsets=NO;
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_bgView]];
    _bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10+64)
    .bottomSpaceToView(self.view,0);
    [self CreatRightBtn];
    [self CreatTextView];
    
    
    
}

-(void)CreatRightBtn{
    UIButton * _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    //搜索按钮
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"完成" forState:0];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:TITLE_FOUNT];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    [_rightBtn setTitleColor:[UIColor redColor] forState:0];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtn];
}
-(void)CreatTextView{
    _textView=[[UITextView alloc]init];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:17];
    _textView.layer.borderWidth=1;
    _textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    [_bgView sd_addSubviews:@[_textView]];
    _textView.sd_layout
    .leftSpaceToView(_bgView,10)
    .rightSpaceToView(_bgView,10)
    .topSpaceToView(_bgView,15)
    .heightIs(250);
    
    UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"biaoti_del"] forState:0];
    [_textView sd_addSubviews:@[deleteBtn]];
    deleteBtn.sd_layout
    .rightSpaceToView(_textView,10)
    .bottomSpaceToView(_textView,10)
    .widthIs(173/2)
    .heightIs(43/2);
    
    UIButton * publicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setImage:[UIImage imageNamed:@"biaoti_yuyin"] forState:0];
    [publicBtn addTarget:self action:@selector(yuYinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[publicBtn]];
    publicBtn.sd_layout
    .centerXEqualToView(_bgView)
    .bottomSpaceToView(_bgView,20)
    .widthIs(220)
    .heightIs(50);
    
    
}
#pragma mark --语音发布
-(void)yuYinBtn:(UIButton*)btn{
     [self clean];
    if (_tagg==0) {
        //从标题进来的
        [self yuYinShiBieOne];
    }else{
        //语音发布
        [self yuYinShiBieOne];
       // [self yuYinStyleTwo];
    }

    
}


//语音识别样式1
-(void)yuYinShiBieOne{
    // 创建识别控件
    BDTheme *theme3=[BDTheme defaultFullScreenTheme];
    //[BDVRSConfig sharedInstance].theme
    BDRecognizerViewController *tmpRecognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(60, ScreenHeight/3) withTheme:theme3];
    // 获取默认皮肤
    // 全屏UI
    if ([[BDVRSConfig sharedInstance].theme.name isEqualToString:@"全屏亮蓝"]) {
        tmpRecognizerViewController.enableFullScreenMode = YES;
    }
    
    tmpRecognizerViewController.delegate = self;
    self.recognizerViewController = tmpRecognizerViewController;
    
    // 设置识别参数
    BDRecognizerViewParamsObject *paramsObject = [[BDRecognizerViewParamsObject alloc] init];
    
    // 开发者信息，必须修改API_KEY和SECRET_KEY为在百度开发者平台申请得到的值，否则示例不能工作
    paramsObject.apiKey = API_KEY;
    paramsObject.secretKey = SECRET_KEY;
    
    // 设置是否需要语义理解，只在搜索模式有效
    paramsObject.isNeedNLU = [BDVRSConfig sharedInstance].isNeedNLU;
    
    // 设置识别语言
    paramsObject.language = [BDVRSConfig sharedInstance].recognitionLanguage;
    
    // 设置识别模式，分为搜索和输入
    paramsObject.recogPropList = @[[BDVRSConfig sharedInstance].recognitionProperty];
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    paramsObject.cityID = 1;
    
    // 开启联系人识别
    //    paramsObject.enableContacts = YES;
    
    // 设置显示效果，是否开启连续上屏
    if ([BDVRSConfig sharedInstance].resultContinuousShow)
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeContinuousShow;
    }
    else
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeWholeShow;
    }
    
    // 设置提示音开关，是否打开，默认打开
    if ([BDVRSConfig sharedInstance].uiHintMusicSwitch)
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordPlay;
    }
    else
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordForbidden;
    }
    
    paramsObject.isShowTipAfter3sSilence = NO;
    paramsObject.isShowHelpButtonWhenSilence = NO;
    paramsObject.tipsTitle = @"可以使用如下指令记账";
    paramsObject.tipsList = [NSArray arrayWithObjects:@"我要记账", @"买苹果花了十块钱", @"买牛奶五块钱", @"第四行滚动后可见", @"第五行是最后一行", nil];
    
    paramsObject.appCode = APPID;
    paramsObject.licenseFilePath= [[NSBundle mainBundle] pathForResource:@"bdasr_temp_license" ofType:@"dat"];
    paramsObject.datFilePath = [[NSBundle mainBundle] pathForResource:@"s_1" ofType:@""];
    if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyMap) {
        paramsObject.LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_Navi" ofType:@""];
    } else if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyInput) {
        paramsObject.LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_InputMethod" ofType:@""];
    }
    
    paramsObject.recogGrammSlot = @{@"$name_CORE" : @"张三\n李四\n",
                                    @"$song_CORE" : @"小苹果\n朋友\n",
                                    @"$app_CORE" : @"QQ\n百度\n微信\n百度地图\n",
                                    @"$artist_CORE" : @"刘德华\n周华健\n"};
    
    [_recognizerViewController startWithParams:paramsObject];
    
    
}


//语音识别样式二
-(void)yuYinStyleTwo{
    // 设置开发者信息
    [[BDVoiceRecognitionClient sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    
    // 设置语音识别模式，默认是输入模式
    [[BDVoiceRecognitionClient sharedInstance] setPropertyList:@[[BDVRSConfig sharedInstance].recognitionProperty]];
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    [[BDVoiceRecognitionClient sharedInstance] setCityID: 1];
    
    // 设置是否需要语义理解，只在搜索模式有效
    [[BDVoiceRecognitionClient sharedInstance] setConfig:@"nlu" withFlag:[BDVRSConfig sharedInstance].isNeedNLU];
    
    // 开启联系人识别
    //    [[BDVoiceRecognitionClient sharedInstance] setConfig:@"enable_contacts" withFlag:YES];
    
    // 设置识别语言
    [[BDVoiceRecognitionClient sharedInstance] setLanguage:[BDVRSConfig sharedInstance].recognitionLanguage];
    
    // 是否打开语音音量监听功能，可选
    if ([BDVRSConfig sharedInstance].voiceLevelMeter)
    {
        BOOL res = [[BDVoiceRecognitionClient sharedInstance] listenCurrentDBLevelMeter];
        
        if (res == NO)  // 如果监听失败，则恢复开关值
        {
            [BDVRSConfig sharedInstance].voiceLevelMeter = NO;
        }
    }
    else
    {
        [[BDVoiceRecognitionClient sharedInstance] cancelListenCurrentDBLevelMeter];
    }
    
    // 设置播放开始说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecStart isPlay:[BDVRSConfig sharedInstance].playStartMusicSwitch];
    // 设置播放结束说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecEnd isPlay:[BDVRSConfig sharedInstance].playEndMusicSwitch];
    
    // 加载离线识别引擎
    NSString* appCode = APPID;
    //    NSString* licenseFilePath= [[NSBundle mainBundle] pathForResource:@"bdasr_temp_license" ofType:@"dat"];
    NSString* datFilePath = [[NSBundle mainBundle] pathForResource:@"s_1" ofType:@""];
    NSString* LMDatFilePath = nil;
    if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyMap) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_Navi" ofType:@""];
    } else if ([[BDVRSConfig sharedInstance].recognitionProperty intValue] == EVoiceRecognitionPropertyInput) {
        LMDatFilePath = [[NSBundle mainBundle] pathForResource:@"s_2_InputMethod" ofType:@""];
    }
    
    NSDictionary* recogGrammSlot = @{@"$name_CORE" : @"张三\n李四\n",
                                     @"$song_CORE" : @"小苹果\n朋友\n",
                                     @"$app_CORE" : @"QQ\n百度\n微信\n百度地图\n",
                                     @"$artist_CORE" : @"刘德华\n周华健\n"};
    
    int ret = [[BDVoiceRecognitionClient sharedInstance] loadOfflineEngine:appCode
                                                                   license:nil
                                                                   datFile:datFilePath
                                                                 LMDatFile:LMDatFilePath
                                                                 grammSlot:recogGrammSlot];
    if (0 != ret) {
        NSLog(@"load offline engine failed: %d", ret);
        return;
    }
    
    // 创建语音识别界面，在其viewdidload方法中启动语音识别
    BDVRCustomRecognitonViewController *tmpAudioViewController = [[BDVRCustomRecognitonViewController alloc] initWithNibName:nil bundle:nil];
    tmpAudioViewController.clientSampleViewController = self;
    self.audioViewController = tmpAudioViewController;
    [[UIApplication sharedApplication].keyWindow addSubview:_audioViewController.view];
}

#pragma mark - BDRecognizerViewDelegate
- (void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerView withResults:(NSArray *)aResults
{
    _textView.text = nil;
    
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
    {
        // 搜索模式下的结果为数组，示例为
        // ["公园", "公元"]
        NSMutableArray *audioResultData = (NSMutableArray *)aResults;
        NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
        
        for (int i=0; i < [audioResultData count]; i++)
        {
            [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
        }
        
        _textView.text = [_textView.text stringByAppendingString:tmpString];
        _textView.text = [_textView.text stringByAppendingString:@"\n"];
        
    }
    else
    {
        NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aResults];
        
        _textView.text = [_textView.text stringByAppendingString:tmpString];
        _textView.text = [_textView.text stringByAppendingString:@"\n"];
    }
}


-(void)onComplete:(BDVRDataUploader *)dataUploader error:(NSError *)error
{
    if (error.code == 0) {
        [self logOutToLogView:@"联系人上传成功"];
    } else {
        [self logOutToLogView:[NSString stringWithFormat:@"联系人上传失败。错误码：%ld", (long)error.code]];
    }
}

- (void)VoiceRecognitionClientWorkStatus:(int) aStatus obj:(id)aObj
{
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusFinish:
        {
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
            {
                NSMutableArray *audioResultData = (NSMutableArray *)aObj;
                NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
                
                for (int i=0; i<[audioResultData count]; i++)
                {
                    [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
                }
                self.textView.text = nil;
                [self logOutToManualResut:tmpString];
            }
            else
            {
                self.textView.text = nil;
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                [self logOutToManualResut:tmpString];
            }
            [self logOutToLogView:@"识别完成"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData:
        {
            NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
            
            [tmpString appendFormat:@"%@",[aObj objectAtIndex:0]];
            self.textView.text = nil;
            [self logOutToManualResut:tmpString];
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusReceiveData:
        {
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] == EVoiceRecognitionPropertyInput)
            {
                self.textView.text = nil;
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                [self logOutToManualResut:tmpString];
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}


#pragma mark - log & result

- (void)logOutToContinusManualResut:(NSString *)aResult
{
    _textView.text = aResult;
}

- (void)logOutToManualResut:(NSString *)aResult
{
    NSString *tmpString = _textView.text;
    
    if (tmpString == nil || [tmpString isEqualToString:@""])
    {
        _textView.text = aResult;
    }
    else
    {
        _textView.text = [_textView.text stringByAppendingString:aResult];
    }
}

- (void)logOutToLogView:(NSString *)aLog
{
//    NSString *tmpString = _logCatView.text;
//    
//    if (tmpString == nil || [tmpString isEqualToString:@""])
//    {
//        _logCatView.text = aLog;
//    }
//    else
//    {
//        _logCatView.text = [_logCatView.text stringByAppendingFormat:@"\r\n%@", aLog];
//    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_bgView endEditing:YES];
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clean
{
    _textView.text = nil; //  清除logview，避免打印过慢，影响UI
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
