//
//  IPadNewCharacterViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNewCharacterViewController.h"
#import "AppDelegate.h"
#import "Project.h"
#import "Character.h"
#import "GlobalProject.h"

@interface IPadNewCharacterViewController ()

@end

@implementation IPadNewCharacterViewController
@synthesize nameText = _nameText;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)pressAdd {
    [self addCharacter];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addCharacter {
    GlobalProject *gp = [GlobalProject sharedProject];
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:context];
//    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
//    project.title = _projectTitle.text;
    character.name = _nameText.text;
    [gp.project addCharactersObject:character];
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
