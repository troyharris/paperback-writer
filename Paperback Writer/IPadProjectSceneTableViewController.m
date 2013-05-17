//
//  IPadProjectSceneTableViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectSceneTableViewController.h"
#import <FMMoveTableViewCell.h>
#import "Scene.h"
#import "GlobalProject.h"
#import "AppDelegate.h"
#import "IPadNewSceneViewController.h"

@interface IPadProjectSceneTableViewController ()

@end

@implementation IPadProjectSceneTableViewController

@synthesize project = _project;
@synthesize outline = _outline;
@synthesize scenes = _scenes;
@synthesize nextOrderNum = _nextOrderNum;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)showNewScene {
    IPadNewSceneViewController *controller = [[IPadNewSceneViewController alloc] init];
    [controller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    controller.outline = _outline;
    controller.nextOrderNum = _nextOrderNum;
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
    [self buildScenes];
    [self.tableView reloadData];
}


-(void)moveScene:(Scene *)scene to:(NSNumber *)toNum {
    NSLog(@"Moving %d to %d", [scene.orderNum intValue], [toNum intValue]);
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    if ([scene.orderNum intValue] > [toNum intValue]) {
        NSLog(@"Moving Up");
        for (Scene *s in _scenes) {
            if ([s.orderNum intValue] >= [toNum intValue] && [s.orderNum intValue] < [scene.orderNum intValue]) {
                int newOrder = [s.orderNum intValue];
                newOrder++;
                s.orderNum = [NSNumber numberWithInt:newOrder];
            }
        }
    } else {
        NSLog(@"Moving Down");
        for (Scene *s in _scenes) {
            if ([s.orderNum intValue] > [scene.orderNum intValue] && [s.orderNum intValue] <= [toNum intValue]) {
                int newOrder = [s.orderNum intValue];
                newOrder--;
                NSLog(@"Will move %d to %d", [s.orderNum intValue], newOrder);
                s.orderNum = [NSNumber numberWithInt:newOrder];
            } else {
                NSLog(@"Scene does not match: %d", [s.orderNum intValue]);
            }
        }
    }
    scene.orderNum = toNum;
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)deleteScene:(Scene *)scene {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    for (Scene *s in _scenes) {
        if (s.orderNum > scene.orderNum) {
            int newOrder = [s.orderNum intValue];
            newOrder--;
            s.orderNum = [NSNumber numberWithInt:newOrder];
        }
    }
    [context deleteObject:scene];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)buildScenes {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title like %@) AND (self in %@)", @"Main", _project.outlines];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Outline" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *outlines = [context executeFetchRequest:request error:&error];
    _outline = [outlines objectAtIndex:0];
  //  NSLog(@"Number of outlines: %d title: %@", [outlines count], _outline.title);
    NSArray *unsortScenes = [_outline.scenes allObjects];
    _scenes = [unsortScenes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(Scene *)a orderNum];
        NSNumber *second = [(Scene *)b orderNum];
        return [first compare:second];
    }];
    Scene *lastScene = [_scenes lastObject];
    NSNumber *lastNumber = lastScene.orderNum;
    int nextNumber = [lastNumber intValue] + 1;
 //   NSLog(@"Next number is %d", nextNumber);
    _nextOrderNum = [NSNumber numberWithInt:nextNumber];
   // NSLog(@"There are %d scenes", [_scenes count]);
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

- (NSInteger)tableView:(FMMoveTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = [_scenes count];
	if ([tableView movingIndexPath] && [[tableView movingIndexPath] section] != [[tableView initialIndexPathForMovingRow] section])
	{
		if (section == [[tableView movingIndexPath] section]) {
			numberOfRows++;
		}
		else if (section == [[tableView initialIndexPathForMovingRow] section]) {
			numberOfRows--;
		}
	}
    return numberOfRows;
}

- (UITableViewCell *)tableView:(FMMoveTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"I'm getting in here.");
	static NSString *cellIdentifier = @"MoveCell";
	FMMoveTableViewCell *cell = (FMMoveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FMMoveTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
        cell.textLabel.text = scene.title;
        cell.detailTextLabel.text = [scene.orderNum stringValue];
      //  NSLog(@"Scene title is: %@", scene.title);
    }
    
    // Configure the cell...
    
    return cell;
}

- (BOOL)moveTableView:(FMMoveTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     NSLog(@"Number of Scenes before are: %d", [_scenes count]);
     Scene *scene = [_scenes objectAtIndex:indexPath.row];
     [self deleteScene:scene];
     [self buildScenes];
     NSLog(@"Number of Scenes after are: %d", [_scenes count]);
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
    Scene *scene = [_scenes objectAtIndex:fromIndexPath.row];
    Scene *toScene = [_scenes objectAtIndex:toIndexPath.row];
    NSNumber *toNum = toScene.orderNum;
    [self moveScene:scene to:toNum];
    [self buildScenes];
    [self.tableView reloadData];
}

@end
