//
//  IPadCharacterBioViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/16/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadCharacterBioViewController.h"
#import "UIColor+THColor.h"

@interface IPadCharacterBioViewController ()

@property (nonatomic) CGFloat topOffset;
@property (nonatomic) UIEdgeInsets textEdge;

@end

@implementation IPadCharacterBioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loading");
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.font = [UIFont fontWithName:@"Lato-Light" size:18];
    [self.view addSubview:self.textView];
    
    self.bioHeader = [[UITextField alloc] init];
    self.bioHeader.text = @"Biography";
    self.bioHeader.font = [UIFont fontWithName:@"Lato-Black" size:40];
    self.bioHeader.backgroundColor = [UIColor projectHighlightColor];
    [self.view addSubview:self.bioHeader];
}

- (void) viewDidLayoutSubviews {
    NSLog(@"Laying out subviews");
    CGRect viewBounds = self.view.bounds;
    CGFloat statusBarHeight = self.topLayoutGuide.length;
    _topOffset = statusBarHeight + self.navigationController.navigationBar.frame.size.height;
    NSLog(@"topOffset: %f - Navbar height: %f", _topOffset, self.navigationController.navigationBar.frame.size.height);
    self.bioHeader.frame = CGRectMake(0, _topOffset, CGRectGetWidth(self.view.frame), 100);
    self.textEdge = UIEdgeInsetsMake(_topOffset + CGRectGetHeight(self.bioHeader.frame), 0, 60, 0);
    self.textView.textContainerInset = self.textEdge;
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
    /*
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.textEdge.top, 0.0, kbSize.height + 100, 0.0);
    self.textView.textContainerInset = contentInsets;
    self.textView.scrollIndicatorInsets = contentInsets;
     */
    _textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kbSize.height);
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    NSLog(@"KB was hid");
    //UIEdgeInsets contentInsets = self.textEdge;
    self.textView.textContainerInset = self.textEdge;
    self.textView.scrollIndicatorInsets = self.textEdge;
}

@end
