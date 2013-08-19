//
//  IPadCharacterBioViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/16/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterBioViewController.h"
#import "UIColor+THColor.h"
#import "AppDelegate.h"

@interface IPadCharacterBioViewController ()

@property (nonatomic) CGFloat topOffset;
@property (nonatomic) UIEdgeInsets textEdge;

@end

@implementation IPadCharacterBioViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)saveCharacter {
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    self.character.bio = self.textView.text;
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
        [self registerForKeyboardNotifications];
    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loading");
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 60)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.font = [UIFont fontWithName:@"Lato-Light" size:18];
    self.textView.text = self.character.bio;
 //   [self.textView setNeedsLayout];
    self.textView.delegate = self;
//    [self textViewDidChange:self.textView];
    [self.view addSubview:self.textView];
//    self.textView.text = self.character.bio;
//    [self textViewDidChange:_textView];
//    [self.textView setNeedsLayout];
//    NSLog(@"Text view: x: %f y: %f width: %f height: %f textcontaininset top: %f left: %f bottom: %f right: %f", _textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textView.frame.size.height, _textView.textContainerInset.top, _textView.textContainerInset.left, _textView.textContainerInset.bottom, _textView.textContainerInset.right);
    
    self.bioHeader = [[UITextField alloc] init];
    self.bioHeader.text = [NSString stringWithFormat:@"%@ Biography", self.character];
    self.bioHeader.font = [UIFont fontWithName:@"Lato-Light" size:40];
    self.bioHeader.textAlignment = NSTextAlignmentCenter;
    self.bioHeader.backgroundColor = [UIColor projectHighlightColor];
    [self.view addSubview:self.bioHeader];
}

- (void) viewDidLayoutSubviews {
    NSLog(@"Laying out subviews");
    //CGRect viewBounds = self.view.bounds;
    CGFloat statusBarHeight = self.topLayoutGuide.length;
    _topOffset = statusBarHeight + self.navigationController.navigationBar.frame.size.height;
//    NSLog(@"topOffset: %f - Navbar height: %f", _topOffset, self.navigationController.navigationBar.frame.size.height);
    self.bioHeader.frame = CGRectMake(0, _topOffset, CGRectGetWidth(self.view.frame), 100);
    self.textEdge = UIEdgeInsetsMake(_topOffset + CGRectGetHeight(self.bioHeader.frame), 0, 0, 0);
    self.textView.contentInset = self.textEdge;
//        NSLog(@"Text view: x: %f y: %f width: %f height: %f textcontaininset top: %f left: %f bottom: %f right: %f", _textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textView.frame.size.height, _textView.textContainerInset.top, _textView.textContainerInset.left, _textView.textContainerInset.bottom, _textView.textContainerInset.right);
//    [self.textView layoutIfNeeded];
//    [self.textView layoutSubviews];
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveCharacter];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.textView.text = self.character.bio;
    self.bioHeader.text = [NSString stringWithFormat:@"%@ Biography", self.character.name];
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
//    [self.view setNeedsLayout];
//    [self.view layoutSubviews];
//    [self.textView setNeedsLayout];
//    [self.textView layoutIfNeeded];
//    [self.textView layoutSubviews];
//        NSLog(@"Text view: x: %f y: %f width: %f height: %f textcontaininset top: %f left: %f bottom: %f right: %f", _textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textView.frame.size.height, _textView.textContainerInset.top, _textView.textContainerInset.left, _textView.textContainerInset.bottom, _textView.textContainerInset.right);
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
    NSLog(@"KB was shown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (kbSize.height));
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    NSLog(@"KB was hid");
    //self.textView.contentInset = self.textEdge;
    //self.textView.scrollIndicatorInsets = self.textEdge;
    _textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 60);
    [self.textView.layoutManager ensureLayoutForTextContainer:self.textView.textContainer];
    [self saveCharacter];
}

@end
