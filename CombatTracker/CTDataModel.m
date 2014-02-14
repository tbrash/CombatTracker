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
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        [self.context setPersistentStoreCoordinator:self.coordinator];
    }
    return self;
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
