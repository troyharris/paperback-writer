//
//  IPadProjectInfoTableViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/17/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import <PrettyKit.h>

@interface IPadProjectInfoTableViewController : UITableViewController

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) IBOutlet UILabel *projectTitle;
@property (nonatomic, strong) IBOutlet UILabel *projectGenre;
@property (nonatomic, strong) IBOutlet UILabel *projectType;

@end
