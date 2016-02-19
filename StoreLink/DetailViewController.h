//
//  DetailViewController.h
//  StoreLink
//
//  Created by Apple on 2/18/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@property (nonatomic, strong) NSManagedObject *item; 

@end
