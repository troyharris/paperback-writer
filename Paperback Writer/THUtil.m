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

@end
