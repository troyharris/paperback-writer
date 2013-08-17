//
//  IPadCharacterNotesViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/16/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterNotesViewController.h"
#import "THUtil.h"
#import "ProjectCell.h"
#import "ReferenceNewCell.h"
#import "AppDelegate.h"
#import "Note.h"
#import "UIColor+THColor.h"

@interface IPadCharacterNotesViewController ()

@end

@implementation IPadCharacterNotesViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)buildResearch {
    _notes = [[NSMutableArray alloc] init];
    for (Note *n in _character.notes) {
        [_notes addObject:n];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _layoutFlow = [[UICollectionViewFlowLayout alloc] init];
        //       CGFloat square = [THUtil getRealDeviceWidth] / 2;
        //        _layoutFlow.itemSize = CGSizeMake(square, square);
        _layoutFlow.minimumInteritemSpacing = 0;
        _layoutFlow.minimumLineSpacing = 0;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight]) collectionViewLayout:_layoutFlow];
        [_collectView registerClass:[ProjectCell class] forCellWithReuseIdentifier:@"aCell"];
        [_collectView registerClass:[ReferenceNewCell class] forCellWithReuseIdentifier:@"newCell"];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor whiteColor];
        _layoutFlow.minimumInteritemSpacing = 0;
        _layoutFlow.minimumLineSpacing = 10;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"GOtta get a cell");
    static NSString *reuse = @"aCell";
    ProjectCell *cell = [_collectView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    cell.backgroundColor = [UIColor projectHighlightColor];
    [cell willRotate];
    if (indexPath.row != [_notes count]) {
        //cell.backgroundView.backgroundColor = [UIColor lightGrayColor];
        Note *n = [_notes objectAtIndex:indexPath.row];
        cell.cellTitle.text = n.desc;
        cell.subTitle.text = [NSString stringWithFormat:@"A %@", n.type];
        cell.imageView.image = [UIImage imageWithData:n.image];
        CGImageRef cgref = [cell.imageView.image CGImage];
        CIImage *cim = [cell.imageView.image CIImage];
        if (cim != nil || cgref != NULL) {
            cell.cellTitle.hidden = YES;
        }
        //cell.backgroundColor = r.color;
    } else {
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
    return [_notes count] + 1;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat square = ([THUtil getRealDeviceWidth] / 2) - 40;
    return CGSizeMake(square, 150);
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
