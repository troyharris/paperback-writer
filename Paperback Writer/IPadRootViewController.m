//
//  IPadRootViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadRootViewController.h"
#import "IIViewDeckController.h"
#import "IPadProjectMenuViewController.h"
#import "IPadProjectInfoViewController.h"

@interface IPadRootViewController () <IIViewDeckControllerDelegate> {
    IIViewDeckPanningMode _panning;
    IIViewDeckCenterHiddenInteractivity _centerHidden;
    IIViewDeckNavigationControllerBehavior _navBehavior;
    IIViewDeckSizeMode _sizeMode;
    BOOL _elastic;
    CGFloat _maxLedge;
}

@end

@implementation IPadRootViewController

-(IBAction)pressButton {
    IPadProjectMenuViewController *menuController = [[IPadProjectMenuViewController alloc] initWithNibName:@"IPadProjectMenuViewController" bundle:nil];
    IPadProjectInfoViewController *infoController = [[IPadProjectInfoViewController alloc] initWithNibName:@"IPadProjectInfoViewController" bundle:nil];
    IIViewDeckController *controller = [[IIViewDeckController alloc] initWithCenterViewController:infoController leftViewController:menuController];
    controller.panningMode = _panning;
    controller.centerhiddenInteractivity = _centerHidden;
    controller.navigationControllerBehavior = _navBehavior;
    controller.maxSize = _maxLedge > 0 ? self.view.bounds.size.width-_maxLedge : 0;
    controller.sizeMode = _sizeMode;
    controller.elastic = _elastic;
    controller.leftSize = 320;
    controller.delegate = self;
    
    [controller openLeftView];
    [self.navigationController pushViewController:controller animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _panning = IIViewDeckNoPanning;
        _centerHidden = IIViewDeckCenterHiddenUserInteractive;
        _navBehavior = IIViewDeckNavigationControllerIntegrated;
        _sizeMode = IIViewDeckLedgeSizeMode;
        _elastic = YES;
        _maxLedge = 200;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
