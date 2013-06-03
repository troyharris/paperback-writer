//
//  IPadProjectOutlineTableViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectOutlineTableViewController.h"
#import <FMMoveTableViewCell.h>
#import "Scene.h"
#import "GlobalProject.h"
#import "AppDelegate.h"
#import "IPadNewSceneViewController.h"
#import "SceneCell.h"


@interface IPadProjectOutlineTableViewController ()

@end

@implementation IPadProjectOutlineTableViewController

@synthesize project = _project;
@synthesize outline = _outline;
@synthesize scenes = _scenes;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)showNewScene {
    IPadNewSceneViewController *controller = [[IPadNewSceneViewController alloc] init];
    [controller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    controller.outline = _outline;
    [self presentViewController:controller animated:YES completion:nil];
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
    self.tableView = [[FMMoveTableView alloc] init];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNewScene)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    if ([_project.outlines count] == 0) {
        Outline *outline = [NSEntityDescription insertNewObjectForEntityForName:@"Outline" inManagedObjectContext:context];
        outline.title = @"Main";
        [_project addOutlinesObject:outline];
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"The save was successful!");
        } else {
            NSLog(@"The save wasn't successful: %@", [error userInfo]);
        }
        NSLog(@"Added an outline");
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title like %@) AND (self in %@)", @"Main", _project.outlines];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Outline" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *outlines = [context executeFetchRequest:request error:&error];
    _outline = [outlines objectAtIndex:0];
    NSLog(@"Number of outlines: %d title: %@", [outlines count], _outline.title);
    _scenes = [_outline.scenes allObjects];
    NSLog(@"There are %d scenes", [_scenes count]);
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
    return 0;
}

- (NSInteger)tableView:(FMMoveTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_scenes count];
}

- (UITableViewCell *)tableView:(FMMoveTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"I'm getting in here.");
	static NSString *cellIdentifier = @"MoveCell";
	SceneCell *cell = (SceneCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SceneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if ([tableView indexPathIsMovingIndexPath:indexPath])
	{
		[cell prepareForMove];
	}
	else
	{
#warning Implement this check in your table view data source
		/******************************** NOTE ********************************
		 * Implement this check in your table view data source to ensure correct access to the data source
		 *
		 * The data source is in a dirty state when moving a row and is only being updated after the user
		 * releases the moving row
		 **********************************************************************/
		if ([tableView movingIndexPath]) {
            indexPath = [tableView adaptedIndexPathForRowAtIndexPath:indexPath];
		}
        
        Scene *scene = (Scene *)[_scenes objectAtIndex:indexPath.row];
        cell.sceneTitle.text = scene.title;
        NSLog(@"Scene title is: %@", scene.title);
    }

    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)moveTableView:(FMMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}

@end
