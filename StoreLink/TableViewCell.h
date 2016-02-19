//
//  TableViewCell.h
//  StoreLink
//
//  Created by Apple on 2/18/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end
