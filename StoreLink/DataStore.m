//
//  DataStore.m
//  StoreLink
//
//  Created by Apple on 2/19/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore
+(id)sharedDataStore{
    
    static DataStore *sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedDataStore = [[self alloc]init];

    });
    return sharedDataStore;
}
- (id) init{
    self = [super init];
    if (self){
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        NSURL *fileDataUrl = [FileSystemHelper pathforDocumentFile:@"StoreLink.sqlite"];
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileDataUrl options:0 error:&error]){
            NSLog(@"Unresolve error: %@, %@", error, [error userInfo]);
            abort();
        }
        
        _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:psc];
    }
    return self;
}
- (BOOL)saveChanges{
    NSError*error;
    if (![_context save:&error]){
        NSLog(@"Error: %@",[error localizedDescription]);
        return NO;
    }else
        return YES;
}

@end
