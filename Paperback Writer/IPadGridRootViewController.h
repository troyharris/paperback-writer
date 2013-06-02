//
//  IPadGridRootViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THGridMenu.h"
#import "AppDelegate.h"
#import "IPadProjectNewViewController.h"

@interface IPadGridRootViewController : UIViewController <NewProjectDelegate>

@property (nonatomic, strong) IPadProjectNewViewController *addProjectVC;
@property (nonatomic, strong) THGridMenu *menuView;
@property (nonatomic, strong) NSArray *projects;

-(AppDelegate *)ad;

@end
