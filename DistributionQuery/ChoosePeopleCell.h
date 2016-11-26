//
//  ChoosePeopleCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePeopleCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UIButton *duiGouBtn;//对勾btn

@end
