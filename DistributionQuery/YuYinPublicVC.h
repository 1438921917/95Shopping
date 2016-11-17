//
//  YuYinPublicVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"
#import "BDRecognizerViewController.h"
#import "BDRecognizerViewDelegate.h"
#import "BDVRFileRecognizer.h"
#import "BDVRDataUploader.h"


@class BDVRCustomRecognitonViewController;

@interface YuYinPublicVC : BaseViewController <BDRecognizerViewDelegate, MVoiceRecognitionClientDelegate, BDVRDataUploaderDelegate>
@property(nonatomic,strong)UITextView * textView;
@property (nonatomic, retain) BDVRCustomRecognitonViewController *audioViewController;
@property (nonatomic, retain) BDRecognizerViewController *recognizerViewController;
@property (nonatomic, retain) BDVRRawDataRecognizer *rawDataRecognizer;
@property (nonatomic, retain) BDVRFileRecognizer *fileRecognizer;
@property (nonatomic, retain) BDVRDataUploader *contactsUploader;



//用来区分是标题0，还是本来界面1(>>委托发布>>语音发布)
@property(nonatomic,assign)NSInteger tagg;
@end
