//
//  THGridMenu.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenu.h"

@implementation THGridMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init {
    CGRect windowSize = [[UIScreen mainScreen] applicationFrame];
    _rotation = [UIApplication sharedApplication].statusBarOrientation;
    NSLog(@"rotation start is %d", _rotation);
    
    if (UIInterfaceOrientationIsLandscape(_rotation)) {
        NSLog(@"I AM A LANDSCAPE!");
        CGFloat width = windowSize.size.height;
        CGFloat height = windowSize.size.width;
        windowSize = CGRectMake(windowSize.origin.x, windowSize.origin.y, width, height);
    }
            NSLog(@"MY WIDTH IS %f", windowSize.size.width);
//    CGRect windowSize = [self superview].bounds;
    self = [super initWithFrame:windowSize];
    if (self) {
        self.backgroundColor = [[UIColor alloc] initWithRed:0.2 green:0.8 blue:0.7 alpha:1.0];
        self.scrollEnabled = YES;
        self.userInteractionEnabled = YES;
        self.contentSize = self.frame.size;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

-(id)initWithColumns:(int)col marginSize:(CGFloat)margin gutterSize:(CGFloat)gutter rowHeight:(CGFloat)height{
    self = [self init];
    if (self) {
        _columns = col;
        _marginSize = margin;
        _gutterSize = gutter;
        _rowHeight = height;
        _xOffset = gutter;
        _yOffset = gutter;
  //      [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  //      [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    }
    return self;
}

-(void)orientationChange {
 //   NSLog(@"Bound height is w: %f h: %f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGFloat deviceWidth;
    CGFloat lastHeight = 0;
    CGFloat newXOrigin = 0;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        NSLog(@"rotation is %d orientation is %d", _rotation, orientation);
    if (orientation != _rotation) {
        NSLog(@"rotating");
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            deviceWidth = [UIScreen mainScreen].bounds.size.height;
        } else {
            deviceWidth = [UIScreen mainScreen].bounds.size.width;
        }
        
        self.frame = CGRectMake(0, 0, deviceWidth, self.frame.size.height);
      //  NSLog(@"Window width is %f", deviceWidth);
        self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height);
        CGFloat newWidth = ((deviceWidth - (_gutterSize * 2)) / _columns) - (_marginSize * (_columns - 1) / _columns);
        NSMutableArray *newViews = [[NSMutableArray alloc] init];
        for (THGridMenuItem *view in self.subviews) {
            if (lastHeight == view.frame.origin.y) {
                newXOrigin = newXOrigin + _marginSize + newWidth;
       //         NSLog(@"same line");
            } else {
                newXOrigin = view.frame.origin.x;
                lastHeight = view.frame.origin.y;
            }
        //    NSLog(@"XOrigin is %f", newXOrigin);
            view.frame = CGRectMake(newXOrigin, view.frame.origin.y, newWidth, view.frame.size.height);
            [newViews addObject:view];
            [view removeFromSuperview];
        }
        for (THGridMenuItem *view in newViews) {
            [self addSubview:view];
        }
        _rotation = orientation;
    } else {
        NSLog(@"NOT ROTATING!!");
    }
}


-(THGridMenuItem *) createMenuItem {
/*    if ((_yOffset + _rowHeight) > self.contentSize.height) {
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height + _rowHeight + _marginSize);
        NSLog(@"content size height is: %f", self.contentSize.height);
    } */
    CGFloat adjustedMargin = (_marginSize * (_columns - 1) / _columns);
    CGFloat menuWidth = (self.frame.size.width - (_gutterSize * 2));
    CGFloat itemWidth = (menuWidth / _columns) - adjustedMargin;
    CGRect itemFrame = CGRectMake(_xOffset, _yOffset, itemWidth, _rowHeight);
    THGridMenuItem *item = [[THGridMenuItem alloc] initWithFrame:itemFrame];
    _columnInc++;
    if (_columnInc >= _columns) {
        _columnInc = 0;
        _yOffset = _yOffset + _rowHeight + _marginSize;
        _xOffset = _gutterSize;
        self.contentSize = CGSizeMake(self.contentSize.width, _yOffset);
    } else {
        _xOffset = _xOffset + _marginSize + itemWidth;
    }
 //   NSLog(@"item x: %f item y: %f", _xOffset, _yOffset);
    return item;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
