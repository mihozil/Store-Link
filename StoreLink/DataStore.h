//
//  DataStore.h
//  StoreLink
//
//  Created by Apple on 2/19/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FileSystemHelper.h"

@interface DataStore : NSObject{
    NSManagedObjectModel *model;
}
@property (nonatomic, strong) NSManagedObjectContext *context;
+(id) sharedDataStore;
- (BOOL) saveChanges;

@end
