//
//  IPadRootCollectionViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/11/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IPadNewProjectVC.h"

@interface IPadRootCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverControllerDelegate, NewProjectDelegate>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutFlow;
@property (nonatomic, strong) IPadNewProjectVC *addProjectVC;
@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) NSArray *projects;

@end
