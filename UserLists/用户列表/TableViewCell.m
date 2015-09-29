//
//  TableViewCell.m
//  用户列表
//
//  Created by hyrMac on 15/8/16.
//  Copyright (c) 2015年 hyrMac. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModal:(QueryModal *)modal {
    _modal = modal;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    _userName.text = _modal.userName;
    _age.text = _modal.age;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
