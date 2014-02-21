//
//  CTDataModel.m
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import "CTDataModel.h"
#import <CoreData/CoreData.h>

@implementation CTDataModel

-(CTDataModel*)init
{
    self = [super init];
    if( self != nil )
    {

        
        //NSString *storePath = [[NSString stringWithFormat:@"%@", ] stringByAppendingPathComponent:@"tracker.sqlite"];
        //NSURL *storeURL = [self applicationDocumentsDirectory];
        
        NSString *storePath = [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"tracker.sqlite"];
        NSURL *storeURL = [NSURL fileURLWithPath:storePath];

        
        NSError *error = nil;
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [NSManagedObjectModel mergedModelFromBundles:nil]];
        
        if (![self.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Can't make Persistent Store! %@ %@", error, [error localizedDescription]);
        }
        
  //      self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType ];
        
        [self.context setPersistentStoreCoordinator:self.coordinator];
    }
    return self;
}

- (NSURL *)applicationDocumentsDirectory
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    return [NSURL fileURLWithPath:documentPath];
}


-(void)dealloc
{
    self.context = nil;
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
