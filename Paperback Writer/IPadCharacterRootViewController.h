//
//  iPadCharacterRootViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/27/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface IPadCharacterRootViewController : UIViewController <UITabBarDelegate>

@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) IBOutlet UITabBar *tabBar;
@property (nonatomic, strong) IBOutlet UITabBarItem *basicItem;
@property (nonatomic, strong) IBOutlet UITabBarItem *bioItem;
@property (nonatomic, strong) IBOutlet UITabBarItem *notesItem;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedVC;

@end
