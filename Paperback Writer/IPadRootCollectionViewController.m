//
//  IPadRootCollectionViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/11/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadRootCollectionViewController.h"
#import "IPadSlideViewController.h"
#import "GlobalProject.h"
#import "Project.h"
#import "TDSemiModal.h"
#import "ProjectCell.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@interface IPadRootCollectionViewController ()


@end

@implementation IPadRootCollectionViewController

static NSString *kCellID = @"ProjectCell";
static NSString *kNewCellID = @"NewCell";

-(void)closedSemiModal {
    [self viewWillAppear:YES];
}

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)showNewProject {
    _addProjectVC = [[IPadProjectNewViewController alloc] init];
    _addProjectVC.delegate = self;
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

-(void)pressProject:(Project *)project {
    GlobalProject *gp = [GlobalProject sharedProject];
    gp.project = project;
    IPadSlideViewController *slideController = [[IPadSlideViewController alloc] init];
    [self presentViewController:slideController animated:YES completion:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Prosey";
        // Custom initialization
        _layoutFlow = [[UICollectionViewFlowLayout alloc] init];
        _layoutFlow.minimumInteritemSpacing = 0;
        _layoutFlow.minimumLineSpacing = 10;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight]) collectionViewLayout:_layoutFlow];
        [_collectView registerClass:[ProjectCell class] forCellWithReuseIdentifier:kCellID];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor projectBackgroundColor];
        self.view = _collectView;
        [_collectView setContentInset:UIEdgeInsetsMake(80, 0, 0, 0)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Prosey";
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self buildProjectsList];
    [_collectView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Getting a cell");
    ProjectCell *cell = [_collectView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    [cell willRotate];
        //cell.backgroundView.backgroundColor = [UIColor lightGrayColor];
    if (indexPath.row != [_projects count]) {
        Project *p = [_projects objectAtIndex:indexPath.row];
        cell.cellTitle.font = [UIFont fontWithName:@"Lato-Light" size:30];
        cell.cellTitle.text = p.title;
        cell.backgroundColor = [UIColor projectHighlightColor];
        cell.subTitle.text = [NSString stringWithFormat:@"A %@ %@", p.genre, p.type];
        [cell.cellTitle adjustsFontSizeToFitWidth];
        return cell;
        
    } else {
        cell.backgroundColor = [UIColor projectHighlightColor];
        cell.cellTitle.text = @"+";
        cell.subTitle.text = @"";
        cell.cellTitle.font = [UIFont fontWithName:@"Lato-Hairline" size:100];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_projects count] + 1;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat square = ([THUtil getRealDeviceWidth] / 2) - 40;
    return CGSizeMake(square, 150);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [_projects count]) {
        Project *p = [_projects objectAtIndex:indexPath.row];
        [self pressProject:p];
    } else {
        [self showNewProject];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES; // UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [_collectView layoutSubviews];
    [_collectView reloadData];
}

@end
