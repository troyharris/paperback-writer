//
//  IPadProjectCharacterViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectCharacterViewController.h"
#import "Character.h"
#import "GlobalProject.h"
#import "AppDelegate.h"
#import "THGridMenuItem+CharacterItem.h"

@interface IPadProjectCharacterViewController ()

@end

@implementation IPadProjectCharacterViewController
@synthesize menuView = _menuView;
@synthesize project = _project;
@synthesize characters = _characters;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        [self menuReset];
        [self viewDidLoad];
    }
    return self;
}

-(void)buildCharactersList {
    /*
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Character" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    _projects = [context executeFetchRequest:request error:&error];
     */
    for (Character *c in _project.characters) {
        [_characters addObject:c];
    }
}

-(void)populateMenu {
    for (Character *c in _characters) {
        THGridMenuItem *box = [_menuView createMenuItem];
        box.title.text = c.name;
        box.type.text = @"Science Fiction Short Story";
        box.character = c;
        [box addTarget:self action:@selector(pressProject:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:box];
    }
}

-(void)menuReset {
    _menuView = nil;
    _menuView = [[THGridMenu alloc] initWithColumns:2 marginSize:30 gutterSize:30 rowHeight:100];
    self.view = _menuView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    _project = [GlobalProject sharedProject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
