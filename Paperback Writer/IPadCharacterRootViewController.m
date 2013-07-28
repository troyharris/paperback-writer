//
//  iPadCharacterRootViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/27/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterRootViewController.h"

@interface IPadCharacterRootViewController ()

@end

@implementation IPadCharacterRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabBar.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item == _basicItem) {
        NSLog(@"Clicked on Basic");
    } else if (item == _bioItem) {
        NSLog(@"Clicked on Bio");
    } else if (item == _notesItem){
        NSLog(@"Clicked on Notes");
    }
}

@end
