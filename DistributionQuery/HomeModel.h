//
//  HomeModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
#pragma mark --特价专区Model
@property (nonatomic,copy)NSString * imageview;
@property (nonatomic,copy)NSString * titleName;
@property (nonatomic,copy)NSString * priceName;
@property (nonatomic,copy)NSString * cityName;
@property (nonatomic,copy)NSString * taishuName;
@property(nonatomic,copy)NSString * sheBeiName;
@property(nonatomic,copy)NSString * messageID;
-(id)initWithTeJiaDic:(NSDictionary*)dic;
//优质现货
-(id)initWithYouZhiXianHuoDic:(NSDictionary*)dic;
@end
