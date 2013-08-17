//
//  IPadNewSceneViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNewSceneViewController.h"
#import "Project.h"
#import "Scene.h"
#import "AppDelegate.h"

@interface IPadNewSceneViewController ()

@end

@implementation IPadNewSceneViewController

@synthesize sceneText = _sceneText;
@synthesize outline = _outline;
@synthesize nextOrderNum = _nextOrderNum;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(IBAction)pressAdd {
    [self addScene];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addScene {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Scene *scene = [NSEntityDescription insertNewObjectForEntityForName:@"Scene" inManagedObjectContext:context];
    scene.title = _sceneText.text;
    scene.orderNum = _nextOrderNum;
    [_outline addScenesObject:scene];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
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
