//
//  TableViewCell.m
//  StoreLink
//
//  Created by Apple on 2/18/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize titleLabel = _titleLabel;
@synthesize detailsLabel = _detailsLabel;


- (void)awakeFromNib {
    // Initialization code
    
    NSLog(@"asdfdfghfghj");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   
    // Configure the view for the selected state
}


@end
