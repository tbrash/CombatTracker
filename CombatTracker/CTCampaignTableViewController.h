//
//  CTCampaignTableViewController.h
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSFetchedResultsController;

@interface CTCampaignTableViewController : UITableViewController

@property (strong, nonatomic) NSOrderedSet*  campaigns;
@property (strong, nonatomic) NSFetchedResultsController*  controller;


@end


@interface CTCampaignCell : UITableViewCell

@end
