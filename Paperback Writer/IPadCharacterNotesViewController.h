//
//  IPadCharacterNotesViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/16/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface IPadCharacterNotesViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) NSMutableArray *notes;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutFlow;

@end
