//
//  XiangQingModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiangQingModel.h"

@implementation XiangQingModel
//详情信息
-(id)initWithXiangXiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]]];
        _imagename=image;
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[self string:[dic objectForKey:@"C_ExpectPrice"]]];
        _bianHaoName=[ToolClass isString:[self string:[dic objectForKey:@"C_ProductCode"]]];
        _phoneName=[ToolClass isString:[dic objectForKey:@""]];
        //具体参数
        _xinagHaoName=[ToolClass isString:[dic objectForKey:@""]];
        NSString * chanSheng =[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        NSString * chashi =[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        _chanDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        _shuLiangName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _suozaiDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        //详细信息
        _xiangXiName=[ToolClass isString:[dic objectForKey:@"C_Description"]];
        
        
    }
    
    return self;
}
-(NSString*)string:(id)str{
    NSString *stri =[NSString stringWithFormat:@"%@",str];
    
    return str;
}
@end
