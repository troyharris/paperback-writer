//
//  IPadProjectMenuViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectMenuViewController.h"
#import "IIViewDeckController.h"
#import "IPadProjectInfoViewController.h"
#import "IPadProjectCharacterViewController.h"

@interface IPadProjectMenuViewController ()

@end

@implementation IPadProjectMenuViewController

-(IBAction)pressInfo {
    self.viewDeckController.centerController = [[IPadProjectInfoViewController alloc] initWithNibName:@"IPadProjectInfoViewController" bundle:nil];
}

-(IBAction)pressCharacter {
    self.viewDeckController.centerController = [[IPadProjectCharacterViewController alloc] initWithNibName:@"IPadProjectCharacterViewController" bundle:nil];
}

- (void)showSelector {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

-(void)back {
    [self.viewDeckController closeLeftView];
    [self.navigationController popViewControllerAnimated:YES];
}

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                              [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)],
                                              [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleBordered target:self action:@selector(showSelector)],
                                              nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
