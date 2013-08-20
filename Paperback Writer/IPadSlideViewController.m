//
//  IPadSlideViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadSlideViewController.h"
#import "IPadProjectSceneTableViewController.h"
#import "IPadProjectResearchTableViewController.h"
#import "IPadProjectResearchCollectViewController.h"
#import "IPadProjectCharacterCollectionViewController.h"
#import <objc/runtime.h>
#import <UIImage+FlatUI.h>
#import "UIColor+THColor.h"
#import <UIBarButtonItem+FlatUI.h>

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
         //   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ProjectInfoStoryboard" bundle:nil];
         //   IPadProjectInfoTableViewController *info = [sb instantiateViewControllerWithIdentifier:@"IPadProjectInfoTableViewController"];
            _slideController = [[IPadProjectInformationViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 2: {
            _slideController = [[IPadProjectCharacterCollectionViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 3: {
            _slideController = [[IPadProjectSceneTableViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 4: {
            _slideController = [[IPadProjectResearchCollectViewController alloc] init];
            [self buildSlideNav];
        }
            break;
        case 5:
            [self dismissViewControllerAnimated:YES completion:nil];
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
        _slideController = [[IPadProjectInformationViewController alloc] init];
 //       UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ProjectInfoStoryboard" bundle:nil];
     //   IPadProjectInfoTableViewController *info = [sb instantiateViewControllerWithIdentifier:@"IPadProjectInfoTableViewController"];
     //   _slideController = info;

        
        _menuController.delegate = self;
        
        [self buildSlideNav];
        
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_infoController];
//        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedMenuButton)];
        
//        _infoController.navigationItem.leftBarButtonItem = button;
        self.allowInteractiveSliding = NO;
        self.leftStaticViewWidth = 180;
        self.leftStaticViewController = _menuController;
//        self.slidingViewController = nav;
//        [self showSlidingViewAnimated:YES];
    }
    return self;
}

-(void)buildSlideNav {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_slideController];
    nav.navigationBar.tintColor = [UIColor projectDarkTextColor];
    //UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(pressedMenuButton)];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(pressedMenuButton)];
    //button.title = @"Menu";
//    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor projectDarkColor] highlightedColor:[UIColor projectLightTextColor] cornerRadius:5.0];
    
//    [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor projectNavBarColor] cornerRadius:0] forBarMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
    NSMutableDictionary *titleTextAttributes = [[nav.navigationBar titleTextAttributes] mutableCopy];
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionary];
    }
    [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
    [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [titleTextAttributes setValue:[UIFont fontWithName:@"Lato-Black" size:20] forKey:UITextAttributeFont];
    [titleTextAttributes setValue:[UIColor projectDarkTextColor] forKey:UITextAttributeTextColor];
    [nav.navigationBar setTitleTextAttributes:titleTextAttributes];
    [nav.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]];
    nav.navigationBar.barTintColor = [UIColor projectNavBarColor];
    [nav.navigationItem setTitle:@"Prosey"];
    
    _slideController.navigationItem.leftBarButtonItem = button;
    self.slidingViewController = nav;
    [self showSlidingViewAnimated:YES];

    
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
