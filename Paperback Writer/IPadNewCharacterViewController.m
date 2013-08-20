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
#import "UIColor+THColor.h"

@interface IPadNewCharacterViewController ()

@end

@implementation IPadNewCharacterViewController
@synthesize nameText = _nameText;

static const int kGenderPicker = 0;
static const int kRolePicker = 1;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)pressAdd {
    [self addCharacter];
    [self.delegate closedPopover];
}

-(void)pressCancel {
    [self.delegate closedPopover];
}

-(void)buildGenders {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"genders" ofType:@"plist"];
    self.genders = [NSArray arrayWithContentsOfFile:path];
}


-(void)buildRoles {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"roles" ofType:@"plist"];
    self.roles = [NSArray arrayWithContentsOfFile:path];
}

-(void)addCharacter {
    GlobalProject *gp = [GlobalProject sharedProject];
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:context];
//    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
//    project.title = _projectTitle.text;
    character.name = _nameText.text;
    character.role = (NSString *)[self.roles objectAtIndex:[self.role currentSelectedIndex]];
    character.gender = (NSString *)[self.genders objectAtIndex:[self.gender currentSelectedIndex]];
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
    self.view.backgroundColor = [UIColor projectHighlightColor];
    [self buildGenders];
    [self buildRoles];
    self.gender.tag = kGenderPicker;
    self.role.tag = kRolePicker;
    self.gender.delegate = self;
    self.role.delegate = self;
    self.role.dataSource = self;
    self.gender.dataSource = self;
    [self.gender scrollToElement:0 animated:NO];
    [self.role scrollToElement:0 animated:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker delegation

- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    if (picker.tag == kRolePicker) {
        return [self.roles count];
    } else {
        NSLog(@"Gender count %d", [self.genders count]);
        return [self.genders count];
    }
}

- (NSString *)horizontalPickerView:(V8HorizontalPickerView *)picker titleForElementAtIndex:(NSInteger)index {
    if (picker.tag == kRolePicker) {
        return [self.roles objectAtIndex:index];
    } else {
        return [self.genders objectAtIndex:index];
    }
    
}

- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
	CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
	NSString *text;
    if (picker.tag == kRolePicker) {
        text = [self.roles objectAtIndex:index];
    } else {
        text = [self.genders objectAtIndex:index];
    }
    
	CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
	return textSize.width + 40.0f; // 20px padding on each side
}


@end
