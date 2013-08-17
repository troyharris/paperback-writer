//
//  IPadCharacterInfoTableViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterInfoTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface IPadCharacterInfoTableViewController ()

@end

@implementation IPadCharacterInfoTableViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)saveCharacter {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    self.character.name = self.name.text;
    self.character.gender = self.gender.text;
    self.character.age = self.age.text;
    self.character.weight = self.weight.text;
    self.character.height = self.height.text;
    self.character.hair = self.hair.text;
    self.character.skin = self.skin.text;
    self.character.appearance = self.notables.text;
    self.character.myers = self.myers.text;
    self.character.personality = self.other.text;
    self.character.motivation = self.motivation.text;
    self.character.role = self.role.text;
    self.character.symbols = self.symbols.text;
    self.character.other = self.storyOther.text;
    self.character.traits = self.traits.text;
    self.character.sign  = self.sign.text;
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
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
    [self.name setupLabel];
    self.name.backgroundColor = [UIColor clearColor];
    self.name.font = [UIFont fontWithName:@"Lato-Light" size:60];
    
    self.portrait.layer.cornerRadius = self.portrait.frame.size.width / 2;
    self.portrait.layer.masksToBounds = YES;
    
    [self mapDataToFields];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self mapDataToFields];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveCharacter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapDataToFields {
    self.name.text = self.character.name;
    self.gender.text = self.character.gender;
    self.height.text = self.character.height;
    self.weight.text = self.character.weight;
    self.notables.text = self.character.appearance;
    self.age.text = self.character.age;
    self.skin.text = self.character.skin;
    self.hair.text = self.character.hair;
    self.myers.text = self.character.myers;
    self.sign.text = self.character.sign;
    self.traits.text = self.character.traits;
    self.role.text = self.character.role;
    self.motivation.text = self.character.motivation;
    self.symbols.text = self.character.symbols;
    self.storyOther.text = self.character.other;
    self.other.text = self.character.personality;
}

#pragma mark - Table view data source

/* Static table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
 
 */

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
