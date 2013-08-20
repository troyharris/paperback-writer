//
//  IPadProjectCharacterCollectionViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/19/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectCharacterCollectionViewController.h"
#import "IPadSlideViewController.h"
#import "GlobalProject.h"
#import "ProjectCell.h"
#import "THUtil.h"
#import "UIColor+THColor.h"
#import "Character.h"
#import "IPadCharacterRootViewController.h"

@interface IPadProjectCharacterCollectionViewController ()

@end

@implementation IPadProjectCharacterCollectionViewController

static NSString *kCellID = @"ProjectCell";
static NSString *kNewCellID = @"NewCell";

-(void)closedSemiModal {
    [self viewWillAppear:YES];
}

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)showNewProjectWithRect:(CGRect)source {
    
    _addCharacterVC = [[IPadNewCharacterViewController alloc] init];
    self.addCharacterVC.delegate = self;
    //[_addProjectVC.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    /*
     [newProjectVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
     [self presentViewController:newProjectVC animated:YES completion:nil];
     */
    
    self.popController = [[UIPopoverController alloc] initWithContentViewController:self.addCharacterVC];
    self.popController.delegate = self;
    [self.popController presentPopoverFromRect:source inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //[self presentViewController:_addCharacterVC animated:YES completion:nil];
}

-(void)buildCharactersList {
    _characters = [[NSMutableArray alloc] init];
    for (Character *c in _project.characters) {
        [_characters addObject:c];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        GlobalProject *gp = [GlobalProject sharedProject];
        _project = gp.project;
        self.navigationItem.title = gp.project.title;
        // Custom initialization
        _layoutFlow = [[UICollectionViewFlowLayout alloc] init];
        //_layoutFlow.itemSize = CGSizeMake(square, 150);
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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    [self buildCharactersList];
    [_collectView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressCharacter:(Character *)c {
    IPadCharacterRootViewController *characterVC = [[IPadCharacterRootViewController alloc] init];
    characterVC.character = c;
    [self.navigationController pushViewController:characterVC animated:YES];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Getting a cell");
    ProjectCell *cell = [_collectView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    [cell willRotate];
    cell.backgroundColor = [UIColor projectHighlightColor];
    //cell.backgroundView.backgroundColor = [UIColor lightGrayColor];
    if (indexPath.row != [_characters count]) {
        Character *c = [_characters objectAtIndex:indexPath.row];
        cell.cellTitle.font = [UIFont fontWithName:@"Lato-Light" size:30];
        cell.cellTitle.text = c.name;
        //cell.backgroundColor = [UIColor projectHighlightColor];
        cell.subTitle.text = [NSString stringWithFormat:@"A %@ %@", c.gender, c.role];
        [cell.cellTitle adjustsFontSizeToFitWidth];
        return cell;
        
    } else {
        //cell.backgroundColor = [UIColor projectHighlightColor];
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
    return [_characters count] + 1;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat square = ([THUtil getRealDeviceWidth] / 2) - 40;
    return CGSizeMake(square, 150);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [_characters count]) {
        Character *c = [_characters objectAtIndex:indexPath.row];
        [self pressCharacter:c];
    } else {
        ProjectCell *cell = (ProjectCell *)[self.collectView cellForItemAtIndexPath:indexPath];
        CGRect acellRect = cell.frame;
        CGRect cellRect = [self.collectView convertRect:acellRect toView:self.view];
        NSLog(@"cell rect is %f %f %f %f", cellRect.origin.x, cellRect.origin.y, cellRect.size.width, cellRect.size.height);
        [self showNewProjectWithRect:cellRect];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self viewWillAppear:YES];
}

-(void)closedPopover {
    [self.popController dismissPopoverAnimated:YES];
    [self viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES; // UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    //    CGFloat square = [THUtil getRealDeviceWidth] / 2;
    //    _layoutFlow.itemSize = CGSizeMake(square, square);
    [_collectView layoutSubviews];
    [_collectView reloadData];
}


@end
