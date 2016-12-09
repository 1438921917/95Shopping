//
//  ShangXinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShangXinVC.h"

@interface ShangXinVC ()

@end

@implementation ShangXinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dataShuJuPage:@"1"];
}
-(void)dataShuJuPage:(NSString*)page{
    [Engine huoQuZiXunListViewCid:@"2" YeShuPage:page success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
