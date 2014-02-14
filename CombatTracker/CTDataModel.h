//
//  CTDataModel.h
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class   NSManagedObjectContext;


@interface CTDataModel : NSObject
@property (strong, nonatomic) NSManagedObjectContext*   context;
@property (strong, nonatomic) NSPersistentStoreCoordinator* coordinator;

+(CTDataModel*)sharedInstance;

@end
