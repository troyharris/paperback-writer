//
//  IPadSlideViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSlideController.h"
#import "IPadProjectInfoViewController.h"
#import "IPadProjectMenuViewController.h"
#import "Project.h"

@interface IPadSlideViewController : CHSlideController <ProjectMenuDelegate>

@property (nonatomic, strong) IPadProjectMenuViewController *menuController;
@property (nonatomic, strong) IPadProjectInfoViewController *infoController;
@property (nonatomic, strong) UIViewController *slideController;
@property (nonatomic, strong) Project *project;




@end
