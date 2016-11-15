//
//  XiangQingModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiangQingModel : NSObject
//轮播图
@property(nonatomic,strong)NSArray * imageArr;//现在没有轮播就有一张图片先用图片表示
@property(nonatomic,copy)NSString *imagename;
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString* priceName;
@property(nonatomic,copy)NSString*bianHaoName;
@property(nonatomic,copy)NSString * phoneName;
//具体参数
@property(nonatomic,copy)NSString * xinagHaoName;
@property(nonatomic,copy)NSString * chanDiName;
@property(nonatomic,copy)NSString * shuLiangName;
@property(nonatomic,copy)NSString * suozaiDiName;
//详细信息
@property(nonatomic,copy)NSString * xiangXiName;
//猜你喜欢
-(id)initWithXiangXiDic:(NSDictionary*)dic;

@end