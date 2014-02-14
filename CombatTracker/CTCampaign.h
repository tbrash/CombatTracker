//
//  CTCampaign.h
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CTCampaign;

@interface CTCampaign : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *charachters;
@end

@interface CTCampaign (CoreDataGeneratedAccessors)

- (void)addCharachtersObject:(CTCampaign *)value;
- (void)removeCharachtersObject:(CTCampaign *)value;
- (void)addCharachters:(NSSet *)values;
- (void)removeCharachters:(NSSet *)values;

@end
