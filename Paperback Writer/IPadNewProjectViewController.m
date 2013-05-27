//
//  IPadNewProjectViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNewProjectViewController.h"
#import "AppDelegate.h"
#import "Project.h"

@interface IPadNewProjectViewController ()

@end

@implementation IPadNewProjectViewController
@synthesize add = _add;
@synthesize cancel = _cancel;
@synthesize projectTitle = _projectTitle;
@synthesize typePicker;
@synthesize genrePicker;
@synthesize genres = _genres;
@synthesize types = _types;
@synthesize selectedGenre = _selectedGenre;
@synthesize selectedType = _selectedType;

static const int kTypePicker = 0;
static const int kGenrePicker = 1;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)addProject {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
    project.title = _projectTitle.text;
    project.genre = (NSString *)[_genres objectAtIndex:[self.genrePicker currentSelectedIndex]];
    project.type =(NSString *)[_types objectAtIndex:[self.typePicker currentSelectedIndex]];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)buildTypes {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"types" ofType:@"plist"];
    _types = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"There are %d types", [_types count]);
    NSLog(@"Type 1 is %@", [_types objectAtIndex:0]);
}


-(void)buildGenres {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"genres" ofType:@"plist"];
    _genres = [NSArray arrayWithContentsOfFile:path];
}


-(IBAction)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)pressAdd {
    [self addProject];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    //Picker placement - Temp code
    CGFloat margin = 80.0f;
	CGFloat width = self.view.bounds.size.width - (margin * 2.0f);
	CGFloat pickerHeight = 40.0f;
	CGFloat x = margin;
	CGFloat y = 650.0f;
	CGRect tmpFrame = CGRectMake(x, y, width, pickerHeight);
    
    self.typePicker = [[V8HorizontalPickerView alloc] initWithFrame:tmpFrame];
	self.typePicker.backgroundColor   = [UIColor whiteColor];
	self.typePicker.selectedTextColor = [UIColor blackColor];
	self.typePicker.textColor   = [UIColor grayColor];
	self.typePicker.delegate    = self;
	self.typePicker.dataSource  = self;
	self.typePicker.elementFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
	self.typePicker.selectionPoint = CGPointMake(60, 0);
    self.typePicker.tag = kTypePicker;
    
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
	self.typePicker.selectionIndicatorView = indicator;
    
  //  	UIImageView *leftFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_fade"]];
  //  	typePicker.leftEdgeView = leftFade;
    [self.view addSubview:self.typePicker];
    
    CGFloat yGenre = 720.0f;
	CGRect genreFrame = CGRectMake(x, yGenre, width, pickerHeight);
    
    self.genrePicker = [[V8HorizontalPickerView alloc] initWithFrame:genreFrame];
	self.genrePicker.backgroundColor   = [UIColor whiteColor];
	self.genrePicker.selectedTextColor = [UIColor blackColor];
	self.genrePicker.textColor   = [UIColor grayColor];
	self.genrePicker.delegate    = self;
	self.genrePicker.dataSource  = self;
	self.genrePicker.elementFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
	self.genrePicker.selectionPoint = CGPointMake(60, 0);
    self.genrePicker.tag = kGenrePicker;
    
    UIImageView *genreIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
    self.genrePicker.selectionIndicatorView = genreIndicator;
    
    [self.view addSubview:self.genrePicker];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [self buildTypes];
    [self buildGenres];
    [self.typePicker reloadData];
    [self.typePicker scrollToElement:0 animated:NO];
    [self.genrePicker reloadData];
    [self.genrePicker scrollToElement:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Picker Delegate Stuff

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

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index {
/*
	if (picker.tag == kTypePicker) {
        _selectedType = [_types objectAtIndex:index];
    } else {
        _selectedGenre = [_genres objectAtIndex:index];
    }
*/
}

@end
