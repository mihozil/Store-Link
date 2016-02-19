//
//  FileSystemHelper.m
//  StoreLink
//
//  Created by Apple on 2/19/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "FileSystemHelper.h"

@implementation FileSystemHelper
+(NSURL *)pathforDocumentFile:(NSString *)nameDatabase{
     NSURL *path = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:nameDatabase];
    return path;
}

@end
