//
//  IPadProjectMenuViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectMenuViewController.h"
#import "AppDelegate.h"
#import "GlobalProject.h"
#import "Project.h"
#import <UIColor+THColor.h>
#import "ProjectButton.h"

@interface IPadProjectMenuViewController ()

@end

@implementation IPadProjectMenuViewController
@synthesize delegate;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)pressInfo {
    [self.delegate didSelectMenuItem:1];
}

-(void)pressCharacter {
    [self.delegate didSelectMenuItem:2];
}

-(void)pressOutline {
    [self.delegate didSelectMenuItem:3];
}

-(void)pressResearch {
    [self.delegate didSelectMenuItem:4];
}

-(void)pressDelete {
    GlobalProject *gp = [GlobalProject sharedProject];
    Project *project = gp.project;
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    [context deleteObject:project];
    gp.project = nil;
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The delete was successful!");
    } else {
        NSLog(@"The delete wasn't successful: %@", [error userInfo]);
    }
    [self.delegate didSelectMenuItem:5];
}



-(void)closeProject {
    [self.delegate didSelectMenuItem:0];
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self viewDidLoad];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor projectDarkColor];
    
    UIImage *infoIcon = [UIImage imageNamed:@"ipad-info"];
    CGPoint infoOrigin = CGPointMake(20, 20);
    ProjectButton *infoButton = [[ProjectButton alloc] initWithOrigin:infoOrigin image:infoIcon buttonText:@"Information"];
    [infoButton addTarget:self action:@selector(pressInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    UIImage *characterIcon = [UIImage imageNamed:@"ipad-characters"];
    CGPoint characterOrigin = CGPointMake(20, 120);
    ProjectButton *characterButton = [[ProjectButton alloc] initWithOrigin:characterOrigin image:characterIcon buttonText:@"Characters"];
    [characterButton addTarget:self action:@selector(pressCharacter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:characterButton];
    
    UIImage *outlineIcon = [UIImage imageNamed:@"ipad-outline2"];
    CGPoint outlineOrigin = CGPointMake(20, 220);
    ProjectButton *outlineButton = [[ProjectButton alloc] initWithOrigin:outlineOrigin image:outlineIcon buttonText:@"Outline"];
    [outlineButton addTarget:self action:@selector(pressOutline) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outlineButton];
    
    UIImage *researchIcon = [UIImage imageNamed:@"ipad-research"];
    CGPoint researchOrigin = CGPointMake(20, 320);
    ProjectButton *researchButton = [[ProjectButton alloc] initWithOrigin:researchOrigin image:researchIcon buttonText:@"Research"];
    [researchButton addTarget:self action:@selector(pressResearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:researchButton];
    
    UIImage *closeIcon = [UIImage imageNamed:@"ipad-close"];
    CGPoint closeOrigin = CGPointMake(20, 420);
    ProjectButton *closeButton = [[ProjectButton alloc] initWithOrigin:closeOrigin image:closeIcon buttonText:@"Close"];
    [closeButton addTarget:self action:@selector(closeProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
