//
//  YouZhiXianHuoCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouZhiXianHuoCell : UITableViewCell
@property(nonatomic,strong)UIButton * chaKanBtn;//立即查看
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@end
