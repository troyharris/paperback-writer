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

@property (nonatomic) CGFloat topOffset;
@property (nonatomic) UIEdgeInsets textEdge;

@end


@implementation IPadNoteTextViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)saveProject {
    NSLog(@"Attempting to save");
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
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight])];
    _textView.font = [UIFont fontWithName:@"Lato-Light" size:18.0];
    [self.view addSubview:_textView];
    
    //_titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 66, [THUtil getRealDeviceWidth], 70)];
    
    self.titleView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.titleView.tint = [UIColor projectHighlightColor];
    [self.view addSubview:self.titleView];
    
    _titleField = [[UITextField alloc] init];
    _titleField.font = [UIFont fontWithName:@"Lato-Light" size:40];
    //_titleField.backgroundColor = [UIColor projectHighlightColor];
    _titleField.textAlignment = NSTextAlignmentCenter;
    
    [self.titleView addSubview:_titleField];
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
	// Do any additional setup after loading the view.
}

- (void) viewDidLayoutSubviews {
    self.topOffset = self.topLayoutGuide.length;
   // _topOffset = statusBarHeight + self.navigationController.navigationBar.frame.size.height;
    //    NSLog(@"topOffset: %f - Navbar height: %f", _topOffset, self.navigationController.navigationBar.frame.size.height);
    self.titleView.frame = CGRectMake(0, _topOffset, CGRectGetWidth(self.view.frame), 100);
    self.titleField.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.titleView.frame));
    self.textEdge = UIEdgeInsetsMake(_topOffset + CGRectGetHeight(self.titleField.frame), 0, 0, 0);
    self.textView.contentInset = self.textEdge;
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _textView.text = _research.notes.content;
    _titleField.text = _research.notes.desc;
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
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

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (kbSize.height));
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    _textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
    [self saveProject];
}

@end
