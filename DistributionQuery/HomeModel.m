//
//  HomeModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
#pragma mark --特价专区Model
-(id)initWithTeJiaDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
    }
    
    return self;
}
//优质现货
-(id)initWithYouZhiXianHuoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         NSString * image =[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        NSLog(@"aa输出%@",sheng);
        NSLog(@"bb输出%@",city);
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
          NSLog(@"cc输出%@",_cityName);
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
        
    }
    
    return self;
}

@end
