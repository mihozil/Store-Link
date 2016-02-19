//
//  DetailViewController.m
//  StoreLink
//
//  Created by Apple on 2/18/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "DetailViewController.h"
#import <SafariServices/SafariServices.h>

@interface  DetailViewController () <UITextFieldDelegate>


@end

@implementation DetailViewController
- (void) initClass{
    if (self.item){
        self.titleTextField.text = [self.item valueForKey:@"title"];
        self.detailTextField.text = [self.item valueForKey:@"details"];
        self.urlTextField.text = [self.item valueForKey:@"url"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initClass];
}



- (IBAction)saveAction:(id)sender {
    
    DataStore *dataStore = [DataStore sharedDataStore];
    
    NSManagedObjectContext *context = [dataStore context];
    NSLog(@"Save Context: %@",context);
    
    if (!self.item){
        NSManagedObject *item = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:context];
        [item setValue:self.titleTextField.text forKey:@"title"];
        [item setValue:self.detailTextField.text forKey:@"details"];
        [item setValue:self.urlTextField.text forKey:@"url"];
        
    }else {
        // update in NSManagedObject
        [self.item setValue:self.titleTextField.text forKey:@"title"];
        [self.item setValue:self.detailTextField.text forKey:@"details"];
        [self.item setValue:self.urlTextField.text forKey:@"url"];
    }
    if (![dataStore saveChanges]){
        NSLog(@"Can not save");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goAction:(id)sender {
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    SFSafariViewController*safari = [[SFSafariViewController alloc]initWithURL:url];
    [self presentViewController:safari animated:YES completion:nil];
    
}


@end
