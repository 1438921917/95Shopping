//
//  Engine.h
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);
@interface Engine : NSObject
//**********************************首页**********************//
#pragma mark --获取首页轮播图
+(void)getFirstImagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --1.获取首页特价专区
+(void)FirstTeJiaZhuanQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --2.列表详情界面
+(void)tableViewXiangQingJieMianMessageID:(NSString*)messageId success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --3.特价专区列表
+(void)tejiaZhuanQuLieBiaoHangYeID:(NSString*)category DiQu:(NSString*)area GuanJianZi:(NSString*)keyword Page:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
@end
