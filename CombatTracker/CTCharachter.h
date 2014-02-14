//
//  CTCharachter.h
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CTCampaign;

@interface CTCharachter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * mHP;
@property (nonatomic, retain) NSNumber * mFP;
@property (nonatomic, retain) NSNumber * mER;
@property (nonatomic, retain) NSNumber * shock;
@property (nonatomic, retain) NSNumber * stun;
@property (nonatomic, retain) NSDecimalNumber * posture;
@property (nonatomic, retain) NSNumber * manuver;
@property (nonatomic, retain) NSNumber * cER;
@property (nonatomic, retain) NSNumber * cFP;
@property (nonatomic, retain) NSNumber * cHP;
@property (nonatomic, retain) NSDecimalNumber * cFate;
@property (nonatomic, retain) NSDecimalNumber * mFate;
@property (nonatomic, retain) NSDate * luck;
@property (nonatomic, retain) CTCampaign *campaign;

@end
