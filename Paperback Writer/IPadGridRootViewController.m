//
//  IPadGridRootViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadGridRootViewController.h"
#import "THGridMenu.h"
#import "THGridMenuItem+ProjectItem.h"
#import "IPadProjectMenuViewController.h"
#import "AppDelegate.h"
#import "Project.h"
#import "IPadProjectNewViewController.h"
#import "IPadSlideViewController.h"
#import "GlobalProject.h"
#import "UIColor+THColor.h"
#import <UIImage+FlatUI.h>
#import "TDSemiModal.h"

@interface IPadGridRootViewController ()

@end

@implementation IPadGridRootViewController
@synthesize menuView = _menuView;
@synthesize projects = _projects;

-(void)closedSemiModal {
    [self viewWillAppear:YES];
}

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES; // UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)addProject {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
    project.title = @"Through the Arch";
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)showNewProject {
    
    _addProjectVC = [[IPadProjectNewViewController alloc] init];
    _addProjectVC.delegate = self;
    //[_addProjectVC.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
/*
    [newProjectVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:newProjectVC animated:YES completion:nil];
 */
    [self presentSemiModalViewController:_addProjectVC];
}

-(void)buildProjectsList {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    _projects = [context executeFetchRequest:request error:&error];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) init {
    self = [super init];
    if (self) {
        [self menuReset];
        [self viewDidLoad];
    }
    return self;
}

-(void)menuReset {
    _menuView = nil;
    _menuView = [[THGridMenu alloc] initWithColumns:2 marginSize:30 gutterSize:30 rowHeight:100];
    _menuView.backgroundColor = [UIColor projectBackgroundColor];
    self.view = _menuView;
}

-(void)pressProject:(THGridMenuItem *)sender {
//    IPadProjectMenuViewController *menuController = [[IPadProjectMenuViewController alloc] initWithNibName:@"IPadProjectMenuViewController" bundle:nil];
//    IPadProjectInfoViewController *infoController = [[IPadProjectInfoViewController alloc] initWithNibName:@"IPadProjectInfoViewController" bundle:nil];
//    infoController.project = sender.project;

//    [self.navigationController pushViewController:controller animated:YES];
    GlobalProject *gp = [GlobalProject sharedProject];
    gp.project = sender.project;
    IPadSlideViewController *slideController = [[IPadSlideViewController alloc] init];
    [self presentViewController:slideController animated:YES completion:nil];
}

-(void)pressAdd {
    
}

-(void)populateMenu {
    THGridMenuItem *newProject = [_menuView createMenuItem];
    newProject.title.text = @"New Project";
    [newProject addTarget:self action:@selector(showNewProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newProject];
    for (Project *p in _projects) {
        THGridMenuItem *box = [_menuView createMenuItem];
        box.title.text = p.title;
        box.type.text = [NSString stringWithFormat:@"A %@ %@", p.genre, p.type];
        box.project = p;
        [box addTarget:self action:@selector(pressProject:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:box];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Proser";
    [self buildProjectsList];
    [self populateMenu];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [_menuView orientationChange];
    [self buildProjectsList];
    [self menuReset];
    [self populateMenu];
    [super viewWillAppear:animated];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
     [_menuView orientationChange];
    [_addProjectVC fixYOriginWithRootView:self.view];
    [_addProjectVC resetPickers];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
