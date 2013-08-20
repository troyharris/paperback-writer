//
//  IPadNewProjectVC.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/20/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNewProjectVC.h"
#import "AppDelegate.h"
#import "Project.h"
#import "Outline.h"
#import "UIColor+THColor.h"

@interface IPadNewProjectVC ()

@end

@implementation IPadNewProjectVC

static const int kTypePicker = 0;
static const int kGenrePicker = 1;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)addProject {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
    project.title = self.titleText.text;
    project.genre = (NSString *)[self.genres objectAtIndex:[self.genre currentSelectedIndex]];
    project.type =(NSString *)[self.types objectAtIndex:[self.type currentSelectedIndex]];
    Outline *mainOutline = [NSEntityDescription insertNewObjectForEntityForName:@"Outline" inManagedObjectContext:context];
    mainOutline.title = @"Main";
    [project addOutlinesObject:mainOutline];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)pressAdd {
    [self addProject];
    [self.delegate closedPopover];
}

-(void)pressCancel {
    [self.delegate closedPopover];
}

-(void)buildTypes {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"types" ofType:@"plist"];
    self.types = [NSArray arrayWithContentsOfFile:path];
}


-(void)buildGenres {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"genres" ofType:@"plist"];
    self.genres = [NSArray arrayWithContentsOfFile:path];
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
    self.view.backgroundColor = [UIColor projectHighlightColor];
    self.type.tag = 0;
    self.genre.tag = 1;
    self.type.delegate = self;
    self.type.dataSource = self;
    self.genre.delegate = self;
    self.genre.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self resetPickers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetPickers {
    [self buildTypes];
    [self buildGenres];
    [self.type reloadData];
    [self.type scrollToElement:0 animated:NO];
    [self.genre reloadData];
    [self.genre scrollToElement:0 animated:NO];
}

#pragma mark - HorizontalPickerView DataSource Methods
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    if (picker.tag == kTypePicker) {
        return [_types count];
    } else {
        return [_genres count];
    }
}

- (NSString *)horizontalPickerView:(V8HorizontalPickerView *)picker titleForElementAtIndex:(NSInteger)index {
    if (picker.tag == kTypePicker) {
        return [_types objectAtIndex:index];
    } else {
        return [_genres objectAtIndex:index];
    }
    
}

- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
	CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
	NSString *text;
    if (picker.tag == kTypePicker) {
        text = [_types objectAtIndex:index];
    } else {
        text = [_genres objectAtIndex:index];
    }
    
	CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
	return textSize.width + 40.0f; // 20px padding on each side
}


@end
