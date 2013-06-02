//
//  TDSemiModalViewController.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDSemiModalViewController.h"

@implementation TDSemiModalViewController
@synthesize coverView;

-(void)viewDidLoad {
    [super viewDidLoad];
	self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];

	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	coverView.backgroundColor = UIColor.blackColor;
	self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.coverView = nil;
}

-(void)fixYOriginWithRootView:(UIView *)rootView {
    CGFloat height = 384.0;
    NSLog(@"%f", height);
    CGFloat top = (rootView.bounds.size.height - height) / 2;
    CGRect tmpFrame = CGRectMake(self.view.frame.origin.x, top, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = tmpFrame;
}

@end
