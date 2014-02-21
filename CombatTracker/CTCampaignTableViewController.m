//
//  CTCampaignTableViewController.m
//  CombatTracker
//
//  Created by Altus on 2/11/14.
//  Copyright (c) 2014 Altus. All rights reserved.
//

#import "CTCampaignTableViewController.h"
#import <CoreData/CoreData.h>
#import "CTDataModel.h"
#import "CTCampaign.h"
#import "CTAppDelegate.h"


@implementation CTCampaignCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.name.borderStyle = UITextBorderStyleNone;
    
    self.name.enabled = NO;
    
    self.name.delegate = self;
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (IBAction)nameChanged:(UITextField*)sender {
    sender.enabled = NO;
    self.camp.name = sender.text;
    NSError* error;
    if (![[CTDataModel sharedInstance].context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}



@end

@interface CTCampaignTableViewController ()
@end


@implementation CTCampaignTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(_controller == nil)
    {
        
        
      //  [self.tableView registerClass:[CTCampaignCell class] forCellReuseIdentifier:@"campaignCell"];
        
      //  [[CTDataModel sharedInstance].context save:nil];

        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CTCampaign"];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        self.controller = [[NSFetchedResultsController alloc]
                           initWithFetchRequest:fetchRequest
                           managedObjectContext:[CTDataModel sharedInstance].context
                           sectionNameKeyPath:nil
                           cacheName:nil];
        NSError* error;
        // Save the object to persistent store
        if (![self.controller performFetch:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelectionDuringEditing = YES;
    //self.editButtonItem.action
}



- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_controller sections] objectAtIndex:0];

    if(editing == YES)
    {
        if([[_controller sections] count]==0)
        {
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[sectionInfo numberOfObjects] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        if(self.curentlyEditing)
            [self.curentlyEditing nameChanged:self.curentlyEditing.name] ;

        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[sectionInfo numberOfObjects] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        if([[_controller sections] count]==0)
        {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSUInteger count = [[_controller sections] count];
    if(count == 0 && [self isEditing])
        count++;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([[_controller sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_controller sections] objectAtIndex:section];
        NSUInteger count = [sectionInfo numberOfObjects];
        if([self isEditing])
        {
            count++;
        }
        return count;
    } else if([self isEditing])
    {
        return 1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"campaignCell";
    CTCampaignCell *cell = (CTCampaignCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell with data from the managed object.
    if ([[_controller sections] count] > indexPath.section)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_controller sections] objectAtIndex:indexPath.section];
        NSUInteger count = [sectionInfo numberOfObjects];
        if( count > indexPath.row)
        {
            CTCampaign *managedObject = [_controller objectAtIndexPath:indexPath];

            cell.name.text = managedObject.name;
            cell.camp = managedObject;
            cell.name.enabled = NO;

        }else
        {
            cell.name.text = @"Create Campaign";
            cell.camp = nil;
            cell.name.enabled = NO;

        }
    }

    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_controller sections] objectAtIndex:0];

    if (indexPath.section < [[self.controller sections] count] && indexPath.row < [sectionInfo numberOfObjects])
        return YES;
    else
        return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CTCampaign *managedObject = [_controller objectAtIndexPath:indexPath];
        [self deleteCampaign:managedObject];
        // Delete the row from the data source
        //[self.controller.managedObjectContext deleteObject:managedObject];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_controller sections] objectAtIndex:indexPath.section];
    if ([tableView isEditing]) {
        NSUInteger count = [sectionInfo numberOfObjects];
        if(count == indexPath.row)
        {
            [self newCampaign];
        }else{
            CTCampaignCell* cell = (CTCampaignCell*)[tableView cellForRowAtIndexPath:indexPath];
            self.curentlyEditing = cell;
            cell.name.enabled = YES;
            [cell.name becomeFirstResponder];
        }

    }else
    {
        CTCampaign *managedObject = [_controller objectAtIndexPath:indexPath];\
        [self loadCampaign:managedObject];

    }
}

-(void)newCampaign
{
    CTCampaign *camp = [NSEntityDescription
                        insertNewObjectForEntityForName:@"CTCampaign"
                        inManagedObjectContext:[CTDataModel sharedInstance].context];
    camp.name = @"New Campaign";
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![[CTDataModel sharedInstance].context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    if (![self.controller performFetch:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self.tableView insertRowsAtIndexPaths:@[[self.controller indexPathForObject:camp]] withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void)loadCampaign:(CTCampaign*)campaign
{
    
    [self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>
    
}

-(void)deleteCampaign:(CTCampaign*)campaign
{
    [_controller.managedObjectContext deleteObject:campaign];
    NSError *error;
    if (![_controller.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    if (![self.controller performFetch:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    //[self.tableView setNeedsDisplay];
    
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
