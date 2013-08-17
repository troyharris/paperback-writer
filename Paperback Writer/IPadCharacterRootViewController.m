//
//  iPadCharacterRootViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/27/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterRootViewController.h"
#import "IPadCharacterInfoTableViewController.h"
#import "IPadCharacterBioViewController.h"
#import "IPadCharacterNotesViewController.h"

@interface IPadCharacterRootViewController ()

@property (nonatomic) int currentTab;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) UIView *currentView;

@end

@implementation IPadCharacterRootViewController

static const int kBasicInfo = 1;
static const int kBio = 2;
static const int kNotes = 3;

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
    UIStoryboard *infoSB = [UIStoryboard storyboardWithName:@"IPadCharacterInfoStoryboard" bundle:nil];
    IPadCharacterInfoTableViewController *infoVC = [infoSB instantiateViewControllerWithIdentifier:@"CharInfo"];
    infoVC.character = self.character;
    [self addChildViewController:infoVC];
    [self.view insertSubview:infoVC.view belowSubview:_tabBar];
    _currentTab = kBasicInfo;
    _currentVC = infoVC;
    _currentView = infoVC.view;
    _tabBar.delegate = self;
    [_tabBar setSelectedItem:_basicItem];
    /*
    CGRect tabFrame = _tabBar.frame;
    tabFrame.origin = CGPointMake(0, (CGRectGetMaxY(self.view.frame) - CGRectGetHeight(_tabBar.frame)) + 10);
    tabFrame.size.height = 100;
    _tabBar.frame = tabFrame;
    */
     
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item == _basicItem && _currentTab != kBasicInfo) {
        [_currentVC removeFromParentViewController];
        [_currentView removeFromSuperview];
        UIStoryboard *infoSB = [UIStoryboard storyboardWithName:@"IPadCharacterInfoStoryboard" bundle:nil];
        IPadCharacterInfoTableViewController *infoVC = [infoSB instantiateViewControllerWithIdentifier:@"CharInfo"];
        infoVC.view.frame = self.view.frame;
        //[self.view insertSubview:infoVC.view belowSubview:_tabBar];
        [self addChildViewController:infoVC];
        [self.view insertSubview:infoVC.view belowSubview:_tabBar];
        _currentVC = infoVC;
        _currentView = infoVC.view;
        _currentTab = kBasicInfo;
    } else if (item == _bioItem && _currentTab != kBio) {
        [_currentVC removeFromParentViewController];
        [_currentView removeFromSuperview];
        IPadCharacterBioViewController *bioVC = [[IPadCharacterBioViewController alloc] init];
        bioVC.character = self.character;
        bioVC.view.frame = self.view.frame;
        [self addChildViewController:bioVC];
        [self.view insertSubview:bioVC.view belowSubview:_tabBar];
        _currentVC = bioVC;
        _currentView = bioVC.view;
        _currentTab = kBio;
        NSLog(@"Clicked on Bio");
    } else if (item == _notesItem && _currentTab != kNotes){
        [_currentVC removeFromParentViewController];
        [_currentView removeFromSuperview];
        IPadCharacterNotesViewController *notesVC = [[IPadCharacterNotesViewController alloc] init];
        notesVC.character = self.character;
        notesVC.view.frame = self.view.frame;
        [self addChildViewController:notesVC];
        [self.view insertSubview:notesVC.view belowSubview:_tabBar];
        _currentVC = notesVC;
        _currentView = notesVC.view;
        _currentTab = kNotes;
        NSLog(@"Clicked on Notes");
    }
}

@end
