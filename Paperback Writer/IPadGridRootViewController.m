//
//  IPadGridRootViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadGridRootViewController.h"
#import "THGridMenu.h"
#import "THGridMenuItem.h"
#import "IIViewDeckController.h"
#import "IPadProjectMenuViewController.h"
#import "IPadProjectInfoViewController.h"
#import "AppDelegate.h"
#import "Project.h"
#import "IPadNewProjectViewController.h"

@interface IPadGridRootViewController () <IIViewDeckControllerDelegate> {
    IIViewDeckPanningMode _panning;
    IIViewDeckCenterHiddenInteractivity _centerHidden;
    IIViewDeckNavigationControllerBehavior _navBehavior;
    IIViewDeckSizeMode _sizeMode;
    BOOL _elastic;
    CGFloat _maxLedge;
}

@end

@implementation IPadGridRootViewController
@synthesize menuView = _menuView;
@synthesize projects = _projects;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    IPadNewProjectViewController *newProjectVC = [[IPadNewProjectViewController alloc] initWithNibName:@"IPadNewProjectViewController" bundle:nil];
    [newProjectVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:newProjectVC animated:YES completion:nil];
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
        _panning = IIViewDeckNoPanning;
        _centerHidden = IIViewDeckCenterHiddenUserInteractive;
        _navBehavior = IIViewDeckNavigationControllerIntegrated;
        _sizeMode = IIViewDeckLedgeSizeMode;
        _elastic = YES;
        _maxLedge = 200;
        [self viewDidLoad];
    }
    return self;
}

-(void)menuReset {
    _menuView = nil;
    _menuView = [[THGridMenu alloc] initWithColumns:2 marginSize:30 gutterSize:30 rowHeight:100];
    self.view = _menuView;
}

-(void)pressProject:(THGridMenuItem *)sender {
    IPadProjectMenuViewController *menuController = [[IPadProjectMenuViewController alloc] initWithNibName:@"IPadProjectMenuViewController" bundle:nil];
    IPadProjectInfoViewController *infoController = [[IPadProjectInfoViewController alloc] initWithNibName:@"IPadProjectInfoViewController" bundle:nil];
    infoController.project = sender.project;
    IIViewDeckController *controller = [[IIViewDeckController alloc] initWithCenterViewController:infoController leftViewController:menuController];
    controller.panningMode = _panning;
    controller.centerhiddenInteractivity = _centerHidden;
    controller.navigationControllerBehavior = _navBehavior;
    controller.maxSize = _maxLedge > 0 ? self.view.bounds.size.width-_maxLedge : 0;
    controller.sizeMode = _sizeMode;
    controller.elastic = _elastic;
    controller.leftSize = 320;
    controller.delegate = self;
    
    [controller openLeftView];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)populateMenu {
    for (Project *p in _projects) {
        THGridMenuItem *box = [_menuView createMenuItem];
        box.title.text = p.title;
        box.type.text = @"Science Fiction Short Story";
        box.project = p;
        [box addTarget:self action:@selector(pressProject:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:box];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNewProject)];
    [self buildProjectsList];
    [self populateMenu];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self buildProjectsList];
    [self menuReset];
    [self populateMenu];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
     [_menuView orientationChange];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
