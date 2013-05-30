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

@interface IPadProjectInformationViewController ()

@end

@implementation IPadProjectInformationViewController

-(AppDelegate *)ad {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
        self.view.backgroundColor = [UIColor projectBackgroundColor];
        self.view.autoresizesSubviews = YES;
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildProject];
    [self makeTitleField];
	// Do any additional setup after loading the view.
}

-(void)buildProject {
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
}

-(void)makeTitleField {
    
    CGRect titleFrame = CGRectMake(20, 20, [THUtil getRealDeviceWidth] - 40, 70);
    _projectTitle = [[UITextField alloc] initWithFrame:titleFrame];
    _projectTitle.font = [UIFont fontWithName:@"Lato-Light" size:60.0];
    _projectTitle.textColor = [UIColor projectDarkTextColor];
    _projectTitle.textAlignment = NSTextAlignmentCenter;
    _projectTitle.adjustsFontSizeToFitWidth = YES;
    _projectTitle.text = _project.title;
    [self.view addSubview:_projectTitle];
    _projectTitle.borderStyle = UITextBorderStyleNone;
    _projectTitle.backgroundColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated {
    GlobalProject *gp = [GlobalProject sharedProject];
    _project = gp.project;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
