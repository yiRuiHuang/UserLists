//
//  TableViewCell.h
//  用户列表
//
//  Created by hyrMac on 15/8/16.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryModal.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *age;

@property (nonatomic, strong) QueryModal *modal;
@end
