//
//  IPadProjectCharacterViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THGridMenu.h"
#import "Project.h"

@interface IPadProjectCharacterViewController : UIViewController

@property (nonatomic, strong) THGridMenu *menuView;
@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) NSMutableArray *characters;


@end
