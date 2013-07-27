//
//  IPadNoteWebViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/26/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNoteWebViewController.h"
#import "THUtil.h"

@interface IPadNoteWebViewController ()

@end

@implementation IPadNoteWebViewController

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
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight])];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSURL *noteURL = [NSURL URLWithString:_url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:noteURL];
    [_webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
