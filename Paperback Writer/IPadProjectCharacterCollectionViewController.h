//
//  IPadProjectCharacterCollectionViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/19/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IPadNewCharacterViewController.h"
#import "Project.h"

@interface IPadProjectCharacterCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutFlow;
@property (nonatomic, strong) IPadNewCharacterViewController *addCharacterVC;
@property (nonatomic, strong) NSMutableArray *characters;
@property (nonatomic, strong) Project *project;


@end
