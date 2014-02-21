//
//  CTCharachterViewController.h
//  CombatTracker
//
//  Created by Altus on 2/20/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCampaign;
@interface CTCombatViewController : UICollectionViewController

- (IBAction)nextCharachter:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property (strong, nonatomic) CTCampaign* camp;

@end
