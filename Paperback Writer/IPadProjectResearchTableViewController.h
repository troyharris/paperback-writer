//
//  IPadProjectResearchTableViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/30/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "IPadNewResearchViewController.h"

@interface IPadProjectResearchTableViewController : UITableViewController

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) NSMutableArray *researches;
@property (nonatomic, strong) IPadNewResearchViewController *addResearch;

@end
