//
//  ViewController.m
//  StoreLink
//
//  Created by Apple on 2/18/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "TableViewCell.h"
#import "DataStore.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController{
    NSMutableArray *dataArray;
}
- (void) initPrj{
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self initPrj];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self getData];
}
- (void) getData{
    // update tableView
    DataStore *dataStore = [DataStore sharedDataStore];
    NSManagedObjectContext *context = [dataStore context];
    
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Items"];
    NSError*error;
    
    dataArray = [[context executeFetchRequest:req error:&error]mutableCopy];
    if (!dataArray){
        NSLog(@"An error has occured: %@",[error localizedDescription]);
        
    }else
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // push to new view controller
    if ([[segue identifier]isEqualToString:@"AddNew"] ){
        DetailViewController* detailVC = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"EditCell"]){
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.item = dataArray[path.row];
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSManagedObject*item = dataArray[indexPath.row];
   
    cell.titleLabel.text = [item valueForKey:@"title"];
    
    cell.detailsLabel.text = [item valueForKey:@"details"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DataStore*dataStore = [DataStore sharedDataStore];
    NSManagedObjectContext*context = [dataStore context];
    NSError *error = nil;
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        NSManagedObject *item = [dataArray objectAtIndex:indexPath.row];
        [context deleteObject:item];
        
        if (![context save:&error]){
            NSLog(@"Can not delete: %@",[error localizedDescription]);
        }
        
         [dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];
       
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"EditCell" sender:nil];
}
@end
