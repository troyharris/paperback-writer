//
//  THUtil.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/24/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THUtil.h"

@implementation THUtil

+(CGFloat)getRealDeviceWidth {
    CGFloat deviceWidth;
     UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        deviceWidth = [UIScreen mainScreen].bounds.size.height;
    } else {
        deviceWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return deviceWidth;
}

+(CGFloat)getRealDeviceHeight {
    CGFloat deviceHeight;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        deviceHeight = [UIScreen mainScreen].bounds.size.width;
    } else {
        deviceHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return deviceHeight;
}

+(UIInterfaceOrientation)orientation {
    return [UIApplication sharedApplication].statusBarOrientation;
}

+(CGFloat)getViewBottomOrigin:(UIView *)view {
    return view.frame.origin.y + view.frame.size.height;
}

+(CGPoint)getViewRealCenter:(UIView *)view {
    CGPoint realCenter;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    realCenter = UIInterfaceOrientationIsLandscape(orientation) ? CGPointMake(view.center.y, view.center.x) : view.center;
    return realCenter;
}

+(UIColor *)getRandomColor:(NSArray *)colors {
    int amount = [colors count];
    int rand = arc4random() % amount;
    UIColor *luckyColor = (UIColor *)[colors objectAtIndex:rand];
    return luckyColor;
}

+(CGFloat)getFontSizeFromIPadFontSize:(CGFloat)fontSize {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        fontSize = fontSize / 2.591;
    }
    return fontSize;
}

+(CGFloat)getFontSizeFromIPhoneFontSize:(CGFloat)fontSize {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        fontSize = fontSize * 2.591;
    }
    return fontSize;
}

@end
