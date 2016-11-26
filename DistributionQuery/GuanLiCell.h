//
//  GuanLiCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanLiCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(UIButton *btn,NSIndexPath *indexPath);
@end
