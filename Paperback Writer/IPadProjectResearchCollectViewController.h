//
//  IPadProjectResearchCollectViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/9/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "IPadNewResearchViewController.h"


@interface IPadProjectResearchCollectViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverControllerDelegate, NewResearchDelegate>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) NSMutableArray *researches;
@property (nonatomic, strong) IPadNewResearchViewController *addResearch;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutFlow;

@end
