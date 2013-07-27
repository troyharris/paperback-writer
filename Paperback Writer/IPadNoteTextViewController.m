//
//  IPadNoteTextViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/27/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNoteTextViewController.h"
#import "Note.h"
#import "THUtil.h"
#import "UIColor+THColor.h"
#import "AppDelegate.h"

@interface IPadNoteTextViewController ()

@end


@implementation IPadNoteTextViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)saveProject {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    _research.notes.content = _textView.text;
    _research.notes.desc = _titleField.text;
    NSError *error;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 136, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight] - 136)];
    _textView.font = [UIFont fontWithName:@"Lato-Light" size:18.0];
    [self.view addSubview:_textView];
    
    _titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 66, [THUtil getRealDeviceWidth], 70)];
    _titleField.font = [UIFont fontWithName:@"Lato-Light" size:40];
    _titleField.backgroundColor = [UIColor projectHighlightColor];
    _titleField.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_titleField];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _textView.text = _research.notes.content;
    _titleField.text = _research.notes.desc;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveProject];
}

-(void)doneButton {
    [_textView resignFirstResponder];
    [self saveProject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
