//
//  Engine.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Engine.h"

#import "AFNetworking.h"
@implementation Engine
#pragma mark --获取首页轮播图
+(void)getFirstImagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
//    NSString * urlStr =[NSString stringWithFormat:@"%@MobileIndex/MGetNews.ashx",SERVICE];
//     NSURL * url = [NSURL URLWithString:urlStr];
//    __weak ASIFormDataRequest * req = [ASIFormDataRequest requestWithURL:url];
//    [req setCompletionBlock:^{
//        
//         NSLog(@">>>%@",req.responseString);
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:req.responseData options:NSJSONReadingMutableContainers error:nil];
//        aSuccess(dic);
//    }];
//    [req startAsynchronous];
//    [req  setFailedBlock:^{
//         NSLog(@"失败%@",req.responseString);
//    }];
 
}
#pragma mark --1.获取首页特价专区
+(void)FirstTeJiaZhuanQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDiscountList?Count=10",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.获取首页特价专区%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"1.获取首页特价专区%@",error);
    }];

}


#pragma mark --2.列表详情界面
+(void)tableViewXiangQingJieMianMessageID:(NSString*)messageId success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   // http://api.hs95.com/Commodity/GetDetail?Id=7458
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDetail?Id=%@",SER_VICE,messageId];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2.列表详情界面%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"列表详情界面%@",error);
    }];
    
}

#pragma mark --3.特价专区列表
+(void)tejiaZhuanQuLieBiaoHangYeID:(NSString*)category DiQu:(NSString*)area GuanJianZi:(NSString*)keyword Page:(NSString*)page PageSize:(NSString*)pagesize success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetList?Category=%@&Area=%@&Keyword=%@&Page=%@&PageSize=%@",SER_VICE,category,area,keyword,page,pagesize];
    NSLog(@"3.特价专区列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"3.特价专区列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"3.特价专区列表%@",error);
    }];
}

@end
