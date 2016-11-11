//
//  ToolClass.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject

#pragma mark --判断是否登录（登录YES）
+(BOOL)isLogin;
#pragma mark --适配高度
+(CGFloat)cellContentViewWith;
#pragma mark --根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;

@end
