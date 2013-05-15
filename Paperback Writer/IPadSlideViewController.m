//
//  IPadSlideViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadSlideViewController.h"
#import "IPadProjectCharacterViewController.h"
#import <objc/runtime.h>

@interface IPadSlideViewController (private)
    -(void)pressedMenuButton;
@end

@implementation IPadSlideViewController

@synthesize menuController = _menuController;
@synthesize infoController = _infoController;
@synthesize project = _project;
@synthesize slideController = _slideController;

-(void)didSelectMenuItem:(int)index {
    switch (index) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1: {
            _slideController = [[IPadProjectInfoViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 2: {
            _slideController = [[IPadProjectCharacterViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 3: {
            _slideController = [[IPadProjectCharacterViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 4: {
            _slideController = [[IPadProjectCharacterViewController alloc] init];
            [self buildSlideNav];
        }
            break;
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        _menuController = [[IPadProjectMenuViewController alloc] init];
        _slideController = [[IPadProjectInfoViewController alloc] init];
        
        _menuController.delegate = self;
        
        [self buildSlideNav];
        
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_infoController];
//        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedMenuButton)];
        
//        _infoController.navigationItem.leftBarButtonItem = button;
//        self.allowInteractiveSliding = YES;
        self.leftStaticViewWidth = 320 - 55;
        self.leftStaticViewController = _menuController;
//        self.slidingViewController = nav;
//        [self showSlidingViewAnimated:YES];
    }
    return self;
}

-(void)buildSlideNav {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_slideController];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedMenuButton)];
    
    _slideController.navigationItem.leftBarButtonItem = button;
    self.slidingViewController = nav;
    [self showSlidingViewAnimated:YES];
    NSLog(@"Post: %@", [_slideController nibName]);
    
}

-(void)pressedMenuButton {
    if (isLeftStaticViewVisible) {
        [self showSlidingViewAnimated:YES];
    }else {
        [self showLeftStaticView:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
