//
//  IPadProjectResearchTableViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/30/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectResearchTableViewController.h"
#import "Research.h"
#import "Note.h"
#import "GlobalProject.h"
#import "UIColor+THColor.h"
#import "AppDelegate.h"
#import <UIColor+FlatUI.h>

@interface IPadProjectResearchTableViewController ()

@end

@implementation IPadProjectResearchTableViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)buildResearch {
    _researches = [[NSMutableArray alloc] init];
    for (Research *r in _project.researches) {
        [_researches addObject:r];
    }
}

-(void)deleteResearch:(Research *)r {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    [context deleteObject:r];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)showNewResearch {
    _addResearch = [[IPadNewResearchViewController alloc] init];
    NSLog(@"WE GOT HERE!");
    
    [self presentModalViewController:_addResearch animated:YES];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor projectBackgroundColor];
    self.tableView.separatorColor = [UIColor silverColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNewResearch)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    [self buildResearch];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Research count is: %d", [_researches count]);
    return [_researches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Research *r = [_researches objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor projectBackgroundColor];
    cell.textLabel.text = r.notes.desc;
    cell.detailTextLabel.text = r.type;
    cell.textLabel.font = [UIFont fontWithName:@"Lato-Bold" size:20];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Lato-Light" size:14];
    cell.textLabel.tintColor = [UIColor projectDarkTextColor];
    cell.detailTextLabel.tintColor = [UIColor projectHighlightColor];
    NSLog(@"Row text should be: %@", r.notes.desc);
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Research *deletedResearch = [_researches objectAtIndex:indexPath.row];
        [self deleteResearch:deletedResearch];
        [_researches removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
