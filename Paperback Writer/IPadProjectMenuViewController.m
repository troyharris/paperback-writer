//
//  IPadProjectMenuViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadProjectMenuViewController.h"
#import "IPadProjectInfoViewController.h"
#import "IPadProjectCharacterViewController.h"

@interface IPadProjectMenuViewController ()

@end

@implementation IPadProjectMenuViewController
@synthesize delegate;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)pressInfo {
    NSLog(@"Pressed Info");
    [self.delegate didSelectMenuItem:1];
 //   self.viewDeckController.centerController = [[IPadProjectInfoViewController alloc] initWithNibName:@"IPadProjectInfoViewController" bundle:nil];
}

-(void)pressCharacter {
    [self.delegate didSelectMenuItem:2];
   NSLog(@"Pressed Character");
 //   self.viewDeckController.centerController = [[IPadProjectCharacterViewController alloc] initWithNibName:@"IPadProjectCharacterViewController" bundle:nil];
}

-(void)pressOutline {
    [self.delegate didSelectMenuItem:3];
}

-(void)pressResearch {
    [self.delegate didSelectMenuItem:4];
}



-(void)closeProject {
    NSLog(@"Pressed close");
    [self.delegate didSelectMenuItem:0];
}

- (void)showSelector {
  //  [self.viewDeckController toggleLeftViewAnimated:YES];
}

-(void)back {
  //  [self.viewDeckController closeLeftView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self viewDidLoad];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    CGRect closeFrame = CGRectMake(20, 20, 100, 40);
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = closeFrame;
    closeButton.showsTouchWhenHighlighted = NO;
    closeButton.reversesTitleShadowWhenHighlighted = YES;
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeProject) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect infoFrame = CGRectMake(20, 70, 100, 40);
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    infoButton.frame = infoFrame;
    infoButton.showsTouchWhenHighlighted = NO;
    infoButton.reversesTitleShadowWhenHighlighted = YES;
    [infoButton setTitle:@"Info" forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(pressInfo) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect characterFrame = CGRectMake(20, 120, 100, 40);
    UIButton *characterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    characterButton.frame = characterFrame;
    characterButton.showsTouchWhenHighlighted = NO;
    characterButton.reversesTitleShadowWhenHighlighted = YES;
    [characterButton setTitle:@"Character" forState:UIControlStateNormal];
    [characterButton addTarget:self action:@selector(pressCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect outlineFrame = CGRectMake(20, 170, 100, 40);
    UIButton *outlineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    outlineButton.frame = outlineFrame;
    outlineButton.showsTouchWhenHighlighted = NO;
    outlineButton.reversesTitleShadowWhenHighlighted = YES;
    [outlineButton setTitle:@"Outline" forState:UIControlStateNormal];
    [outlineButton addTarget:self action:@selector(pressCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect researchFrame = CGRectMake(20, 220, 100, 40);
    UIButton *researchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    researchButton.frame = researchFrame;
    researchButton.showsTouchWhenHighlighted = NO;
    researchButton.reversesTitleShadowWhenHighlighted = YES;
    [researchButton setTitle:@"Research" forState:UIControlStateNormal];
    [researchButton addTarget:self action:@selector(pressCharacter) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButton];
    [self.view addSubview:characterButton];
    [self.view addSubview:infoButton];
    [self.view addSubview:outlineButton];
    [self.view addSubview:researchButton];
    // Do any additional setup after loading the view from its nib.
    /*self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                              [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)],
                                              [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleBordered target:self action:@selector(showSelector)],
                                              nil];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
