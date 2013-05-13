//
//  IPadProjectInfoViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface IPadProjectInfoViewController : UIViewController

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) IBOutlet UILabel *projectTitle;

@end
