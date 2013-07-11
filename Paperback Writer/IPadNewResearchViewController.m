//
//  IPadNewResearchViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/30/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNewResearchViewController.h"
#import "UIColor+THColor.h"
#import "THUtil.h"
#import "AppDelegate.h"
#import "GlobalProject.h"
#import "Research.h"
#import "Note.h"
#import <UIColor+FlatUI.h>

@interface IPadNewResearchViewController ()

@end

@implementation IPadNewResearchViewController

static const int kTypePicker = 0;
static const float kTopSize = 300.0;

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

-(void)pressGallery {
    [self presentViewController:_galleryPicker animated:YES completion:nil];
}

-(void)pressCamera {
    [self presentViewController:_cameraPicker animated:YES completion:nil];
}

-(void)makeColors {
    _noteColors = [NSArray arrayWithObjects:[UIColor carrotColor], [UIColor alizarinColor], [UIColor pumpkinColor], [UIColor pomegranateColor], nil];
    _urlColors = [NSArray arrayWithObjects:[UIColor peterRiverColor], [UIColor belizeHoleColor], [UIColor amethystColor], [UIColor wisteriaColor], nil];
}

-(void)addCharacter {
    GlobalProject *gp = [GlobalProject sharedProject];
    AppDelegate *apd = [self ad];
    NSManagedObjectContext *context = apd.managedObjectContext;
    Research *research = [NSEntityDescription insertNewObjectForEntityForName:@"Research" inManagedObjectContext:context];
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    //    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:context];
    //    project.title = _projectTitle.text;
    research.notes = note;
    research.notes.desc = _researchTitle.text;
    switch (_typeSwitch.selectedSegmentIndex) {
        case 0: {
            research.notes.type = @"Note";
            NSString *noteTitle = (_researchTitle.text.length == 0) ? @"A Note" : _researchTitle.text;
            research.notes.desc = noteTitle;
            research.notes.content = _noteText.text;
            research.type = @"Note";
            research.color = [THUtil getRandomColor:_noteColors];
            break;
        }
        case 1: {
            research.notes.type = @"URL";
            NSString *urlTitle = (_researchTitle.text.length == 0) ? @"A Website" : _researchTitle.text;
            research.notes.desc = urlTitle;
            research.notes.content = _urlText.text;
            research.type = @"URL";
            research.color = [THUtil getRandomColor:_urlColors];
            break;
        }
        case 2: {
            research.notes.type = @"Image";
            NSString *imageTitle = (_researchTitle.text.length == 0) ? @"An Image" : _researchTitle.text;
            research.notes.desc = imageTitle;
            research.type = @"Image";
            research.notes.image = _imageData;
            research.color = [UIColor blackColor];
            break;
        }
        default:
            break;
    }
    [gp.project addResearchesObject:research];
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

-(void)showNotes {
    [self.view resignFirstResponder];
    [_topView resignFirstResponder];
    [_researchTitle resignFirstResponder];
    _noteEntry = [[UIView alloc] init];
    [_noteEntry setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_underView addSubview:_noteEntry];
    _underConstH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_noteEntry]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_noteEntry)];
    _underConstV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_noteEntry]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_noteEntry)];
    [_underView addConstraints:_underConstH];
    [_underView addConstraints:_underConstV];
    SelectorLabel *noteLabel = [[SelectorLabel alloc] initWithLeftSide];
    noteLabel.text = @"Note";
    [_noteEntry addSubview:noteLabel];
    
    _noteText = [[UITextView alloc] init];
    [_noteText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_noteEntry addSubview:_noteText];
    
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[noteLabel]-[_noteText(>=150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel, _noteText)];
    NSArray *contraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[noteLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel)];
    NSArray *contraintsHText = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_noteText]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_noteText)];
    [_noteEntry addConstraints:contraints];
    [_noteEntry addConstraints:contraintsH];
    [_noteEntry addConstraints:contraintsHText];
    
    
}

-(void)showURL {
    [self.view resignFirstResponder];
    [_topView resignFirstResponder];
    [_researchTitle resignFirstResponder];
    _urlEntry = [[UIControl alloc] init];
    _urlEntry.userInteractionEnabled = YES;
    [_urlEntry setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_underView addSubview:_urlEntry];
    _underConstH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_urlEntry]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_urlEntry)];
    _underConstV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_urlEntry]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_urlEntry)];
    [_underView addConstraints:_underConstH];
    [_underView addConstraints:_underConstV];
    SelectorLabel *noteLabel = [[SelectorLabel alloc] initWithLeftSide];
    noteLabel.text = @"Webpage";
    [_urlEntry addSubview:noteLabel];
    
    _urlText = [[UITextField alloc] init];
    _urlText.borderStyle = UITextBorderStyleRoundedRect;
    _urlText.userInteractionEnabled = YES;
    _urlText.enabled = YES;
    _urlText.userInteractionEnabled = YES;
    [_urlText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_urlEntry addSubview:_urlText];
    
    
    //[_urlText becomeFirstResponder];
    
    UIView* v = _urlText;
    while ( v.superview != nil )
    {
        NSLog( @"%@ - %@", NSStringFromClass([v class]), CGRectContainsRect( v.superview.bounds, v.frame ) ? @"GOOD!" : @"BAD!" );
        v = v.superview;
    }
    
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[noteLabel]-[_urlText]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel, _urlText)];
    NSArray *contraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[noteLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel)];
    NSArray *contraintsHText = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_urlText]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_urlText)];
    [_urlEntry addConstraints:contraints];
    [_urlEntry addConstraints:contraintsH];
    [_urlEntry addConstraints:contraintsHText];
}

-(void)showImage {
    [self.view resignFirstResponder];
    [_topView resignFirstResponder];
    [_researchTitle resignFirstResponder];
    /*
    _imageEntry = [[UIView alloc] init];
    [_imageEntry setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_underView addSubview:_imageEntry];
    _underConstH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_imageEntry]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageEntry)];
    _underConstV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_imageEntry]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageEntry)];
    [_underView addConstraints:_underConstH];
    [_underView addConstraints:_underConstV];
     */
    SelectorLabel *noteLabel = [[SelectorLabel alloc] initWithLeftSide];
    noteLabel.text = @"Image";
    [_underView addSubview:noteLabel];
    
    FUIButton *galleryButton = [[FUIButton alloc] init];
    [galleryButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [galleryButton setTitle:@"Add from Gallery" forState:UIControlStateNormal];
    galleryButton.buttonColor = [UIColor projectBackgroundColor];
    galleryButton.shadowColor = [UIColor projectHighlightColor];
    galleryButton.shadowHeight = 3.0f;
    galleryButton.cornerRadius = 6.0f;
    galleryButton.titleLabel.font = [UIFont fontWithName:@"Lato-Black" size:20];
    [galleryButton setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateNormal];
    [galleryButton setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateHighlighted];
    [galleryButton addTarget:self action:@selector(pressGallery) forControlEvents:UIControlEventTouchUpInside];
    
    FUIButton *cameraButton = [[FUIButton alloc] init];
    [cameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cameraButton setTitle:@"New from Camera" forState:UIControlStateNormal];
    cameraButton.buttonColor = [UIColor projectBackgroundColor];
    cameraButton.shadowColor = [UIColor projectHighlightColor];
    cameraButton.shadowHeight = 3.0f;
    cameraButton.cornerRadius = 6.0f;
    cameraButton.titleLabel.font = [UIFont fontWithName:@"Lato-Black" size:20];
    [cameraButton setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateHighlighted];
    [cameraButton addTarget:self action:@selector(pressCamera) forControlEvents:UIControlEventTouchUpInside];
    
    [_underView addSubview:galleryButton];
    [_underView addSubview:cameraButton];
    
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[noteLabel]-[galleryButton(40)]-[cameraButton(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel,galleryButton, cameraButton)];
    NSArray *contraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[noteLabel]-(40)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel)];
    NSArray *contraintsHText = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[galleryButton]-(40)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(galleryButton)];
    NSArray *contraintsHCamera = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[cameraButton]-(40)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cameraButton)];
    [_underView addConstraints:contraints];
    [_underView addConstraints:contraintsH];
    [_underView addConstraints:contraintsHText];
    [_underView addConstraints:contraintsHCamera];
    
    
}

-(void)pressContent:(UIControl *)sender {
    switch (_typeSwitch.selectedSegmentIndex) {
        case 0:
            [_noteText becomeFirstResponder];
            break;
        case 1:
            [_urlText becomeFirstResponder];
            break;
        default:
            break;
    }
}

-(void)removeUnderViews {
 /*   if (_underView.constraints != (id)[NSNull null]) {
        [_underView removeConstraints:_underConstH];
        [_underView removeConstraints:_underConstV];
    } */
    [_noteEntry removeFromSuperview];
    [_urlEntry removeFromSuperview];
    for (UIView *v in _underView.subviews) {
        [v removeFromSuperview];
    }
}

-(void)valueChanged:(UISegmentedControl *)sender {
    [self removeUnderViews];
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self showNotes];
            break;
        case 1:
            [self showURL];
            break;
        case 2:
            [self showImage];
        default:
            break;
    }
    if (_bottomView.frame.origin.y == kTopSize) {
        CGRect moveFrame = _bottomView.frame;
        moveFrame.origin.y = moveFrame.origin.y + kTopSize;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        _bottomView.frame = moveFrame;
        
        [UIView commitAnimations];
    }
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeColors];
    _galleryPicker = [[UIImagePickerController alloc] init];
    _galleryPicker.allowsEditing = YES;
    _galleryPicker.delegate = self;
    _galleryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    _cameraPicker = [[UIImagePickerController alloc] init];
    _cameraPicker.allowsEditing = YES;
    _cameraPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [_cameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        [_cameraPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    _underView = [[UIControl alloc] initWithFrame:CGRectMake(0, kTopSize, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight] - kTopSize)];
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], kTopSize)];
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopSize, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight] - kTopSize)];
    _underView.backgroundColor = [UIColor projectDarkColor];
    _topView.backgroundColor = [UIColor projectHighlightColor];
    _bottomView.backgroundColor = [UIColor projectHighlightColor];
    _underView.userInteractionEnabled = YES;
    [_underView addTarget:self action:@selector(pressContent:) forControlEvents:UIControlEventTouchDown];
    
    
    
//    _topView.backgroundColor = [UIColor orangeColor];
//    _bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_underView];
    [self.view addSubview:_topView];
    [self.view addSubview:_bottomView];
    [_underView invalidateIntrinsicContentSize];
    [_topView invalidateIntrinsicContentSize];
    [_bottomView invalidateIntrinsicContentSize];
    [_underView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *underC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(300)-[_underView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_underView)];
    NSArray *underCH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_underView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_underView)];
    [self.view addConstraints:underC];
    [self.view addConstraints:underCH];
    _types = [NSArray arrayWithObjects:@"Note", @"Web", @"Image", nil];
    NSLog(@"Y U NO SHOW?");
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor projectHighlightColor];
    _header = [[NewObjectLabel alloc] init];
    _header.text = @"New Research";
    
    [_topView addSubview:_header];
    
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_header]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header)];
    [_topView addConstraints:contraints];
    
    
    _researchTitle = [[NewObjectTextField alloc] init];
    [_topView addSubview:_researchTitle];
    
    NSArray *titleConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_researchTitle]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_researchTitle)];
    [_topView addConstraints:titleConsts];
    
  /*
    _typeLabel = [[SelectorLabel alloc] initWithLeftSide];
    _typeLabel.text = @"Type";
    [_typeLabel invalidateIntrinsicContentSize];
    [_topView addSubview:_typeLabel];
   */
 /*
    
    _typePicker = [[ProjectPicker alloc] initWithLeftSideAndTag:kTypePicker];
    [_typePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_typePicker invalidateIntrinsicContentSize];
    _typePicker.delegate = self;
    _typePicker.dataSource = self;
    [_topView addSubview:_typePicker];
    
    NSArray *pickerLabConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_typeLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_typeLabel)];
    [_topView addConstraints:pickerLabConsts];
  */
    NSArray *controlItems = [NSArray arrayWithObjects:@"Note", @"Website", @"Image", nil];
    _typeSwitch = [[UISegmentedControl alloc] initWithItems:controlItems];
    [_typeSwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    _typeSwitch.tintColor = [UIColor projectLightTextColor];
    [_typeSwitch addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [_topView addSubview:_typeSwitch];
    
 /*
    NSArray *pickerLabConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_typeLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_typeLabel)];
    [_topView addConstraints:pickerLabConsts];
  */
    
    NSArray *switchConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_typeSwitch]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_typeSwitch)];
    //NSArray *switchConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_typeSwitch(60)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_typeSwitch)];
    [_topView addConstraints:switchConsts];
    //[_topView addConstraints:switchConstsV];
    
    NSArray *topConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(80)-[_header]-[_researchTitle]-[_typeSwitch(60)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header, _researchTitle, _typeSwitch)];
    [_topView addConstraints:topConsts];
    
    CGFloat buttonWidth = ([THUtil getRealDeviceWidth] - 60) / 2;
    
    CGRect addFrame = CGRectMake(20, 300, buttonWidth, 60);
    _add = [[FUIButton alloc] initWithFrame:addFrame];
    //[_add invalidateIntrinsicContentSize];
    [_add setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_add setTitle:@"Add" forState:UIControlStateNormal];
    _add.buttonColor = [UIColor projectBackgroundColor];
    _add.shadowColor = [UIColor projectHighlightColor];
    _add.shadowHeight = 3.0f;
    _add.cornerRadius = 6.0f;
    _add.titleLabel.font = [UIFont fontWithName:@"Lato-Black" size:20];
    [_add setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateNormal];
    [_add setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateHighlighted];
    [_add addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_add];
    
    CGRect cancelFrame = CGRectMake(buttonWidth + 30, 300, buttonWidth, 60);
    _cancel = [[FUIButton alloc] initWithFrame:cancelFrame];
    //[_cancel invalidateIntrinsicContentSize];
    [_cancel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    _cancel.buttonColor = [UIColor projectBackgroundColor];
    _cancel.shadowColor = [UIColor projectHighlightColor];
    _cancel.shadowHeight = 3.0f;
    _cancel.cornerRadius = 6.0f;
    _cancel.titleLabel.font = [UIFont fontWithName:@"Lato-Black" size:20];
    [_cancel setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateNormal];
    [_cancel setTitleColor:[UIColor projectDarkTextColor] forState:UIControlStateHighlighted];
    [_cancel addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_cancel];
    
    NSArray *buttonConsts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_add(>=200)]-20-[_cancel(==_add)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_add, _cancel)];
    [_bottomView addConstraints:buttonConsts];
    
    NSArray *addButtonHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_add(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_add)];
    [_bottomView addConstraints:addButtonHeight];
    
    NSArray *cancelButtonHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_cancel(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancel)];
    [_bottomView addConstraints:cancelButtonHeight];

}

#pragma mark - HorizontalPickerView DataSource Methods
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
        return [_types count];
}

- (NSString *)horizontalPickerView:(V8HorizontalPickerView *)picker titleForElementAtIndex:(NSInteger)index {
        return [_types objectAtIndex:index];
}

- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
	CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
	NSString *text;
    text = [_types objectAtIndex:index];

	CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
	return textSize.width + 40.0f; // 20px padding on each side
}

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index {
    NSLog(@"It moved!");
    [self removeUnderViews];
    switch (index) {
        case 0:
            [self showNotes];
            break;
        case 1:
            [self showURL];
            break;
        default:
            break;
    }
    if (_bottomView.frame.origin.y == kTopSize) {
        CGRect moveFrame = _bottomView.frame;
        moveFrame.origin.y = moveFrame.origin.y + kTopSize;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        _bottomView.frame = moveFrame;
        
        [UIView commitAnimations];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selected = [info objectForKey:UIImagePickerControllerEditedImage];
        _imageData = UIImagePNGRepresentation(selected);
        [self pressAdd];
    }];
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationPortraitUpsideDown;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
