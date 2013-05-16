//
//  IPadProjectOutlineTableViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMMoveTableView.h>
#import "Project.h"
#import "Outline.h"

@interface IPadProjectOutlineTableViewController : UITableViewController <FMMoveTableViewDataSource, FMMoveTableViewDelegate>

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) Outline *outline;
@property (nonatomic, strong) NSArray *scenes;

@end
