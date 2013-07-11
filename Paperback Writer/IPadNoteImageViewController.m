//
//  IPadNoteImageViewController.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/11/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "IPadNoteImageViewController.h"
#import "THUtil.h"

@interface IPadNoteImageViewController ()

@end

@implementation IPadNoteImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [THUtil getRealDeviceWidth], [THUtil getRealDeviceHeight])];
        self.view = _imageView;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [_imageView setNeedsLayout];
}

@end
