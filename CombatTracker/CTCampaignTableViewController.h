//
//  CTCampaignTableViewController.h
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSFetchedResultsController;
@class CTCampaign;

@interface CTCampaignCell : UITableViewCell<UITextFieldDelegate>

@property (strong, nonatomic) CTCampaign* camp;

@property (weak, nonatomic) IBOutlet UITextField *name;
- (IBAction)nameChanged:(UITextField*)sender;

@end

@interface CTCampaignTableViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController*  controller;

@property (weak, nonatomic) CTCampaignCell* curentlyEditing;


@end

