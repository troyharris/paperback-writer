//
//  UIViewController+TDSemiModalExtension.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "UIViewController+TDSemiModalExtension.h"

@implementation UIViewController (TDSemiModalExtension)

// Use this to show the modal view (pops-up from the bottom)
- (void) presentSemiModalViewController:(TDSemiModalViewController*)vc {
    [self presentSemiModalViewController:vc inView:UIApplication.sharedApplication.delegate.window.rootViewController.view];
}

- (void) presentSemiModalViewController:(TDSemiModalViewController*)vc inView:(UIView *)rootView {

	UIView* modalView = vc.view;
	UIView* coverView = vc.coverView;
    
	coverView.frame = rootView.bounds;
    coverView.alpha = 0.0f;
    CGFloat height = 384.0;
    NSLog(@"%f", height);
    CGFloat top = (rootView.bounds.size.height - height) / 2;
    modalView.frame = CGRectMake(0, top, rootView.bounds.size.width, height);
//	modalView.center = self.offscreenCenter;
    modalView.alpha = 0.0;
	[rootView addSubview:coverView];
	[rootView addSubview:modalView];
	
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.6];
	
	//modalView.frame = CGRectMake(0, 10, modalView.frame.size.width, modalView.frame.size.height);
    modalView.alpha = 1.0;
	coverView.alpha = 0.8;
    
	[UIView commitAnimations];

}

-(void) dismissSemiModalViewController:(TDSemiModalViewController*)vc {
	double animationDelay = 0.7;
	UIView* modalView = vc.view;
	UIView* coverView = vc.coverView;
    

	[UIView beginAnimations:nil context:(__bridge void *)(modalView)];
	[UIView setAnimationDuration:animationDelay];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(dismissSemiModalViewControllerEnded:finished:context:)];
	
    //modalView.center = [self offscreenCenter];
    modalView.alpha = 0.0f;
	coverView.alpha = 0.0f;

	[UIView commitAnimations];

	[coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];

}

- (void) dismissSemiModalViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView* modalView = (__bridge UIView*)context;
	[modalView removeFromSuperview];

}

-(CGPoint) offscreenCenter {
    CGPoint offScreenCenter = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
	if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		offScreenCenter = CGPointMake(offSize.height / 2.0, 0.0f - (offSize.width * 1.5));
	} else {
		offScreenCenter = CGPointMake(offSize.width / 2.0, 0.0f - (offSize.height * 1.5));
	}
    
    return offScreenCenter;
}

-(CGPoint) offscreenTopCenterWithSize {
    CGPoint offScreenCenter = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
	if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		offScreenCenter = CGPointMake(offSize.height / 2.0, offSize.width * 1.5);
	} else {
		offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
	}
    
    return offScreenCenter;
}


@end
