//
//  IPadProjectInfoViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectInfoViewController.h"
#import "GlobalProject.h"

@interface IPadProjectInfoViewController ()

@end

@implementation IPadProjectInfoViewController
@synthesize project = _project;
@synthesize projectTitle = _projectTitle;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
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
    GlobalProject *gp = [GlobalProject sharedProject];
    _projectTitle.text = gp.project.title;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
