//
//  IPadProjectInfoTableViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/17/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectInfoTableViewController.h"
#import "GlobalProject.h"

@interface IPadProjectInfoTableViewController ()

@end

@implementation IPadProjectInfoTableViewController
@synthesize project = _project;
@synthesize projectTitle = _projectTitle;
@synthesize projectGenre = _projectGenre;
@synthesize projectType = _projectType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView = myTable;
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View is loading");
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    _projectTitle.text = gp.project.title;
    _projectGenre.text = gp.project.genre;
    _projectType.text = gp.project.type;
    NSLog(@"Title is: %@", _project.title);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTitle";
    PrettyTableViewCell *cell = (PrettyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrettyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTitle"];
    }
    [cell prepareForTableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        CGFloat groupMargin;
        CGFloat tableViewWidth = tableView.frame.size.width;
        if (tableViewWidth > 20)
            groupMargin = (tableViewWidth < 400) ? 10 : MAX(31, MIN(45, tableViewWidth*0.06));
        else
            groupMargin = tableViewWidth - 10;
        CGFloat width = [tableView rectForRowAtIndexPath:indexPath].size.width - (groupMargin *2);
        CGFloat height = [tableView rectForRowAtIndexPath:indexPath].size.height;
        CGRect textFrame = CGRectMake(5, 0, width - 10, height);
        NSLog(@"cell width is %f cell height is %f", cell.frame.size.width, cell.frame.size.height);
        UITextField *tf = [[UITextField alloc] initWithFrame:textFrame];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:50.0];
        [tf setAdjustsFontSizeToFitWidth:YES];
        [tf setMinimumFontSize:16.0];
        tf.text = _project.title;
        [cell.contentView addSubview:tf];
        CGRect titleFrame = CGRectMake(5, 5, 200, 20);
        UILabel *cellTitle = [[UILabel alloc] initWithFrame:titleFrame];
        cellTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        cellTitle.textColor = [UIColor grayColor];
        cellTitle.text = @"Science Fiction Short Story";
        cellTitle.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:cellTitle];
    }
    
    // Configure the cell...
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
    }
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return tableView.rowHeight+ 50.0 + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return tableView.rowHeight+ 300.0 + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
    }
}

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

@end
