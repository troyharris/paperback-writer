//
//  IPadProjectResearchCollectViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/9/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectResearchCollectViewController.h"
#import "THUtil.h"
#import "ReferenceCollectCell.h"
#import "AppDelegate.h"
#import "Research.h"
#import "GlobalProject.h"
#import "Note.h"
#import "UIColor+THColor.h"
#import <UIColor+FlatUI.h>
#import "ReferenceNewCell.h"
#import "IPadNoteImageViewController.h"

@interface IPadProjectResearchCollectViewController ()

@end

@implementation IPadProjectResearchCollectViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)buildResearch {
    _researches = [[NSMutableArray alloc] init];
    for (Research *r in _project.researches) {
        [_researches addObject:r];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _layoutFlow = [[UICollectionViewFlowLayout alloc] init];
        CGFloat square = [THUtil getRealDeviceWidth] / 2;
        _layoutFlow.itemSize = CGSizeMake(square, square);
        _layoutFlow.minimumInteritemSpacing = 0;
        _layoutFlow.minimumLineSpacing = 0;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight]) collectionViewLayout:_layoutFlow];
        [_collectView registerClass:[ReferenceCollectCell class] forCellWithReuseIdentifier:@"aCell"];
        [_collectView registerClass:[ReferenceNewCell class] forCellWithReuseIdentifier:@"newCell"];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor whiteColor];
        self.view = _collectView;
        [_collectView setContentInset:UIEdgeInsetsMake(80, 0, 0, 0)];
    }
    return self;
}

-(void)showNewResearch {
    _addResearch = [[IPadNewResearchViewController alloc] init];
    
    [self.navigationController pushViewController:_addResearch animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNewResearch)];

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNewResearch)];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    [self buildResearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [_researches count]) {
        NSLog(@"GOtta get a cell");
        static NSString *reuse = @"aCell";
        ReferenceCollectCell *cell = [_collectView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
        [cell willRotate];
        //cell.backgroundView.backgroundColor = [UIColor lightGrayColor];
        Research *r = [_researches objectAtIndex:indexPath.row];
        cell.cellTitle.text = r.notes.desc;
        cell.imageView.image = [UIImage imageWithData:r.notes.image];
        CGImageRef cgref = [cell.imageView.image CGImage];
        CIImage *cim = [cell.imageView.image CIImage];
        if (cim != nil || cgref != NULL) {
            cell.cellTitle.hidden = YES;
        }
        cell.backgroundColor = r.color;
        return cell;
    } else {
        NSLog(@"Got that new cell");
        ReferenceNewCell *newCell = [_collectView dequeueReusableCellWithReuseIdentifier:@"newCell" forIndexPath:indexPath];
        return newCell;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_researches count] + 1;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_researches count]) {
        [self showNewResearch];
    } else {
        ReferenceCollectCell *cell = (ReferenceCollectCell *)[_collectView cellForItemAtIndexPath:indexPath];
        CGImageRef cgref = [cell.imageView.image CGImage];
        CIImage *cim = [cell.imageView.image CIImage];
        if (cim != nil || cgref != NULL) {
            IPadNoteImageViewController *imageVC = [[IPadNoteImageViewController alloc] init];
            imageVC.imageView.image = cell.imageView.image;
            [self.navigationController pushViewController:imageVC animated:YES];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES; // UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGFloat square = [THUtil getRealDeviceWidth] / 2;
    _layoutFlow.itemSize = CGSizeMake(square, square);
    [_collectView layoutSubviews];
    [_collectView reloadData];
}



@end
