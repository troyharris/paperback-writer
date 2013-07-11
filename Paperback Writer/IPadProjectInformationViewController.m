//
//  IPadProjectInfoViewController.m
//  
//
//  Created by Troy HARRIS on 5/23/13.
//
//

#import "IPadProjectInformationViewController.h"
#import "GlobalProject.h"
#import "AppDelegate.h"
#import "UIColor+THColor.h"
#import "THUtil.h"
#import "UIView+THAutoLayout.h"
#import "THLabel.h"
#import "Outline.h"

@interface IPadProjectInformationViewController ()

@end

@implementation IPadProjectInformationViewController

static float kGutter = 20.0f;
static float kMargin = 20.0f;

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)saveProject {
    [_desc resignFirstResponder];
    [_projectTitle resignFirstResponder];
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    _project.title = _projectTitle.text;
    _project.desc = _desc.text;
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveProject];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.view endEditing:YES];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGFloat widthWithGutter = [THUtil getRealDeviceWidth] - (kGutter * 2);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    
    CGRect scrollFrame = _scrollView.frame;
    scrollFrame.size.width = [THUtil getRealDeviceWidth];
    _scrollView.frame = scrollFrame;
    
    CGRect titleFrame = _projectTitle.frame;
    titleFrame.size.width = widthWithGutter;
    _projectTitle.frame = titleFrame;
    
    CGRect typeFrame = _typeAndGenre.frame;
    typeFrame.size.width = widthWithGutter;
    _typeAndGenre.frame = typeFrame;
    
    CGRect hrFrame = _hr.frame;
    hrFrame.size.width = widthWithGutter;
    _hr.frame = hrFrame;
    
    CGRect synopsisFrame = _synopsis.frame;
    synopsisFrame.size.width = widthWithGutter;
    _synopsis.frame = synopsisFrame;
    
    CGRect descFrame = _desc.frame;
    descFrame.size.width = widthWithGutter;
    _desc.frame = descFrame;
    
    CGRect statFrame = _statView.frame;
   statFrame.size.width = [THUtil getRealDeviceWidth];
    _statView.frame = statFrame;
    [self resizeStatBoxes];
    
    
    [UIView commitAnimations];
}

-(id)init {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHasShown:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHasHid:) name:UIKeyboardWillHideNotification object:nil];
        //[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        //self.view.autoresizesSubviews = YES;
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveProject)];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    CGRect tmpFrame = CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight]);
    _scrollView.frame = tmpFrame;
    _scrollView.contentSize = _scrollView.frame.size;
    _scrollView.scrollEnabled = YES;
//    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    _contentView = [[UIView alloc] init];
//    CGRect contFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    _scrollView.frame = contFrame;
//    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [_scrollView addSubview:_contentView];
    
    NSLog(@"Okay, the root view width is %f and height is %f", self.view.bounds.size.width, self.view.bounds.size.height);
    //[_scrollView setContentSize:self.view.bounds.size];
    NSLog(@"The scrollview content size is %f width & %f height", _scrollView.contentSize.width, _scrollView.contentSize.height);
    
    
   // _scrollView.frame = self.view.frame;
    self.view.backgroundColor = [UIColor projectBackgroundColor];
    //[_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_scrollView];
    /*
    UIView *mainView = self.view;

    [self.view addConstraintsWithString:@"H:|[_scrollView(==mainView)]|" bindings:NSDictionaryOfVariableBindings(_scrollView, mainView)];
    [self.view addConstraintsWithString:@"V:|[_scrollView(==mainView)]|" bindings:NSDictionaryOfVariableBindings(_scrollView, mainView)];
    [self.view addConstraintsWithString:@"H:|[_contentView(==mainView)]|" bindings:NSDictionaryOfVariableBindings(_contentView, mainView)];
    [self.scrollView addConstraintsWithString:@"V:|[_contentView]|" bindings:NSDictionaryOfVariableBindings(_contentView)];
     */
    
    [self buildProject];
    [self makeTitleField];
    [self makeDescriptionField];
    [self makeStatBoxes];
    
    //[self.contentView systemLayoutSizeFittingSize:_scrollView.contentSize];
    NSLog(@"The contentview size is %f width & %f height", self.contentView.frame.size.width, self.contentView.frame.size.height);
	// Do any additional setup after loading the view.
}

-(void)buildProject {
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
}

-(void)makeTitleField {
    
    //CGRect titleFrame = CGRectMake(20, 20, [THUtil getRealDeviceWidth] - 40, 70);
    //_projectTitle = [[UITextField alloc] initWithFrame:titleFrame];
    _projectTitle = [[UITextField alloc] init];
    _projectTitle.frame = CGRectMake(kGutter, kGutter, [THUtil getRealDeviceWidth] - (kGutter * 2), 70);
    _projectTitle.font = [UIFont fontWithName:@"Lato-Light" size:60.0];
    _projectTitle.textColor = [UIColor projectDarkTextColor];
    _projectTitle.textAlignment = NSTextAlignmentCenter;
    _projectTitle.adjustsFontSizeToFitWidth = YES;
    _projectTitle.text = _project.title;
    //[_projectTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:_projectTitle];
    _projectTitle.borderStyle = UITextBorderStyleNone;
    _projectTitle.backgroundColor = [UIColor clearColor];
    /*
    NSArray *titleConst = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_projectTitle]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_projectTitle)];
    [self.view addConstraints:titleConst];
    */
    
    _typeAndGenre = [[THLabel alloc] init];
    [_typeAndGenre setTranslatesAutoresizingMaskIntoConstraints:YES];
    _typeAndGenre.frame = CGRectMake(kGutter, [THUtil getViewBottomOrigin:_projectTitle] + kMargin, [THUtil getRealDeviceWidth] - (kGutter * 2), 20);
    [_typeAndGenre setFont:[UIFont fontWithName:@"Lato-Black" size:18]];
    _typeAndGenre.text = [NSString stringWithFormat:@"A %@ %@", _project.genre, _project.type];
    _typeAndGenre.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_typeAndGenre];
    
    _hr = [[UIView alloc] init];
    _hr.frame = CGRectMake(kGutter, [THUtil getViewBottomOrigin:_typeAndGenre] + kMargin, [THUtil getRealDeviceWidth] - (kGutter * 2), 1);
    //[_hr setTranslatesAutoresizingMaskIntoConstraints:NO];
    _hr.backgroundColor = [UIColor projectDarkColor];
    [self.scrollView addSubview:_hr];
    /*
    [self.contentView addConstraintsWithString:@"H:|-(gutter)-[_projectTitle]-(gutter)-|" bindings:NSDictionaryOfVariableBindings(_projectTitle)];
    [self.contentView addConstraintsWithString:@"H:|-[_typeAndGenre]-|" bindings:NSDictionaryOfVariableBindings(_typeAndGenre)];
    [self.contentView addConstraintsWithString:@"H:|-(gutter)-[_hr]-(gutter)-|" bindings:NSDictionaryOfVariableBindings(_hr)];
    [self.contentView addConstraintsWithString:@"V:|-(gutter)-[_projectTitle]-[_typeAndGenre]-(margin)-[_hr(1)]" bindings:NSDictionaryOfVariableBindings(_projectTitle, _typeAndGenre, _hr)];
     */
}

-(void)makeDescriptionField {
    _synopsis = [[THLabel alloc] init];
    [_synopsis setTranslatesAutoresizingMaskIntoConstraints:YES];
    _synopsis.frame = CGRectMake(kGutter, [THUtil getViewBottomOrigin:_hr] + kMargin, [THUtil getRealDeviceWidth] - (kGutter * 2), 30);
    _synopsis.text = @"Synopsis";
    [self.scrollView addSubview:_synopsis];
    
    
    _desc = [[UITextView alloc] init];
    _desc.frame = CGRectMake(kGutter, [THUtil getViewBottomOrigin:_synopsis] + kMargin, [THUtil getRealDeviceWidth] - (kGutter * 2), 200);
    _desc.delegate = self;
    //[_desc setTranslatesAutoresizingMaskIntoConstraints:NO];
    _desc.font = [UIFont fontWithName:@"Lato-Light" size:16.0];
    _desc.textColor = [UIColor projectDarkTextColor];
    _desc.backgroundColor = [UIColor clearColor];
    _desc.text = _project.desc;
    _desc.scrollEnabled = NO;
    //[_desc sizeToFit];
    [self.scrollView addSubview:_desc];
    [self updateTextViewSize];
    [self updateScrollViewSize];
    /*
    [self.contentView addConstraintsWithString:@"H:|-(gutter)-[_synopsis]" bindings:NSDictionaryOfVariableBindings(_synopsis)];
    [self.contentView addConstraintsWithString:@"H:|-(gutter)-[_desc]-(gutter)-|" bindings:NSDictionaryOfVariableBindings(_desc)];
    [self redoTextConstWithHeight:40];
    [self redoTextConstWithHeight:200];
     */
 //   [self.contentView addConstraintsWithString:@"V:[_hr]-(margin)-[_synopsis]-[_desc(>=40)]-|" bindings:NSDictionaryOfVariableBindings(_hr, _synopsis, _desc)];

}

-(void)makeStatBoxes {
    _statView = [[UIView alloc] initWithFrame:CGRectMake(0, [THUtil getViewBottomOrigin:_desc] + (kMargin * 2), [THUtil getRealDeviceWidth], 200)];
    [self.scrollView addSubview:_statView];
    CGFloat width = (_statView.frame.size.width - (kMargin *2) - (kGutter * 2)) / 3;
    _charBox = [[StatBox alloc] initWithFrame:CGRectMake(kGutter, 0, width, 200)];
    _charBox.statNum.text = [NSString stringWithFormat:@"%d", [_project.characters count]];
    _charBox.statTitle.text = @"Characters";
    [self.statView addSubview:_charBox];
    
    NSArray *outlines = [_project.outlines allObjects];
    Outline *outline = [outlines objectAtIndex:0];
    
    _sceneBox = [[StatBox alloc] initWithFrame:CGRectMake(_charBox.frame.origin.x + kMargin + width, 0, width, 200)];
    _sceneBox.statNum.text = [NSString stringWithFormat:@"%d", [outline.scenes count]];
    _sceneBox.statTitle.text = @"Scenes";
    [self.statView addSubview:_sceneBox];
    
    _noteBox = [[StatBox alloc] initWithFrame:CGRectMake(_sceneBox.frame.origin.x + kMargin + width, 0, width, 200)];
    _noteBox.statNum.text = [NSString stringWithFormat:@"%d", [_project.researches count]];
    _noteBox.statTitle.text = @"Notes";
    [self.statView addSubview:_noteBox];
}

-(void)resizeStatBoxes {
    
    CGFloat width = (_statView.frame.size.width - (kMargin *2) - (kGutter * 2)) / 3;
    
    CGRect charFrame = _charBox.frame;
    charFrame.size.width = width;
    _charBox.frame = charFrame;
    
    CGRect sceneFrame = _sceneBox.frame;
    sceneFrame.size.width = width;
    sceneFrame.origin.x = _charBox.frame.origin.x + kMargin + width;
    _sceneBox.frame = sceneFrame;
    
    CGRect noteFrame = _noteBox.frame;
    noteFrame.size.width = width;
    noteFrame.origin.x = _sceneBox.frame.origin.x + kMargin + width;
    _noteBox.frame = noteFrame;
}

-(void)redoTextConstWithHeight:(CGFloat)height {
    if (_textConst) {
        [self.contentView removeConstraints:_textConst];
    }
    NSDictionary *metrics = [self.view projectMetrics];
    NSString *vfl = [NSString stringWithFormat:@"V:[_hr]-(margin)-[_synopsis]-[_desc(%f)]-|", height];
    _textConst = [NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_hr, _synopsis, _desc)];
    [self.contentView addConstraints:_textConst];
}

-(void)viewWillAppear:(BOOL)animated {
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    [self updateTextViewSize];
    [self updateScrollViewSize];
    [_scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextViewDelegate functions

-(void)textViewDidBeginEditing:(UITextView *)textView {
    /*
    CGFloat keyboardSize;
    if (UIInterfaceOrientationIsLandscape([THUtil orientation])) {
       // keyboardSize = 420;
        keyboardSize = [self realKeyboardHeight];
    } else {
       // keyboardSize = 330;
        keyboardSize = [self realKeyboardHeight];
    }
    CGRect frame = _scrollView.frame;
    CGFloat newHeight = frame.size.height - keyboardSize;
    frame.size.height = newHeight;
    _scrollView.frame = frame;
     */
     
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    /*
    CGRect frame = _scrollView.frame;
    CGFloat newHeight = [THUtil getRealDeviceHeight];
    frame.size.height = newHeight;
    _scrollView.frame = frame;
     */
    [self saveProject];
     
}

-(void)textViewDidChange:(UITextView *)textView {
    [self updateTextViewSize];
    [self updateScrollViewSize];
    [_desc setNeedsLayout];
    [_scrollView setNeedsLayout];
}

-(void)updateTextViewSize {
    CGRect frame = _desc.frame;
    //frame.size.height = _desc.contentSize.height;
    NSLayoutManager *layout = [_desc layoutManager];
    NSRange charRange = NSMakeRange(0, _desc.text.length);
    CGRect glyphRect = [layout boundingRectForGlyphRange:charRange inTextContainer:[_desc textContainer]];
    frame.size.height = glyphRect.size.height + 10;
    //frame.size.height = _desc.intrinsicContentSize.height;
    NSLog(@"textbox height is %f", glyphRect.size.height);
    NSLog(@"scrollview content height is %f", _scrollView.contentSize.height);
    NSLog(@"scrollview frame height is %f", _scrollView.frame.size.height);
    _desc.frame = frame;
    CGFloat statBoxOrigin = [THUtil getViewBottomOrigin:_desc] + (kMargin * 2);
    _statView.frame = CGRectMake(_statView.frame.origin.x, statBoxOrigin, _statView.frame.size.width, _statView.frame.size.height);
}

-(void)updateScrollViewSize {
    CGSize contentSize = _scrollView.contentSize;
    contentSize.height = _statView.frame.origin.y + _statView.frame.size.height + (kGutter *4);
    _scrollView.contentSize = contentSize;
            [self scrollToCursor];
}

-(void)keyboardHeight:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    _keyHeight = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSLog(@"Keyboard height changed to %f", [_keyHeight CGRectValue].size.height);
    //_keyHeight = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
}

-(void)keyboardHasShown:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    _keyHeight = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat keyboardSize;
    if (UIInterfaceOrientationIsLandscape([THUtil orientation])) {
        // keyboardSize = 420;
        keyboardSize = [self realKeyboardHeight];
    } else {
        // keyboardSize = 330;
        keyboardSize = [self realKeyboardHeight];
    }
    CGRect frame = _scrollView.frame;
    CGFloat newHeight = frame.size.height - keyboardSize;
    frame.size.height = newHeight;
    _scrollView.frame = frame;
    NSLog(@"THE SCROLLVIEW FRAME SIZE HEIGHT IS %f", _scrollView.frame.size.height);
    [self scrollToCursor];
    self.navigationItem.rightBarButtonItem = _doneButton;
}

-(void)keyboardHasHid:(NSNotification *)notification {
        [_desc setNeedsLayout];
    CGRect frame = _scrollView.frame;
    CGFloat newHeight = [THUtil getRealDeviceHeight];
    frame.size.height = newHeight;
    _scrollView.frame = frame;
    self.navigationItem.rightBarButtonItem = nil;
}

-(CGFloat)realKeyboardHeight {
    CGFloat height;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        height = [_keyHeight CGRectValue].size.width;
        //height = [_keyHeight CGRectValue].size.height;
    } else {
        height = [_keyHeight CGRectValue].size.height;
    }
    NSLog(@"Keyboard Height is %f", height);
    return height;
}

- (void)scrollToCursor
{
    // if there is a selection cursor…
    if(_desc.selectedRange.location != NSNotFound) {
        NSLog(@"WEEEARESCROLLING>...");
       // NSLog(@"selectedRange: %d %d", noteTextView.selectedRange.location, noteTextView.selectedRange.length);
        
        // work out how big the text view would be if the text only went up to the cursor
        NSRange range;
        range.location = _desc.selectedRange.location;
        range.length = _desc.text.length - range.location;
        NSString *string = [_desc.text stringByReplacingCharactersInRange:range withString:@""];
        CGSize size = [string sizeWithFont:_desc.font constrainedToSize:_desc.bounds.size lineBreakMode:NSLineBreakByWordWrapping];
        
        // work out where that position would be relative to the textView's frame
        CGRect viewRect = _desc.frame;
        float scrollHeight = viewRect.origin.y + size.height;
        CGRect finalRect = CGRectMake(1, scrollHeight, 1, 30);
        
        // scroll to it
        NSLog(@"SCROLL TO %f", scrollHeight);
        [_scrollView scrollRectToVisible:finalRect animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"SV delegate at your service");
    [_desc setNeedsLayout];
   // [_scrollView setNeedsLayout];
   // [_scrollView layoutIfNeeded];
   // [_scrollView layoutSubviews];
}


@end
