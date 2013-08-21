//
//  IPadRootCollectionViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/11/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadRootCollectionViewController.h"
#import "IPadSlideViewController.h"
#import "AppDelegate.h"
#import "GlobalProject.h"
#import "Project.h"
#import "ProjectCell.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@interface IPadRootCollectionViewController ()


@end

@implementation IPadRootCollectionViewController

static NSString * const kPROProjectCellID = @"ProjectCell";

// Collection View sizing options
static CGFloat    const kPROMenuTopMargin       = 80;
static CGFloat    const kPROTitleFontSize       = 30;
static CGFloat    const kPROPlusButtonFontSize  = 100;
static CGFloat    const kPROCellHeight          = 150;
static CGFloat    const kPROCenterGutter        = 40;

# pragma mark - UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Prosey";
        self.layoutFlow = [[UICollectionViewFlowLayout alloc] init];
        self.layoutFlow.minimumInteritemSpacing = 0;
        self.layoutFlow.minimumLineSpacing = 10;
        
        //Use THUtil method to get the device width no matter what the rotation
        self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight]) collectionViewLayout:self.layoutFlow];
        [self.collectView registerClass:[ProjectCell class] forCellWithReuseIdentifier:kPROProjectCellID];
        self.collectView.delegate = self;
        self.collectView.dataSource = self;
        self.collectView.backgroundColor = [UIColor projectBackgroundColor];
        self.view = self.collectView;
        [self.collectView setContentInset:UIEdgeInsetsMake(kPROMenuTopMargin, 0, 0, 0)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self buildProjectsList];
    [self.collectView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.collectView layoutSubviews];
    [self.collectView reloadData];
}

#pragma mark - Core Data methods

- (AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)buildProjectsList {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    self.projects = [context executeFetchRequest:request error:&error];
}

#pragma mark - UIPopoverController methods

- (void)closedPopover {
    [self.popController dismissPopoverAnimated:YES];
    [self viewWillAppear:YES];
}

- (void)showNewProjectPopoverWithRect:(CGRect)source {
    self.addProjectVC = [[IPadNewProjectVC alloc] init];
    self.addProjectVC.delegate = self;
    self.popController = [[UIPopoverController alloc] initWithContentViewController:self.addProjectVC];
    self.popController.delegate = self;
    [self.popController presentPopoverFromRect:source inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self viewWillAppear:YES];
}

#pragma mark - Collection View methods

- (void)pressProject:(Project *)project {
    GlobalProject *gp = [GlobalProject sharedProject];
    gp.project = project;
    IPadSlideViewController *slideController = [[IPadSlideViewController alloc] init];
    [self presentViewController:slideController animated:YES completion:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Getting a cell");
    ProjectCell *cell = [self.collectView dequeueReusableCellWithReuseIdentifier:kPROProjectCellID forIndexPath:indexPath];
    if (indexPath.row != [self.projects count]) {
        Project *p = [self.projects objectAtIndex:indexPath.row];
        cell.cellTitle.font = [UIFont fontWithName:PROFontLight size:kPROTitleFontSize];
        cell.cellTitle.text = p.title;
        cell.backgroundColor = [UIColor projectHighlightColor];
        cell.subTitle.text = [NSString stringWithFormat:@"A %@ %@", p.genre, p.type];
        [cell.cellTitle adjustsFontSizeToFitWidth];
        return cell;
    } else {
        cell.backgroundColor = [UIColor projectHighlightColor];
        cell.cellTitle.text = @"+";
        cell.subTitle.text = @"";
        cell.cellTitle.font = [UIFont fontWithName:PROFontLight size:kPROPlusButtonFontSize];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.projects count] + 1;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat square = ([THUtil getRealDeviceWidth] / 2) - kPROCenterGutter;
    return CGSizeMake(square, kPROCellHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [self.projects count]) {
        Project *p = [self.projects objectAtIndex:indexPath.row];
        [self pressProject:p];
    } else {
        ProjectCell *cell = (ProjectCell *)[self.collectView cellForItemAtIndexPath:indexPath];
        CGRect cellRect = cell.frame;
        CGRect cellRectToView = [self.collectView convertRect:cellRect toView:self.view];
        [self showNewProjectPopoverWithRect:cellRectToView];
    }
}

@end
